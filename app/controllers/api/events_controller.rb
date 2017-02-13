class API::EventsController < API::ApplicationController
  load_and_authorize_resource
respond_to :json
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index


    if params[:due]
      time=params[:due]
      events=current_user.events.search_everywhere(time)
      attached=current_user.attached_events.search_everywhere(time)
      respond_to do |format|
        format.json { render json: events+attached }
      end

    elsif params[:interval]
      interval=params[:interval].scan(/\d/).join('').to_i
      events=current_user.events.where(time: Time.now..(Time.now+interval.day))
      attached=current_user.attached_events.where(time: Time.now..(Time.now+interval.day))
      respond_to do |format|
        format.json { render json: events+attached }
      end
    else
      events=current_user.events
      attached=current_user.attached_events
      render json: events+attached
    end
  end


  def show

   render json: @event

  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.events.create(event_params)
    respond_to do |format|
      if @event.save
        format.json { render json: @event }
      else
        format.json { render json: @event.errors }
      end
    end
  end


  def update
    respond_to do |format|
      if @event.update(event_params)
        format.json { render @event, status: :ok }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  protected


  private
  def set_event
    @event=Event.find(params[:id])
  end

  def event_params
    params.permit(:event, :place, :time, :description, :end_time)
  end
end
