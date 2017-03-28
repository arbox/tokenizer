# -*- coding: utf-8 -*-
# :title: A simple Tokenizer for NLP Tasks.
# :main: README.rdoc

# A namespace for all project related stuff.
module Tokenizer
  # Simple whitespace based tokenizer with configurable punctuation detection.
  class WhitespaceTokenizer
    # Default whitespace separator.
    FS = Regexp.new('[[:blank:]]+')

    # Characters only in the role of splittable prefixes.
    SIMPLE_PRE = ['¿', '¡']

    # Characters only in the role of splittable suffixes.
    SIMPLE_POST = ['!', '?', ',', ':', ';', '.']

    # Characters as splittable prefixes with an optional matching suffix.
    PAIR_PRE = ['(', '{', '[', '<', '«', '„']

    # Characters as splittable suffixes with an optional matching prefix.
    PAIR_POST = [')', '}', ']', '>', '»', '“']

    # Characters which can be both prefixes AND suffixes.
    PRE_N_POST = ['"', "'"]

    private_constant :FS

    # @param [Symbol] lang Language identifier.
    # @param [Hash] options Additional options.
    # @option options [Array] :pre Array of splittable prefix characters.
    # @option options [Array] :post Array of splittable suffix characters.
    # @option options [Array] :pre_n_post Array of characters with
    #   suffix AND prefix functions.
    def initialize(lang = :de, options = {})
      @lang = lang
      @options = {
        pre: SIMPLE_PRE + PAIR_PRE,
        post: SIMPLE_POST + PAIR_POST,
        pre_n_post: PRE_N_POST
      }.merge(options)
    end

    # @param [String] str String to be tokenized.
    # @return [Array<String>] Array of tokens.
    def tokenize(str)
      tokens = sanitize_input(str).split(FS)
      return [''] if tokens.empty?

      splittables = SIMPLE_PRE + SIMPLE_POST + PAIR_PRE + PAIR_POST + PRE_N_POST
      pattern = Regexp.new("[^#{Regexp.escape(splittables.join)}]+")
      #most accomodating url regex I found was here:
      #http://stackoverflow.com/a/24058129/4852737
      url_pattern = %r{(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+
                       (:([\d\w]|%[a-fA-f\d]{2,2})+)
                       ?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,63}(:[\d]+)?(\/([-+_~.\d\w]
                       |%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#
                       ([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?}
      output = []
      tokens.each do |token|
        if url_pattern.match(token)
          #if token is validated as a url, if last character is a splittable then split it out
          output << (splittables.include?(token[-1]) ?
                      [token[0...-1],token[-1]] : token)
        else
          output << partition_and_tokenize(token, pattern)
        end
      end

      output.flatten
    end

    alias process tokenize

    private

    # @param [String] str User defined string to be tokenized.
    # @return [String] A new modified string.
    def sanitize_input(str)
      str.chomp.strip
    end

    # @param [String] str string to be partitioned by regex pattern.
    # @param [Regexp] pattern regex pattern to partition str with.
    # @return [String] An array representing the partitioned string.
    def partition_and_tokenize str, pattern
      output = []
      prefix, stem, suffix = str.partition(pattern)
      output << prefix.split('') unless prefix.empty?
      output << stem unless stem.empty?
      output << suffix.split('') unless suffix.empty?
      output
    end
  end # class

  # @deprecated Use {WhitespaceTokenizer} instead.
  class Tokenizer < WhitespaceTokenizer
    def initialize(*args)
      warn '[Deprecated!] Use WhitespaceTokenizer instead.'
      super(*args)
    end
  end
end # module
