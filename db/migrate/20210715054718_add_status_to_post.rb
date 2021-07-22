# frozen_string_literal: true

class AddStatusToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :status, :integer, default: 0
    add_index :posts, :status
  end
end
