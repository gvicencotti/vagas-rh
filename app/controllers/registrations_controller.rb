class RegistrationsController < Devise::RegistrationsController
    
  def show
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    
    
    user_params = params.require(:user).permit(:email, :complete_name, :cpf,
    :phone_number, :biography)

    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end