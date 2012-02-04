module WordGuesser
  class Dictionary
    DICTIONARY_FILENAME = "lib/enable1.txt"

    def self.words
      unless @dictionary
        @dictionary = []
        File.open DICTIONARY_FILENAME do |file|
          file.each do |line|
            @dictionary << line.strip
          end
        end
      end
      @dictionary
    end
  end
end
