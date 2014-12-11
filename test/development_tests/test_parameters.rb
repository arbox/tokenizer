# -*- coding: utf-8 -*-
require 'test/unit'
require 'tokenizer'

class TestTokenizerDev < Test::Unit::TestCase

  def setup
    @en_tokenizer = Tokenizer::Tokenizer.new(:en, {PRE: [], POST: ['|']})
  end

  def test_tokenization_001
    result = @en_tokenizer.tokenize('testing| new')
    assert_equal(['testing', '|', 'new', ''], result)
  end

  def test_tokenization_002
    result = @en_tokenizer.tokenize('testing, new')
    assert_equal(['testing,', 'new', ''], result)
  end

  private
  def compare(exp_result, input)
    act_result = @de_tokenizer.tokenize(input)
    assert_equal(exp_result, act_result)
  end
end
