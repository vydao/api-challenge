Things you may want to cover:

* Ruby version
  - Ruby 2.3.1

* System dependencies
  - Rails 4.2.7
  - PostgreSQL

* Database initialization
```ruby
  rake db:create
  rake db:migrate
  rake db:seed #create category data
```

* How to run the test
  - Copy `datatabase.yml` and `secrects.yml` from `.example` files
  - Create new user in rails console and get token to access to API
  ```ruby
    user = User.create(name: 'dummy')
    user.auth_token #=> e0f57f7fc37d4074b7baad15fc2398e2 API Token
  ```
  - Create new expense with example json format
  ```json
  {
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
  }
  ```
  ```bash
  curl -i \
      -H "Content-Type: application/json" \
      -H "Authorization: Token token=%YOUR_API_TOKEN%" \
      -X POST -d '{"expense":{"issue_date": "15/05/2017","category_name": "Computer - Software","employee_name": "Ricky","employee_address": "1 Infinite Loop, Cupertino, CA 95014","description": "Buy Laptop","pre_tax_amount": "888.999","tax_name": "VAT","tax_amount": "33.33"}}' \
      http://localhost:3000/api/v1/expenses
  ```
  - Get total expenses by category
  ```bash
  curl -i \
      -H "Content-Type: application/json" \
      -H "Authorization: Token token=%YOUR_API_TOKEN%" \
      http://localhost:3000/api/v1/categories/Travel/total.json

  curl -i \
      -H "Content-Type: application/json" \
      -H "Authorization: Token token=%YOUR_API_TOKEN%" \
      http://localhost:3000/api/v1/categories/Computer%20-%20Networking/total.json
  ```