# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js, :json

  layout :set_layout

  protected

  def set_layout
    if user_signed_in?
      'application'
    else
      devise_controller? ? 'login' : 'application'
    end
  end
end
