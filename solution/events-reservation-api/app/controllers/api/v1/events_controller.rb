# frozen_string_literal: true

# EventsController which declare the api methodes for events
class Api::V1::EventsController < Api::V1::BaseController
  before_action :load_resource

  # GET /api/v1/characters
  def index
    render json: @event, each_serializer: Api::V1::EventSerializer, status: :ok
  end

  # POST /api/v1/events
  def create
    if @event.save
      render json: { message: "The event #{@event.name} has been created successfully."},
             status: 201
    else
      invalid_resource!(@event.errors)
    end
  end

  #=========================
  #   private methods here
  #=========================
  private

  def load_resource
    case params[:action].to_sym
    when :index
      @event = Event.all
    when :create
      @event = Event.new(create_params)
    end
  rescue ActiveRecord::SubclassNotFound
    api_error(status: :unprocessable_entity, errors: Event::EVENT_TYPE_MSG)
  rescue ActiveRecord::RecordNotFound
    not_found!
  end

  def create_params
    params.permit(
      :type,
      :speaker,
      :name,
      :location,
      :description,
      :max_participants,
      :start_time,
      :end_time
    )
  end
end
