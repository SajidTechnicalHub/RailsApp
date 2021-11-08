class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :count_total
  include ApplicationHelper

	include Pundit

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
           devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:fname, :lname, :email, :password, :status, :avatar)}

           devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:fname, :lname, :email, :password, :current_password, :status, :avatar)}
      end

  private
 
    def user_not_authorized
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    def initialize_session
      session[:cart] ||= []
    end

    def count_total
      session[:total] = 0
    end

    
end


