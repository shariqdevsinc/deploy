# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  has_one_attached :image, dependent: :destroy
  belongs_to  :parent, class_name: 'Comment', optional: true
  has_many    :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy,
                        inverse_of: :parent

  validates :name, :body, presence: true
end
