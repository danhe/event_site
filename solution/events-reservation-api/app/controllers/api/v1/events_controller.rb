# frozen_string_literal: true

# EventsController which declare the api methodes for events
class Api::V1::EventsController < Api::V1::BaseController
  before_action :load_resource

  # GET /api/v1/characters
  def index
    render json: { events: @event },
           each_serializer: Api::V1::EventSerializer, status: :ok
  end

  # GET /api/v1/characters/:id
  def show
    render json: @event,
           serializer: Api::V1::EventSerializer, status: :ok
  end
  
  # POST /api/v1/events
  def create
    if @event.save
      api_success(
        message: "The event #{@event.name} has been created successfully.",
        status: 201
      )
    else
      invalid_resource!(@event.errors)
    end
  end

  #=========================
  #   private methods here
  #=========================
  private

  # before action methode, to load resource
  def load_resource
    case params[:action].to_sym
    when :index
      @event = all_filterd_events
    when :show
      @event = Event.find_by_id(params[:id])
    when :create
      @event = Event.new(create_params)
    end
  rescue ActiveRecord::SubclassNotFound
    api_error(status: :unprocessable_entity, errors: Event::EVENT_TYPE_MSG)
  rescue ActiveRecord::RecordNotFound
    not_found!
  end

  # Get events according to the params
  # If having filters, filter the events with params
  # If not, get all events
  def all_filterd_events
    return Event.all if params[:text].blank?
    return filter_by_date if params[:by].to_sym == :date

    Event.all.where("#{params[:by]} LIKE ?", "%#{params[:text]}%")
  end

  # Filter events by date
  def filter_by_date
    start_at = params[:text].to_datetime
    end_at = params[:end_of_day].to_datetime

    Event.where(
      'start_time >= ? AND end_time <= ?',
      start_at,
      end_at
    )
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
