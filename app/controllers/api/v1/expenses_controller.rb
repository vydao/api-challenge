class Api::V1::ExpensesController < Api::V1::BaseController
  def index
    render json: Expense.all, status: 200
  end
end
