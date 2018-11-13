# frozen_string_literal: true

module Decidim
  module FileAuthorizationHandler
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::FileAuthorizationHandler::Admin

      routes do
        resource :censuses, only: [:show, :create, :destroy, :update]
      end

      initializer "decidim_file_authorization.add_admin_authorizations" do |_app|
        Decidim.configure do |config|
          config.admin_abilities += [
            "Decidim::FileAuthorizationHandler::Abilities::AdminAbility"
          ]
        end
      end

      initializer "decidim_file_authorization.add_admin_menu" do
        Decidim.menu :admin_menu do |menu|
          menu.item I18n.t("decidim.file_authorization_handler.admin.menu.census"),
                    decidim_file_authorization_handler_admin.censuses_path,
                    icon_name: "spreadsheet",
                    position: 7,
                    active: :inclusive,
                    if: can?(:read, Decidim::FileAuthorizationHandler::CensusDatum)
        end
      end
    end
  end
end
