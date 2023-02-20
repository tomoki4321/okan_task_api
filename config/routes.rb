Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth',controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions'
      }
      #リクエスト形式をjson以外受け付けない
      scope format: 'json' do
        resources :tasks do
          collection do
            post 'label_add'
          end
          member do
            get 'label_find'
          end
        end
      end
      devise_scope :api_v1_user do
        post "auth/guest_sign_in", to: "auth/sessions#guest_sign_in"
        post "auth/admin_sign_in", to: "auth/sessions#admin_sign_in"
        scope format: 'json' do
          namespace :admin do
            resources :users
          end
        end
      end
    end
  end
end
