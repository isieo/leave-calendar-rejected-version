class WelcomeController < ApplicationController
  before_filter :load_organization
   def index
    @first_date_of_month = params[:month] ? Date.parse(params[:month]) : Date.today.at_beginning_of_month
    @weeks_count = 5
    @days_count = 7
    @end_of_month = @first_date_of_month.end_of_month
    @date_buffer = @first_date_of_month.wday
  end
end

