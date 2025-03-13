class Entry < ApplicationRecord
  belongs_to :place
  belongs_to :user

  has_one_attached :uploaded_image  # Add this line to attach an image

  validates :title, presence: true
  validates :description, presence: true
  validates :occurred_on, presence: true
end
