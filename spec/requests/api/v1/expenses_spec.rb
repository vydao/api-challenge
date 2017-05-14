require 'rails_helper'

RSpec.describe 'Expenses API', type: :request do
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

  describe "POST #create" do
    before do
      @expenses_count = Expense.count
    end

    context "without valid token" do
      let(:params) do
        '{
          "expense": {
            "issue_date": "14/05/2017",
            "category_name": "Computer - Software",
            "employee_name": "Ricky",
            "employee_address": "1 Infinite Loop, Cupertino, CA 95014",
            "description": "Buy Laptop",
            "pre_tax_amount": "888.999",
            "tax_name": "VAT",
            "tax_amount": "33.33"
          }
        }'
      end

      it "unauthorize" do
        post api_v1_expenses_path(format: :json), params, headers_with_invalid_token

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status 401
      end
    end

    context "with valid params" do
      let(:params) do
        '{
          "expense": {
            "issue_date": "14/05/2017",
            "category_name": "Computer - Software",
            "employee_name": "Rick",
            "employee_address": "1 Infinite Loop, Cupertino, CA 95014",
            "description": "Buy Laptop",
            "pre_tax_amount": "888.999",
            "tax_name": "VAT",
            "tax_amount": "33.33"
          }
        }'
      end

      it "create new expense successfully" do
        post api_v1_expenses_path(format: :json), params, headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status 201
        expect(Expense.count - @expenses_count).to eq 1
      end
    end

    context "with empty params" do
      let(:params) do
        '{
          "expense": {
            "issue_date": "",
            "category_name": "Travel",
            "employee_name": "",
            "employee_address": "1 Infinite Loop, Cupertino, CA 95014",
            "description": "Buy Laptop",
            "pre_tax_amount": "",
            "tax_name": "VAT",
            "tax_amount": "33.33"
          }
        }'
      end

      it 'create new expense failed' do
        post api_v1_expenses_path(format: :json), params, headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status 422
        expect(@expenses_count).to eq Expense.count
      end
    end

    context "when category is invalid" do
      let(:params) do
        '{
          "expense": {
            "issue_date": "14/05/2017",
            "category_name": "Travel bac",
            "employee_name": "Son",
            "employee_address": "1600 Amphitheatre Parkway, Mountain View, CA 94043",
            "description": "Buy iphone",
            "pre_tax_amount": "300.000",
            "tax_name": "VAT",
            "tax_amount": "33.00"
          }
        }'
      end

      it 'create new expense failed' do
        post api_v1_expenses_path(format: :json), params, headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status 400
        expect(@expenses_count).to eq Expense.count
        expect(JSON.parse(response.body)["messages"]).to include "Category is invalid"
      end
    end
  end
end
