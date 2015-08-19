class Admin::UsersController < ApplicationController
  before_filter :restrict_access_admin

  def index
    @users = User.order("firstname").page(params[:page]).per(10)
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      UserMailer.delete_notification(user).deliver
    end
    redirect_to admin_users_path
  end

end
