CJK_CLASS = '\p{Han}\p{Katakana}\p{Hiragana}\p{Hangul}'
CJK_REGEX = %r![#{CJK_CLASS}]!o
WORD_REGEX = %r![^#{CJK_CLASS}\s]+!o

module Jekyll
  module Filters
    def number_of_words(input)
      cjk_count = input.scan(CJK_REGEX).length
      return input.split.length if cjk_count.zero?
      cjk_count + input.scan(WORD_REGEX).length
    end
  end
end
