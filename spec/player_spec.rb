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
end
