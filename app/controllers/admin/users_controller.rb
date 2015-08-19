class Admin::UsersController < ApplicationController
  before_filter :restrict_access

  def index
    @users = User.order("firstname").page(params[:page]).per(10)
  end

end
