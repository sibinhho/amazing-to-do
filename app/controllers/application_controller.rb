class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user
    WillPaginate.per_page = 8

    private

    def search
    end

    def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
        render status: :unauthorized unless @current_user
    end
end
