# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Genre < ApplicationRecord
  class Entity < BaseEntity
    attributes :id, :name, :movies
  end

  has_many :movies
end
