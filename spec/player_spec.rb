require 'json'
require_relative '../lib/serializable'
require_relative '../lib/game/player'

describe Player do
  describe '#verify_input' do
    subject(:player_verify) { described_class.new(1) }

    context 'when valid input is given' do
      it 'returns true' do
        valid_input = 'a1'
        expect(player_verify.verify_input(valid_input)).to eql(true)
      end
    end

    context 'when invalid input is given' do
      it 'returns false' do
        invalid_input = 'j2'
        expect(player_verify.verify_input(invalid_input)).to eql(false)
      end
    end
  end

  describe '#coordinates' do
    subject(:player_coordinate) { described_class.new(1) }
    it 'returns coordinate equivalent of string' do
      string = 'a4'
      coordinates = [3, 0]
      expect(player_coordinate.coordinates(string)).to eql(coordinates)
    end

    it 'returns coordinate equivalent of string' do
      string = 'd1'
      coordinates = [0, 3]
      expect(player_coordinate.coordinates(string)).to eql(coordinates)
    end
  end
end
