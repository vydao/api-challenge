class Category < ActiveRecord::Base
  has_many :expenses, dependent: :destroy

  validates :name, presence: true
end
