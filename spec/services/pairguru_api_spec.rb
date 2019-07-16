require "rails_helper"

describe "PairguruApi" do
  let(:service) { ::PairguruApi.new }

  describe "API" do
    it "movie_info" do
      expect(service).to receive(:request).with('/movies/Godfather')

      service.movie_info('Godfather')
    end
  end
end
