class ApplicationController < ActionController::Base
  include Authentication
  before_action :set_locale
  allow_browser versions: :modern

  private

    def set_locale
      I18n.locale = I18n.available_locales.include?(params[:locale]&.to_sym) ? params[:locale] : I18n.default_locale
    end
end
