require 'spec_helper'

describe WordGuesser::WordGuesser do
  let(:word_guesser) { described_class.new base_word, letters }

  describe "#all_combinations" do
    subject { word_guesser.all_combinations }
    let(:letters) { ['a', 'r'] }

    context "when there is a _ at the start" do
      let(:base_word) { "_oo" }
      its(:to_set) { should == ["aoo", "roo"].to_set }
    end

    context "when there is a _ in the middle" do
      let(:base_word) { "f_o" }
      its(:to_set) { should == ["fao", "fro"].to_set }
    end

    context "when there is a _ at the end" do
      let(:base_word) { "fo_" }
      its(:to_set) { should == ["foa", "for"].to_set }
    end

    context "when there is no _" do
      let(:base_word) { "foo" }
      its(:to_a) { should == [base_word] }
    end
  end

  describe "#real_combinations" do
    subject { word_guesser.real_combinations }
    let(:base_word) { "b__"}
    let(:letters) { [*('a'..'z')] }
    let(:dictionary) { %w[foo bar baz biz hello world] }

    before { WordGuesser::Dictionary.stub(:words).and_return dictionary }

    its(:class) { should == WordGuesser::WordCollection }
    it { subject.instance_variable_get(:@base_word).should == base_word }
    it do
      subject.instance_variable_get(:@words).to_set.should == Set.new(%w[bar baz biz])
    end
  end
end
