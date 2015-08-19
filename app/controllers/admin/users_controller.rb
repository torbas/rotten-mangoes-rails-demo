class Admin::UsersController < ApplicationController
  before_filter :restrict_access_admin

  def index
    @users = User.order("firstname").page(params[:page]).per(10)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end

end
