class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  skip_before_action :authenticate_user, only: [:new, :create]

  # POST /resource
  def create
    build_resource(sign_up_params)
    # Give user a random password
    random_password = Devise.friendly_token.first(8).downcase
    resource.password = random_password

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
      # Send welcome email
      UserMailer.delay.welcome(resource, random_password)
    else
      @communities = params[:user][:community_ids]
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.for(:account_update))
    else
      # remove the virtual current_password attribute update_without_password
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.for(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed - extend this as needed
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :community_ids)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :current_password, :community_ids)
    end
  end
end