class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        include ActionController::Cookies
        before_action :configure_permitted_parameters, if: :devise_controller?

        before_action do
          I18n.locale = :ja
        end

        #nameを許可
        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        end
end
