require 'minitest/autorun'
require 'tokenizer'

class TestTokenizer < Minitest::Unit

  def setup
    @de_tokenizer = Tokenizer::Tokenizer.new(:de)
  end

  def test_constants
    assert(Tokenizer::VERSION.is_a?(String) && Tokenizer::VERSION.any?)
  end

  def test_output_type
    output = @de_tokenizer.tokenize('ich gehe in die Schule')
    assert(output.is_a?(Array))
  end

  def test_tokenization_001
    input = 'ich ging? du, und ich nicht (konnte nicht)? Warum?!!'
    etalon = %w{ ich ging ? du , und ich nicht ( konnte nicht ) ? Warum ? ! !}
    output = @de_tokenizer.tokenize(input)
    assert_equal(etalon, output)
  end
end
