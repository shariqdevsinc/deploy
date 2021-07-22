# frozen_string_literal: true

class AddParentToComment < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :parent, foreign_key: { to_table: :comments }, index: true
  end
end
