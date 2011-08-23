lib_path = File.expand_path('../lib', __FILE__) # strange??
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)
begin
  require 'rake'
rescue LoadError
  require 'rubygems'
  require 'rake'
end

# we can require 'rake/clean' to add 'clobber' and 'clean' tasks
require 'rake/clean'



SRC = FileList['**/*.rb']

CLOBBER.include('doc', '**/*.html', '**/*.gem')

# testing
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList.new('test/**/*.rb').to_a
end

# Build the gem package
load 'tokenizer.gemspec'
require 'rubygems/package_task'
Gem::PackageTask.new(GEMSPEC).define

# Generate documentation
require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_files.include('*.rdoc', 'lib/**/*', 'bin/**/*')
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
