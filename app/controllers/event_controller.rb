class EventController < ApplicationController
  def index
    @events = Event.all
    render json: {events: @events}
  end

# Additionally the API should
# require that there is a key named “name” and a key named “event_type” in each blob of data sent. If those
# keys aren’t present the api returns HTTP status 422 and an error message indicating the missing key(s).

# Respond with HTTP success when the event is successfully created and stored in the database.

# Example of incoming data:
# {
# 	"event": {
# 	"name": "test button",
# 	"event_type": "click"
# 	}
# }

# What the curl request looks like:
# curl -X POST --header 'Content-Type: application/json' --data '{"event" : {"name" : "test button", "event_type" : "click", "at" : "2020-06-12T00:00:01", "button_color" : "red" }}' http://localhost:3333/events
# curl -X GET http://localhost:3333/events/stats/

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

# Add another endpoint for todays stats. This endpoint takes all the events received today, groups them
# by event_type and returns the count for each. The response should be JSON (e.g.: { "todays_stats" :
# [{"click" : 34}, {"view": 54}]} )

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
