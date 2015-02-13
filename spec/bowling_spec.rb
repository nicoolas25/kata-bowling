require 'spec_helper'

describe Line do
  describe '#score' do
    subject { described_class.new(line).score }

    context 'when doing only strikes' do
      let(:line) { 'XXXXXXXXXXXX' }
      it { is_expected.to eq 300 }
    end

    context 'when doing only empty shots' do
      let(:line) { '--------------------' }
      it { is_expected.to eq 0 }
    end

    context 'when doing 9 and empty each frame' do
      let(:line) { '9-9-9-9-9-9-9-9-9-9-' }
      it { is_expected.to eq 90 }
    end

    context 'when doing 5 and spare each frame' do
      let(:line) { '5/5/5/5/5/5/5/5/5/5/5' }
      it { is_expected.to eq 150 }
    end

  end
end
