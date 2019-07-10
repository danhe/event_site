class Api::V1::EventSerializer < Api::V1::BaseSerializer
  attributes(*Event.attribute_names.map(&:to_sym))
end
