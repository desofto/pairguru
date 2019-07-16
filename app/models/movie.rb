# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  class Entity < BaseEntity
    attributes :id, :title, :description, :genre
  end

  belongs_to :genre

  def external_info
    @external_info ||= pairguru_api.movie_info(title)
  end

  private

  def pairguru_api
    @pairguru_api ||= ::PairguruApi.new
  end
end
