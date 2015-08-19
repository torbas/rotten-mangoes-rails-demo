class Admin::UsersController < ApplicationController
  before_filter :restrict_access_admin

  def index
    @users = User.order("firstname").page(params[:page]).per(10)
  end

end
