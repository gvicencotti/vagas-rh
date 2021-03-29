class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

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

  def create
    user_params = params.require(:user).permit(:role, :email, :password)
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      render 'new'
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
