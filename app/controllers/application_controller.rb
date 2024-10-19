class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    rescue_from StandardError, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    
    def render_404(exception)
      logger.error "404だよ: #{exception.message}" if exception
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
    
    def render_500(exception)
      logger.error "500だよ: #{exception.message}" if exception
      render file: "#{Rails.root}/public/500.html", status: :internal_server_error, layout: false
    end
  end
  