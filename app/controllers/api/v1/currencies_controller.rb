module Api
  module V1
    class CurrenciesController < ApplicationController
      before_action :authorize_request
      
      def index
        @currencies = Currency.order(:id)
      end 
       
      def show
        @currency = Currency.find(params[:id])
      end 
    end
  end
end