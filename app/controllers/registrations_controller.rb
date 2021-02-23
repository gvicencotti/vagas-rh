class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)
    
    
    user_params = params.require(:user).permit(:email, :complete_name, :cpf,
    :phone_number, :biography)

    if @user.update(user_params)
      redirect_to edit_user_registration_path
    else
      render :edit
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end