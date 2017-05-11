class Expense < ActiveRecord::Base
  belongs_to :category

  validates :issue_date, presence: true
  validates :category, presence: true
  validates :employee_name, presence: true
  validates :pre_tax_amount, presence: true
  validates :after_tax_amount, presence: true
end
