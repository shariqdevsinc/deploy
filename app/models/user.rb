# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy, inverse_of: :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :lockable
end
