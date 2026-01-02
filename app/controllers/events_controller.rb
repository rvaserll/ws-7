class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    events = Event.where(storage_method: "localstorage").order(:number).map do |event|
    immediate_event = Event.where(storage_method: "immediate", number: event.number).first
      {
        number: event.number,
        message: event.message,
        client_time: immediate_event.client_time,
        server_time: event.server_time,
        diff: (immediate_event.server_time - event.client_time).round(5),
        storage_method: event.storage_method
      }
    end
    render json: events
  end

  def create
    Event.create(
      number: params[:number],
      message: params[:message],
      client_time: params[:client_time],
      server_time: Time.current,
      storage_method: "immediate"
    )
    head :ok
  end

  def batch_create
    events = params[:events] || []

    events.each do |event_data|
      Event.create(
        number: event_data[:number],
        message: event_data[:message],
        client_time: event_data[:client_time],
        server_time: Time.current,
        storage_method: "localstorage"
      )
    end

    render json: { success: true, count: events.length }
  end

  def purge
    Event.delete_all
    head :ok
  end
end
