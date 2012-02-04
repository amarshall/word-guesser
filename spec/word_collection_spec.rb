require 'spec_helper'

describe WordGuesser::WordCollection do
  let(:word_collection) { described_class.new base_word, words }
  let(:base_word) { stub }
  let(:words) { stub Set }

  describe "#in_dictionary" do
    subject { word_collection.in_dictionary }
    let(:words) { %w[foo bar baz goodbye whirl] }
    let(:dictionary) { %w[foo bar hello world] }

    before { WordGuesser::Dictionary.stub(:words).and_return dictionary }

    its(:class) { should == WordGuesser::WordCollection }
    it { subject.instance_variable_get(:@base_word).should == base_word }
    it do
      collection_words = subject.instance_variable_get(:@words).to_set
      collection_words.subset?(words.to_set).should be_true
      collection_words.subset?(dictionary.to_set).should be_true
      (dictionary.to_set + words.to_set).superset?(collection_words).should be_true
    end
  end

  describe "#guessed_letter_frequency" do
    subject { word_collection.guessed_letter_frequency }
    let(:base_word) { "h___o" }
    let(:words) { %w[hallo helio hello hillo hippo hullo hydro] }

    it do
      should == { 'l' => 9, 'i' => 3, 'e' => 2, 'p' => 2, 'r' => 1,
                  'u' => 1, 'y' => 1, 'd' => 1, 'a' => 1 }
    end
  end

  describe "#size" do
    subject { word_collection.size }
    let(:word_collection) { described_class.new(stub, words) }
    let(:size) { double }

    it do
      words.should_receive(:size).and_return size
      should == size
    end
  end
end
