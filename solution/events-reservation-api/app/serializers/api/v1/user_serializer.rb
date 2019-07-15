class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :name, :role, :created_at, :updated_at, :token
end
