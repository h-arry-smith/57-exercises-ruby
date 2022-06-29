require 'net/http'
require 'json'
require_relative '../whos_in_space'

TEST_DATA = {
  message: 'success',
  number: 3,
  people: [
    { name: 'Oleg Artemyev', craft: 'ISS' },
    { name: 'Denis Matveev', craft: 'ISS' },
    { name: 'Cai Xuzhe', craft: 'Tiangong' }
  ]
}

RSpec.describe WhosInSpaceApi do
  describe '#data' do
    it 'returns a object with the correcr shape' do
      # Would liked to have used webmock but cant download on the ferry
      allow(Net::HTTP).to receive(:get).and_return(TEST_DATA.to_json)

      response = WhosInSpaceApi.data

      expect(response).to have_key(:message)
      expect(response).to have_key(:number)
      expect(response).to have_key(:people)
      expect(response[:people]).to be_kind_of(Array)
    end
  end

  describe '#number_of_people_in_space' do
    it 'returns an integer of the number of people in space' do
      allow(Net::HTTP).to receive(:get).and_return(TEST_DATA.to_json)

      expect(WhosInSpaceApi.number_of_people_in_space).to eq(3)
    end
  end

  describe '#people_in_space' do
    it 'returns an integer of the number of people in space' do
      allow(Net::HTTP).to receive(:get).and_return(TEST_DATA.to_json)

      expect(WhosInSpaceApi.people_in_space).to eq([
        { name: 'Oleg Artemyev', craft: 'ISS' },
        { name: 'Denis Matveev', craft: 'ISS' },
        { name: 'Cai Xuzhe', craft: 'Tiangong' }
      ])
    end
  end

  describe '#people_in_space_by_craft' do
    it 'returns an integer of the number of people in space' do
      allow(Net::HTTP).to receive(:get).and_return(TEST_DATA.to_json)

      expect(WhosInSpaceApi.people_in_space_by_craft).to eq({
        'ISS' => [
          { name: 'Oleg Artemyev', craft: 'ISS' },
          { name: 'Denis Matveev', craft: 'ISS' }
        ],
        'Tiangong' => [
          { name: 'Cai Xuzhe', craft: 'Tiangong' }
        ]
      })
    end
  end
end
