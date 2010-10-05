require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"

spec = Gem::Specification.new do |s|
  s.name              = "tw-studios-jruby-prof"
  s.version           = "0.1.1"
  s.summary           = "A Ruby level profiler for JRuby"
  s.author            = "Daniel Lucraft"
  s.email             = "dan@fluentradical.com"
  s.homepage          = "http://danlucraft.com/blog"
  s.has_rdoc          = false
  s.files             = %w(README) + 
                        Dir.glob("{lib/**/*}") + 
                        Dir.glob("{templates/**/*}") + 
                        Dir.glob("{examples/**/*}") + 
                        Dir.glob("{src}/**/*") + 
                        Dir.glob("{test}/**/*")
  s.require_paths     = ["lib"]
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

# Generate documentation
Rake::RDocTask.new do |rd|
  rd.main = "README"
  rd.rdoc_files.include("README", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm_rf "#{spec.name}.gemspec"
end

desc "create a jar"
task :jar do
  rm_rf 'lib/jruby-prof.jar'
  raise 'Please define JRUBY_JAR to point to the jruby jar' unless ENV['JRUBY_JAR']
  sh "ant -Djruby.jar=#{ENV['JRUBY_JAR']}"
  cp 'dist/jruby-prof.jar', 'lib'
end

desc "Package a gem"
task :default => [:clean, :jar, :gem]
