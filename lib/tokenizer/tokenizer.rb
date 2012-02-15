# -*- coding: utf-8 -*-

# :title: A simple Tokenizer for NLP Tasks.
# :main: README.rdoc

# A namespace for all project related stuff.
module Tokenizer

  class Tokenizer
    FS = Regexp.new('[[:blank:]]+')
#    PRE = '[{(\\`"‚„†‡‹‘’“”•–—›'
#    POST = %w| ] } ' ` " ) , ; : \ ! \ ? \ % ‚ „ … † ‡ ‰ ‹ ‘ ’ “ ” • – — › |
    
    SIMPLE_PRE = [] # spanish marks
    PAIR_PRE = ['(', '{', '[']
    SIMPLE_POST = ['!', '?', ',', ':', ';', '.']
    PAIR_POST = [')', '}', ']']
    PRE_N_POST = ['"', "'"]

    PRE = SIMPLE_PRE + PAIR_PRE
    POST = SIMPLE_POST + PAIR_POST
    
    def initialize(lang=:de)
      @lang = lang
      @braces = []
    end

    def tokenize(str)
      tokens = []
      token = ''
      output = ''
      fields = str.chomp.split(FS)
#      puts "Fields: #{fields}"
      if fields.empty?
        return [""]
      end
      
      fields.each do |field|
        field.each_char.with_index do |ch, idx|
          case
          when PRE.include?(ch)
            output << "#{ch}\n"
          when POST.include?(ch)
            output << "\n#{ch}"
            if ['?', '!', '.'].include?(ch)
              output << "\n"
            end
          when PRE_N_POST.include?(ch)
            if idx == 0
              output << "#{ch}\n"
            elsif idx != 0
              output << "\n#{ch}"
            end
          else
            output << ch
          end
        end
       output << "\n"
      end
#      puts "String: #{output.inspect}"
      out = output.split("\n", -1)
#      puts "Output: #{out}"

      out
    end

  end # class

end # module
