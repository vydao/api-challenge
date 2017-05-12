class Api::V1::ExpensesController < Api::V1::BaseController
  def index
    render json: Expense.all, status: 200
  end

  def create

  end

  private

  def expense_params
    params.permit(:expenses)
  end
end
