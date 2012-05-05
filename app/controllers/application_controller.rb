class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :my_redirect
  before_filter :check_user_organization
  
  def my_redirect
    redirect_to new_organization_path
  end
  
  private
  def load_organization
    subdomain = request.subdomain
    domain = request.domain
    
    if subdomain.empty?
      @organization = Organization.where(:domain => domain).first
    elsif domain == "leavecalendar.com" && !subdomain.empty?
      @organization = Organization.where(:subdomain => subdomain).first
    else
      full_domain = ""
      full_domain += "#{subdomain}." if !subdomain.empty?
      full_domain += "#{domain}" 
      @organization = Organization.where(:domain => full_domain).first
    end

    if !@organization || @organization.nil?
      redirect_to new_user_session_path
    end
  end
  
  def check_user_organization
    if !current_user.nil? && current_user.organization == nil
      redirect_to new_organization_path
    end
  end
  
end
