class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date :issue_date, null: false
      t.references :category, index: true, foreign_key: true
      t.string :employee_name, null: false
      t.string :employee_address
      t.text :description
      t.float :pre_tax_amount, null: false
      t.string :tax_name
      t.float :tax_amount
      t.float :after_tax_amount, null: false

      t.timestamps null: false
    end
  end
end
