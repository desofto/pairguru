class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    poster_url = external_info && external_info.dig('attributes', 'poster')
    if poster_url
      "https://pairguru-api.herokuapp.com#{poster_url}"
    else
      "http://lorempixel.com/100/150/" +
        %w[abstract nightlife transport].sample +
        "?a=" + SecureRandom.uuid
    end
  end
end
