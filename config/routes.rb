Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :expenses , only: [:create] do
        collection do
          get 'total/:category_name' => 'expenses#total', as: 'total'
        end
      end
    end
  end
end
