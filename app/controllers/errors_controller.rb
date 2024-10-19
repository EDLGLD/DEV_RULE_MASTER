class ErrorsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:not_found]
  
    def not_found
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end

    def internal_server_error
        render file: "#{Rails.root}/public/500.html", status: :internal_server_error, layout: false
    end
  end