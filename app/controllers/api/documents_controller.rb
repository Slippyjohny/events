class API::DocumentsController < API::ApplicationController
  load_and_authorize_resource :event
  load_and_authorize_resource :document, :through => :event, :shallow => true

  before_action :set_event, only: [:create]
  before_action :set_document, only: [:destroy]

  def show
    @document=Document.find(params[:id])
    send_file @document.attachment.path
  end

  def new
    @event = Event.find(params[:event_id])
    @document=@event.documents.build
  end

  def create
    @document=@event.documents.build(document_params)
    @document.user_id=current_user.id
    respond_to do |format|
      if @document.save
        format.json { render json: @document }

      else
        format.json { render json: @document.errors }
      end
    end
  end

  def destroy
    @document.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end


  private
  def set_document
    @document=Document.find(params[:id])
  end

  def set_event
    @event=Event.find(params[:event_id])
  end

  def document_params
    params.require(:document).permit(:name, :attachment)
  end
end

