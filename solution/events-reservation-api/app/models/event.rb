# frozen_string_literal: true

# Event class, which is the main model of application
# It permet only some participants to attend with some attributes
class Event < ApplicationRecord
  IN_THE_SAME_DAY_MSG = 'Start time and end time of event must be in a same day'
  VALID_DURATION_MSG = 'End time must be a time after the start time of event. ' +
                       'We need a valid duration of event'
  EVENT_TYPE_MSG = 'Only WorkShop and OfficeHour as event type are allowed'

  validates :name, :type, :start_time, :end_time, presence: true

  # Events are not multi-day and can occur anytime in a 24hr day.
  validate :event_must_during_in_a_24hr_day,
           :start_time_must_before_end_time

  private

  # Validation methode
  # Check the start_time and end_time of event is in a 24hr day
  def event_must_during_in_a_24hr_day
    return if start_time&.to_date == end_time&.to_date

    errors.add(:start_time, IN_THE_SAME_DAY_MSG)
  end

  # Validation methode
  # Check if start_time is before end_time of event
  def start_time_must_before_end_time
    return if !start_time.nil? && !end_time.nil? && end_time > start_time

    errors.add(:end_time, VALID_DURATION_MSG)
  end
end
