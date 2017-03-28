# coding: utf-8
require 'minitest/autorun'
require 'minitest/spec'
require 'tokenizer'

class TestTokenizerUrls < Minitest::Test
  def setup
    @t = Tokenizer::WhitespaceTokenizer.new(:de)
  end

  def test_url_tokenization_001
    assert_equal(@t.tokenize('test url www.google.com.'),
                 ['test','url','www.google.com','.'])
  end

  def test_url_tokenization_002
    assert_equal(@t.tokenize('test url www.google.com.au.'),
                 ['test','url','www.google.com.au','.'])
  end

  def test_url_tokenization_003
    assert_equal(@t.tokenize('test url http://www.google.com.au.'),
                 ['test','url','http://www.google.com.au','.'])
  end

  def test_url_tokenization_004
    assert_equal(@t.tokenize('test url https://www.google.com.au.'),
                 ['test','url','https://www.google.com.au','.'])
  end

  def test_url_tokenization_005
    assert_equal(@t.tokenize('test url ftp://www.google.com.au.'),
                 ['test','url','ftp://www.google.com.au','.'])
  end

  def test_url_tokenization_006
    assert_equal(@t.tokenize('test url Google.com.'),
                 ['test','url','Google.com','.'])
  end

  def test_url_tokenization_007
    assert_equal(@t.tokenize('test url Au.ac.'),
                 ['test','url','Au.ac','.'])
  end

  def test_url_tokenization_008
    assert_equal(@t.tokenize('test url google.com. Another sentence.'),
                 ['test','url','google.com','.','Another','sentence','.'])
  end

  def test_url_tokenization_009
    assert_equal(@t.tokenize('test url www.culture.gov.uk/heritage/search_frame.asp?name=/heritage/lib1.html another word.'),
                 ['test','url','www.culture.gov.uk/heritage/search_frame.asp?name=/heritage/lib1.html','another','word','.'])
  end

  def test_url_tokenization_010
    assert_equal(@t.tokenize('test url  www.culture.gov.uk/heritage/search_frame.asp?name=/heritage/lib1.html. Another sentence.'),
                 ['test','url','www.culture.gov.uk/heritage/search_frame.asp?name=/heritage/lib1.html','.','Another','sentence','.'])
  end
end


