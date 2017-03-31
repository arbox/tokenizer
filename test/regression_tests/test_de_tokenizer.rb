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

  def test_tokenization_003
    input = 'Try some code: test(this).'
    etalon = %w(Try some code : test ( this ) .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_004
    input = 'Try an email: test.email@example.com.'
    etalon = %w(Try an email : test.email@example.com .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_005
    input = "et souligne 'l'interrelation étroite de l'imagerie' avec le comportement."
    etalon = %w(et souligne ' l'interrelation étroite de l'imagerie ' avec le comportement .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_006
    input = 'Try some code: test(inner(brackets)also).'
    etalon = %w(Try some code : test ( inner ( brackets ) also ) .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_007
    input = 'Try some code: test[(inner(brackets)also)].'
    etalon = %w(Try some code : test [ ( inner ( brackets ) also ) ] .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_008
    input = "Check single quotes: 'quoted string'."
    etalon = %w(Check single quotes : ' quoted string ' .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_009
    input = "Check silly embedded single quotes: 'quoted 'embedded string' string'."
    etalon = %w(Check silly embedded single quotes : ' quoted ' embedded string ' string ' .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_010
    input = "Check quotes: ('test quotes')."
    etalon = %w(Check quotes : ( ' test quotes ' ) .)
    output = @t.tokenize(input)
    assert_equal(etalon, output)
  end

  def test_tokenization_011
    input = "Check quotes: (''test quotes'')."
    etalon = %w(Check quotes : ( ' ' test quotes ' ' ) .)
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
