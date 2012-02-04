module WordGuesser
  class WordCollection
    include Enumerable

    def initialize base_word, words
      @base_word = base_word
      @words = words
    end

    def guessed_letter_frequency
      frequencies = {}
      original_letters = @base_word.tr('_', '')
      @words.each do |word|
        word.tr(original_letters, '').each_char do |char|
          if frequencies.has_key? char
            frequencies[char] += 1
          else
            frequencies[char] = 1
          end
        end
      end

      frequencies
    end

    def in_dictionary
      WordCollection.new(@base_word, @words & Dictionary.words)
    end

    def each
      @words.each {|word| yield word }
    end

    def size
      @words.size
    end

    def to_s
      @words.to_a.join ', '
    end
  end
end
