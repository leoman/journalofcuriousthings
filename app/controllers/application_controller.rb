class ApplicationController < ActionController::Base
  include Clearance::Controller

  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  private

    def page_not_found
      render "errors/not_found", status: :not_found
    end
end
