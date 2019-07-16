require "rails_helper"

describe Movie do
  let(:service) { ::PairguruApi.new }

  it 'returns poster' do
    allow(service).to receive(:movie_info).with('Godfather') do
      {
        "id": "6",
        "type": "movie",
        "attributes": {
          "title": "Godfather",
          "plot": "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
          "rating": 9.2,
          "poster": "/godfather.jpg"
        }
      }
    end

    movie = Movie.new(title: 'Godfather')

    expect(movie.external_info['attributes']['poster']).to eq '/godfather.jpg'
  end
end
