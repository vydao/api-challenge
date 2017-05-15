module Api
  module V1
    class CategoriesController < BaseController
      before_action :authenticate!

      def total
        category = Category.find_by_name(params[:category_name])

        if category.nil?
          render json: { messages: "Category not found" }, status: 404
        else
          total_amount = category.expenses.sum(:after_tax_amount)
          render json: total_amount, status: 200
        end
      end
    end
  end
end
