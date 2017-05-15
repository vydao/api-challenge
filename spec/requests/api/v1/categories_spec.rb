require 'rails_helper'

RSpec.describe 'Category API', type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:headers) do
    {
      "CONTENT_TYPE" => "application/json",
      "Authorization" => "Token token=#{user.auth_token}"
    }
  end

  let(:headers_with_invalid_token) do
    {
      "CONTENT_TYPE" => "application/json",
      "Authorization" => "Token token=fake"
    }
  end

  describe "GET #total" do
    context "without valid token" do
      let(:category_name) { Category.first.name }

      it "unauthorize" do
        get api_v1_total_path(category_name: category_name, format: :json), nil, headers_with_invalid_token

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status 401
      end
    end

    context "valid token and invalid category" do
      let(:category_name) { "Computer - Networking" }

      it "return total" do
        get api_v1_total_path(category_name: category_name, format: :json), nil, headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status 404
        expect(JSON.parse(response.body)["messages"]).to include "Category not found"
      end
    end

    context "valid token and valid category" do
      let!(:expense_1) { FactoryGirl.create(:expense_1) }
      let!(:expense_2) { FactoryGirl.create(:expense_2) }
      let(:category_name) { expense_1.category.name }

      it "return total" do
        get api_v1_total_path(category_name: category_name, format: :json), nil, headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status 200
        expect(response.body.to_f).to eq(expense_1.after_tax_amount + expense_2.after_tax_amount)
      end
    end
  end
end
