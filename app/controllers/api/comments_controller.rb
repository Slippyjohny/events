class API::CommentsController < API::ApplicationController
  load_and_authorize_resource :event
  load_and_authorize_resource :comment, :through => :event, :shallow => true
  before_action :set_comment, only: [:destroy]
  before_action :set_event, only: [:create]


  def create
    @comment=@event.comments.build(comment_params)
    @comment.user_id=current_user.id
    respond_to do |format|
      if @comment.save
        format.json { render json: @comment }
      else
        format.json { render json: @comment.errors }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_event
    @event=Event.find(params[:event_id])
  end

  def comment_params
    params.permit(:body)
  end
end
