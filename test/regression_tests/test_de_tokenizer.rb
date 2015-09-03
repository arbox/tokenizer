require 'minitest/autorun'
require 'tokenizer'

class TestTokenizer < Minitest::Test

  def setup
    @de_tokenizer = Tokenizer::Tokenizer.new(:de)
  end

  def test_constants
    assert(Tokenizer::VERSION.is_a?(String) && !Tokenizer::VERSION.empty?)
  end

  def test_output_type
    output = @de_tokenizer.tokenize('ich gehe in die Schule')
    assert(output.is_a?(Array))
  end

  def test_tokenization_001
    input = 'Ich ging in die Schule!'
    etalon = %w(Ich ging in die Schule !)
    output = @de_tokenizer.tokenize(input)
    assert_equal(etalon, output)
  end
end
