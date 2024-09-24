class Users::RegistrationsController < Devise::RegistrationsController
  protected

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :role)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :name, :role)
    end
end
