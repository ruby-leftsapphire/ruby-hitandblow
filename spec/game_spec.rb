require_relative "../game"

RSpec.describe Game do
  describe "#initalize" do
    subject(:game) { Game.new(level:) }

    context "level設定が範囲外の場合" do
      let(:level) { 1 }

      it "エラーを返すこと" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#validate" do

  end

  describe ".generate_answer" do
    subject(:answer) { Game.new(level:).send(:generate_answer) }

    context "level設定が範囲内の場合" do
      let(:level) { 4 }

      it "設定した数の配列を返すこと" do
        expect(subject.count).to eq(level)
      end

      it "それぞれの数が0~9の範囲内であること" do
        subject.each do |number|
          expect(number).to be_between(0, 9)
        end
      end
    end
  end

  describe ".hit" do

  end

  describe ".blow" do

  end
end
