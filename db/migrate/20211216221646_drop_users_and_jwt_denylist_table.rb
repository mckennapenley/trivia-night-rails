# frozen_string_literal: true

class DropUsersAndJwtDenylistTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :users
    drop_table :jwt_denylist
  end
end
