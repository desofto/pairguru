class PairguruApi
  def movie_info(title)
    request("/movies/#{title}")
  end

  private

  def request(path)
    sha = Digest::SHA2.hexdigest(path)
    key = "PairguruApi-#{sha}"

    result = redis.get(key)

    if result.blank?
      begin
        result = Net::HTTP.get URI("https://pairguru-api.herokuapp.com/api/v1#{path}")
        redis.set(key, result, ex: 60)
      rescue URI::InvalidURIError
      end
    end

    result && JSON.parse(result)['data']
  end

  def redis
    @redis ||= ::Redis.new(host: 'localhost')
  end
end
