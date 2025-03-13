class Place < ApplicationRecord
  belongs_to :user
  has_many :entries, dependent: :destroy # ✅ Ensure this line is added
  validates :name, presence: true
end
