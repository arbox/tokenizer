# -*- encoding: utf-8 -*-
# We are still working on an elaborate short form of this spec.
# See the source code of Gem::Specification for futher details.

lib_path = File.expand_path('../lib', __FILE__) # strange??
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)
require 'tokenizer/version'
require 'rake' # for FileList

GEMSPEC = Gem::Specification.new do |s|
  s.name = "tokenizer"
  s.summary = 'Tokenizer is a linguistic tool intended to split a text into tokens.' # it is the description for 'gem list -d'
  s.description = 'A simple tokenizer for NLP tasks.' # it appears on the RubyGems page
  s.rubyforge_project = "tokenizer"
  s.version = Tokenizer::VERSION
  s.author = "Andrei Beliankou"
  s.email = "a.belenkow@uni-trier.de"
  s.homepage = "http://www.uni-trier.de/index.php?id=34451" # move on qa.uni
#  s.bindir = 'bin' # obsolete, default value
  s.executables << 'tokenize'
#  s.rdoc_options << '-m' << 'README.rdoc' # set it inside the documentation
  s.extra_rdoc_files = FileList['*.rdoc'].to_a
  s.add_development_dependency('rdoc')
  s.add_development_dependency('rake')
#  s.platform = Gem::Platform::RUBY # obsolete, default value.
  s.required_ruby_version = '>=1.9' # is it a correct notation?
  s.files = FileList['lib/**/*'].to_a
  s.test_files << 'test/test_tokenizer.rb'
end

__END__

##
# Files included in this gem.  You cannot append to this accessor, you must
# assign to it.
#
# Only add files you can require to this list, not directories, etc.
#
# Directories are automatically stripped from this list when building a gem,
# other non-files cause an error.

def files
  # DO NOT CHANGE TO ||= ! This is not a normal accessor. (yes, it sucks)
  @files = [@files,
            @test_files,
            add_bindir(@executables),
            @extra_rdoc_files,
            @extensions,
           ].flatten.uniq.compact
end
