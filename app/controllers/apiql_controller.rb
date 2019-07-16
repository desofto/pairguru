class ApiqlController < ApplicationController
  def index
    schema = ::APIQL.cache(params)
    render json: ::APIQLService.new(self, :session, :current_user, :params, :request).render(schema)
  end
end
