# frozen_string_literal: true

module Decidim
  module FileAuthorizationHandler
    module Admin
      class CensusesController < Decidim::Admin::ApplicationController
        def show
          authorize! :show, CensusDatum
          @status = Status.new(current_organization)
        end

        def create
          authorize! :create, CensusDatum
          if params[:file]
            if params[:unverify]
              remove_all_authorizations
            end
            data = CsvData.new(params[:file].path)
            CensusDatum.insert_all(current_organization, data.values)
            RemoveDuplicatesJob.perform_later(current_organization)
            flash[:notice] = t(".success", count: data.values.count,
                                           errors: data.errors.count)
          end
          redirect_to censuses_path
        end

        def destroy
          authorize! :destroy, CensusDatum
          CensusDatum.clear(current_organization)
          redirect_to censuses_path, notice: t(".success")
        end

        def delete_authorizations
          authorize! :update, CensusDatum
          remove_all_authorizations
          redirect_to censuses_path, notice: t(".success")
        end

        private

        def remove_all_authorizations
          Authorization.where(organization: current_organization, name: "file_authorization_handler").destroy_all
        end
      end
    end
  end
end
