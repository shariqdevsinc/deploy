# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many_attached :files, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validate :image_type

  enum status: { created: 0, published: 1, unpublished: 2 }

  private

  def image_type
    errors.add(:files, 'is missing! Must contain atleast one image') if files.attached? == false
    files.each do |image|
      unless image.content_type.in?(%('image/jpg image/png image/jpeg'))
        errors.add(:images, 'needs to be a JPG, JPEG or PNG format')
      end
    end
  end
end
