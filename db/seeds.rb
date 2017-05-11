categories = [
  'Travel',
  'Meals and Entertainment',
  'Computer - Hardware',
  'Computer - Software',
  'Office Supplies'
]

categories.each do |category|
  Category.find_or_create_by(name: category)
end