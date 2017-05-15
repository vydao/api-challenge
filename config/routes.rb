Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'expenses' => 'expenses#create'
      get 'categories/:category_name/total' => 'categories#total', as: 'total'
    end
  end
end
