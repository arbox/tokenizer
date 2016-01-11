# -*- coding: utf-8 -*-
# :title: A simple Tokenizer for NLP Tasks.
# :main: README.rdoc

# A namespace for all project related stuff.
module Tokenizer
  # Simple whitespace based tokenizer with configurable punctuation detection.
  class Tokenizer
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
      output = []
      tokens.each do |token|
        prefix, stem, suffix = token.partition(pattern)
        output << prefix.split('') unless prefix.empty?
        output << stem unless stem.empty?
        output << suffix.split('') unless suffix.empty?
      end

      output.flatten
    end

    alias process tokenize

    private

    # @param [String] User defined string to be tokenized.
    # @return [String] A new modified string.
    def sanitize_input(str)
      str.chomp.strip
    end
  end # class
end # module
