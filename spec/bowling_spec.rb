require 'spec_helper'

describe Line do
  describe '#score' do
    subject { described_class.new(line).score }

    context 'when doing only strikes' do
      let(:line) { 'XXXXXXXXXXXX' }

      it { is_expected.to eq 300 }
    end
  end
end
