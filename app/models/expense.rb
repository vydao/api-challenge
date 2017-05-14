class Expense < ActiveRecord::Base
  before_validation :calculate_after_tax_amount

  belongs_to :category

  validates :issue_date, presence: true
  validates :category, presence: true
  validates :employee_name, presence: true
  validates :pre_tax_amount, presence: true
  validates :after_tax_amount, presence: true

  def self.total_by_category(category_name)
    Category.where(name: category_name).joins(:expenses).sum('expenses.after_tax_amount')
  end

  private

  def calculate_after_tax_amount
    self.after_tax_amount = pre_tax_amount.to_f + tax_amount.to_f
  end
end
