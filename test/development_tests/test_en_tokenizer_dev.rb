# -*- coding: utf-8 -*-
require 'test/unit'
require 'tokenizer'

class TestTokenizerDev < Test::Unit::TestCase

  def setup
    @en_tokenizer = Tokenizer::Tokenizer.new(:en)
  end

  def test_tokenization_001
    result = @en_tokenizer.tokenize('testing normal, english sentence')
    assert_equal(['testing', 'normal', ',', 'english', 'sentence', ''], result)
  end

  private
  def compare(exp_result, input)
    act_result = @de_tokenizer.tokenize(input)
    assert_equal(exp_result, act_result)
  end
end
