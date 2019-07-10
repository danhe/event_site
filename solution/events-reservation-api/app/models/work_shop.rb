# frozen_string_literal: true

# WorkShop class, which is a event with type workshop
# It permet multiple participants to attend
class WorkShop < Event
  # A Workshop, where during a time frame
  #   multiple people can attend (in parallel)
  validates :max_participants, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }
end
