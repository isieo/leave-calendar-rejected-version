class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new
    @user.organization = current_user.organization
    @user.email = params[:user][:email]
    @user.name = params[:user][:name]
    @user.password = params[:user][:password]
    @user.in_department = params[:user][:in_department] - [""]
    @user.department_head_of = params[:user][:department_head_of] - [""]
    @user.authority_level = params[:user][:authority_level]
    if @user.save
      redirect_to admin_path, notice: 'User was successfully created, he/she can now login.' 
    else
      render action: "new" 
    end
  end
  
  
  
end
