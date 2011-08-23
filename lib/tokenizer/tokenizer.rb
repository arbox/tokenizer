# -*- coding: utf-8 -*-

# :title: A simple Tokenizer for NLP Tasks.
# :main: README.rdoc

# A namespace for all project related stuff.
module Tokenizer

  class Tokenizer
    FS = Regexp.new('[[:blank:]]+')
#    PRE = '[{(\\`"‚„†‡‹‘’“”•–—›'
#    POST = %w| ] } ' ` " ) , ; : \ ! \ ? \ % ‚ „ … † ‡ ‰ ‹ ‘ ’ “ ” • – — › |
    POST = %w{! ? , : ; . )}
    PRE = %w{(}

    def initialize(lang=:de)
      @lang = lang
    end

    def tokenize(str)
      tokens = []
      token = ''
      output = ''
      fields = str.split(FS)
      fields.each do |field|
        field.each_char do |ch|
         if POST.include?(ch)
            output << "\n#{ch}"
          elsif PRE.include?(ch)
            output << "#{ch}\n"
          else
            output << ch
          end
        end
        output << "\n"
      end
      output.split("\n")
    end

  end # class

end # module
