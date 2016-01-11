# coding: utf-8
require 'minitest/autorun'
require 'minitest/spec'
require 'tokenizer'

class TestTokenizer < Minitest::Test

  def setup
    @t = Tokenizer::Tokenizer.new(:de)
  end

  def test_constants
    assert(Tokenizer::VERSION.is_a?(String) && !Tokenizer::VERSION.empty?)
  end

  def test_output_type
    output = @t.tokenize('ich gehe in die Schule')
    assert(output.is_a?(Array))
  end

  def test_tokenization_001
    input = 'Ich ging in die Schule!'
    etalon = %w(Ich ging in die Schule !)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_002
    input = '" Es ist wirklich schwer zu sagen , welche Positionen er einnimmt , da er sich noch nicht konkret geäußert hat " , beklagen Volkswirte .'
    etalon = %w(" Es ist wirklich schwer zu sagen , welche Positionen er einnimmt , da er sich noch nicht konkret geäußert hat " , beklagen Volkswirte .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end
end

describe Tokenizer do
  describe 'empty input' do
    it 'should return an Array with an empty string' do
      tokens = Tokenizer::Tokenizer.new.tokenize('')
      tokens.must_equal([''])
    end
  end
end
