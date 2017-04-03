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
    PAIR_PRE = ['(', '{', '[', '<', '«', '„','“','‘']

    # Characters as splittable suffixes with an optional matching prefix.
    PAIR_POST = [')', '}', ']', '>', '»', '”']

    # Characters which can be both prefixes AND suffixes.
    PRE_N_POST = ['"','`']

    # Characters which can both prefixes and suffixes but are only a splittable
    # if at the beginning or end of a token with the exception of being prefixed/suffixed
    # by other splittables.
    # taking the single quote "'" as a PRE_N_POST_ONLY splittable,
    # The following would be valid uses as a splittable:
    # 'test quotes'
    # 'test quotes'. <- suffixed by another splittable
    # ('test quotes'). <- prefixed and suffixed by another splittable
    # The following would not be valid uses as a splittable:
    # l'interrelation
    # l'imagerie
    PRE_N_POST_ONLY = ["'","’"]

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
        pre_n_post: PRE_N_POST,
        pre_n_post_only: PRE_N_POST_ONLY
      }.merge(options)
    end

    # @param [String] str String to be tokenized.
    # @return [Array<String>] Array of tokens.
    def tokenize(str)
      tokens = sanitize_input(str).split(FS)
      return [''] if tokens.empty?

      splittables = (@options[:pre] + @options[:post] + @options[:pre_n_post]).flatten
      pattern = Regexp.new("[^#{Regexp.escape(splittables.join)}]+")
      pattern_prepostonly_pfix =
          Regexp.new("^[#{Regexp.escape((splittables + @options[:pre_n_post_only]).join)}]*[#{
          Regexp.escape(@options[:pre_n_post_only].join)}]+[#{
          Regexp.escape((splittables + @options[:pre_n_post_only]).join)}]*")
      pattern_prepostonly_sfix =
          Regexp.new("[#{Regexp.escape((splittables + @options[:pre_n_post_only]).join)}]*[#{
                         Regexp.escape(@options[:pre_n_post_only].join)}]+[#{
                         Regexp.escape((splittables + @options[:pre_n_post_only]).join)}]*$")
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
          #if prefix chars are PRE_N_POST_ONLY splittable then split
          prefix, stem, suffix = token.partition(pattern_prepostonly_pfix)
          output << stem.split('') unless stem.empty?
          token_remaining = stem.empty? ? prefix : suffix
          prefix, stem, suffix = token_remaining.partition(pattern)
          output << prefix.split('') unless prefix.empty?
          unless stem.empty?
            #if suffix chars are any splittable including PRE_N_POST_ONLY then split
            prefix, stem, suffix_discard = stem.partition(pattern_prepostonly_sfix)
            output << prefix unless prefix.empty?
            output << stem.split('') unless stem.empty?
          end
          #while suffix is not empty, take the first character as a splittable token,
          #and partition remaining suffix
          while suffix.length > 0
            prior_suffix = suffix
            output << suffix[0]
            prefix, stem, suffix = prior_suffix[1..-1].partition(pattern)
            output << prefix.split('') unless prefix.empty?
            output << stem unless stem.empty?
          end
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
  end # class

  # @deprecated Use {WhitespaceTokenizer} instead.
  class Tokenizer < WhitespaceTokenizer
    def initialize(*args)
      warn '[Deprecated!] Use WhitespaceTokenizer instead.'
      super(*args)
    end
  end
end # module
