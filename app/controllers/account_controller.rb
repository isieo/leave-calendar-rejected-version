class AccountController < ApplicationController
  before_filter :load_organization
  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today.at_beginning_of_month
    @user = current_user
    if @user != nil
      @request = @user.requests.all
      @leave_info = @user.leave_infos.all
    end
    
  end
end
