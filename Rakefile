lib_path = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

# Rake provides FileUtils and file lists.
require 'rake'
# clean and clobber tasks.
require 'rake/clean'

SRC = FileList['**/*.rb']

CLOBBER.include('doc', '**/*.html', '**/*.gem')

# Running tests.
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList.new('test/**/*.rb').to_a
end

# Generate documentation
require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_files.include('README',
                          'LICENSE',
                          'CHANGELOG',
                          'lib/**/*',
                          'bin/*'
                          )
  rdoc.rdoc_dir = 'rdoc'
end

# Custom gem building and releasing tasks.
require 'tokenizer/version'
desc 'Commit pending changes.'
task :commit do
end

desc 'Create a tag in the repository for the current release.'
task :tag do
end

desc "Build the gem package tokenizer-#{Tokenizer::VERSION}.gem"
task :build => :clobber do
  system 'gem build tokenizer.gemspec'
end

desc 'Deploy the gem package to RubyGems.'
task :release => [:commit, :tag, :build] do
  system "gem push tokenizer-#{Tokenizer::VERSION}.gem"
end


desc 'Open an irb session preloaded with this library.'
task :console do
  sh "irb -I lib -r tokenizer.rb"
end
