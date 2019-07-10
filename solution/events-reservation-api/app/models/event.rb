# frozen_string_literal: true

# Event class, which is the main model of application
# It permet only some participants to attend with some attributes
class Event < ApplicationRecord
  # Events are not multi-day and can occur anytime in a 24hr day.
  validate :event_must_during_in_a_24hr_day

  private

  # Validation methode
  # Check the start_time and end_time of event is in a 24hr day
  def event_must_during_in_a_24hr_day
    return if start_time.to_date == end_time.to_date

    errors.add(:start_time, 'and end time of event must be in a same day')
  end
end
