Rails.application.routes.draw do
  root to: 'books#index'

  resources :books do
    member do
      get :extra_curricular_activity
    end

    collection do
      get :double_render_error
      get :blocks_double_render_error
    end

  end
end
