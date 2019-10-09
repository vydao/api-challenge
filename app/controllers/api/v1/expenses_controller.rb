module Api
  module V1
    class ExpensesController < BaseController
      before_action :authenticate!
      before_action :validate_json, only: [:create]
      before_action :set_category, only: [:create]

      def create
        expense = Expense.new(expense_params.except(:category_name))
        expense.category_id = @category.id

        if expense.save
          render json: expense, status: 201
        else
          render json: { messages: expense.errors }, status: 422
        end
      end

      private

      def expense_params
        params.require(:expense).permit(
          :issue_date,
          :category_name,
          :employee_name,
          :employee_address,
          :description,
          :pre_tax_amount,
          :tax_name,
          :tax_amount,
          :company_id,
          :allow_pay
        )
      end

      def set_category
        @category = Category.find_by_name(expense_params[:category_name])
        render json: { messages: "Category is invalid" }, status: 400 if @category.nil?
      end

      def validate_json
        render nothing: true, status: 400 unless params.has_key?('expense')
      end
    end
  end
end
