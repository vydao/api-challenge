FactoryGirl.define do
  factory :expense_1, class: Expense do
    issue_date        "15/05/2017"
    category_id       2
    employee_name     "Mr A"
    employee_address  "1600 Amphitheatre Parkway, Mountain View, CA 94043"
    description       ""
    pre_tax_amount    "100000"
    tax_name          "VAT"
    tax_amount        "1000"
    after_tax_amount  "101000"
    created_at         Time.zone.now
    updated_at         Time.zone.now
  end

  factory :expense_2, class: Expense do
    issue_date        "16/04/2017"
    category_id       2
    employee_name     "Mr B"
    employee_address  "1600 Amphitheatre Parkway, Mountain View, CA 94043"
    description       "Buy chocolate"
    pre_tax_amount    "200200"
    tax_name          "VAT"
    tax_amount        "2000"
    after_tax_amount  "202200"
    created_at        Time.zone.now
    updated_at        Time.zone.now
  end
end
