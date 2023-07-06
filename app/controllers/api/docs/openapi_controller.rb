# frozen_string_literal: true

module API
  module Docs
    class OpenapiController < ApplicationController
      def show
        render :show
      end
    end
  end
end
