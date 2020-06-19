Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :students, controllers: {
        registrations: 'students/registrations',
        sessions: 'students/sessions'
      }

  devise_for :instructors, controllers: {
        registrations: 'instructors/registrations',
        sessions: 'instructors/sessions'
      }

  resources :instructors do
    collection do
      get :tomorrow
    end
  end

  resources :students

  resources :schedules, only: [:new, :create, :destroy, :index, :show] do
    collection do
      get :courses
    end
    resources :reservations do
      collection do
        get :personal
        get :group
      end
    end
    resources :meetings, only: [:new, :create]
  end

  resources :reservations

  resources :meetings do
    resources :reviews, only: [:new, :create, :index]
    resources :messages
  end

  resources :contacts, only: [:new, :create, :index]


  root "users#sign_up"
  get "/users/sign_in"
  get "/users/sign_up"
end
