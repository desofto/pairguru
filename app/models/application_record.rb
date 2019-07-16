class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class BaseEntity < ::APIQL::Entity
    def initialize(object, context)
      context.authorize! :read, object
      super(object, context)
    end
  end
end
