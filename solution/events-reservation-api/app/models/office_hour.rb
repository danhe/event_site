# frozen_string_literal: true

# OfficeHour class, which is a event with type OfficeHour
# It permet only one participant to attend
class OfficeHour < Event
  # An Office Hour, where during a time frame
  #  individual people can attend (in serial)
  validates :max_participants, equal_to: 1
end
