class EventController < ApplicationController
  def index
    @events = Event.all
    render json: {events: @events}
  end

  #
  # POST /events - create a new event
  # params:
  #   name: String
  #   event_type: String
  #
  def create
    @event = Event.new(event_params)
    name = params[:event][:name]
    event_type = params[:event][:event_type]

    if name == nil && event_type == nil
      render json: {error: "name and event_type are required", status: 422}
    elsif name == nil
      puts "name is nil"
      render json: {error: "name is required", status: 422}
    elsif event_type == nil
      puts "event_type is nil"
      render json: {error: "event_type is required", status: 422}
    else
      @event.save
      render json: {success: "event created"}
    end
  end

  #
  # GET /events/stats - get all of todays events and return the count for each event_type
  #
  def todays_stats
    @events = Event.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
    grouped_events = @events.group(:event_type).count
    render json: {todays_stats: grouped_events}
  end

  private
  def event_params
    params.require(:event).permit(:name, :event_type)
  end

end
