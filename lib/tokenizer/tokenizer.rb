# -*- coding: utf-8 -*-
# :title: A simple Tokenizer for NLP Tasks.
# :main: README.rdoc

# A namespace for all project related stuff.
module Tokenizer
  class Tokenizer
    FS = Regexp.new('[[:blank:]]+')

    # spanish marks
    SIMPLE_PRE = []
    PAIR_PRE = ['(', '{', '[', '<']
    SIMPLE_POST = ['!', '?', ',', ':', ';', '.']
    PAIR_POST = [')', '}', ']', '>']
    PRE_N_POST = ['"', "'"]

    PRE = SIMPLE_PRE + PAIR_PRE
    POST = SIMPLE_POST + PAIR_POST

    def initialize(lang = :de, options = {})
      @lang = lang
      @options = {
        pre: SIMPLE_PRE + PAIR_PRE,
        post: SIMPLE_POST + PAIR_POST,
        pre_n_post: PRE_N_POST
      }.merge(options)
    end

    def tokenize(str)
      output = ''

      fields = str.chomp.split(FS)

      return [''] if fields.empty?

      fields.each do |field|
        field.each_char.with_index do |ch, idx|
          case
          when @options[:pre].include?(ch)
            output << "#{ch}\n"
          when @options[:post].include?(ch)
            output << "\n#{ch}"
            if ['?', '!', '.'].include?(ch)
              output << "\n"
            end
          when @options[:pre_n_post].include?(ch)
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

      # @TODO: Rework the format of the string!
      output.chomp('').split("\n", -1)
    end
  end # class
end # module
