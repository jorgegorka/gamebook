class ApplicationController < ActionController::Base
  include Authentication
  before_action :set_locale
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = I18n.t("not_found")
    redirect_to root_path
  end

  private

    def set_locale
      I18n.locale = I18n.available_locales.include?(params[:locale]&.to_sym) ? params[:locale] : I18n.default_locale
    end
end
