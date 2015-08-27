lib_path = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'tokenizer/version'
require 'rake'

Gem::Specification.new do |s|
  s.name = 'tokenizer'
  s.summary = 'Tokenizer is a tool intended to split a text into tokens.'

  s.description = 'A simple multilingual tokenizer for NLP tasks. This tool '\
                  'provides a CLI and a library for linguistic tokenization '\
                  'which is an anavoidable step for many HLT (human language '\
                  'technology) tasks in the preprocessing phase for further '\
                  'syntactic, semantic and other higher level processing '\
                  'goals. Use it for tokenization of German, '\
                  'English and French texts.'
  s.rubyforge_project = 'tokenizer'
  s.version = Tokenizer::VERSION
  s.author = 'Andrei Beliankou'
  s.email = 'arbox@yandex.ru'
  s.homepage = 'https://github.com/arbox/tokenizer'
  s.executables << 'tokenize'
  s.extra_rdoc_files = FileList['*.rdoc'].to_a
  s.add_development_dependency('rdoc', '>=3.9.1')
  s.add_development_dependency('rake', '~> 10.3')
  s.add_development_dependency('yard')
  s.add_development_dependency('bundler')
  s.required_ruby_version = '>=1.8.7'
  s.files = FileList['lib/**/*.rb',
                     'README.rdoc',
                     'LICENSE.rdoc',
                     'CHANGELOG.rdoc',
                     '.yardopts',
                     'test/**/*',
                     'bin/*'].to_a
  s.test_files = FileList['test/**/*'].to_a
end
