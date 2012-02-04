require 'set'

module WordGuesser
  class WordGuesser
    def initialize base_word, letters_left
      @base_word = base_word.downcase
      original_letters = @base_word.tr('_', '').split('')
      letters_left = letters_left.uniq if letters_left.respond_to? :uniq
      @letters_left = letters_left.map {|l| l.downcase } - original_letters
    end

    def real_combinations
      words = []
      letters_group = "[#{Regexp.quote(@letters_left.join)}]"
      Dictionary.words.grep(/^#{@base_word.gsub(/_/, letters_group)}$/) do |word|
        words << word
      end

      WordCollection.new @base_word, words
    end

    def all_combinations
      words = []
      if @base_word.include? '_'
        ->(memo, groups, letters, this, &block) do
          groups = groups.clone
          current_group = groups.delete_at 0
          memo = memo + current_group
          if groups.any?
            letters.each do |letter|
              this.call(memo + letter, groups, letters, this, &block)
            end
          else
            block.call memo
          end
        end.tap do |inject_letters|
          inject_letters.call "", @base_word.split('_', -1), @letters_left, inject_letters do |word|
            words << word
          end
        end
      else
        words << @base_word
      end

      WordCollection.new @base_word, words
    end
  end
end
