class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :game_id, :score
end