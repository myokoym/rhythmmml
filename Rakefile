require "bundler/gem_tasks"

task :run do
  ruby("-I", "lib", "bin/rhythmmml")
end

task :test do
  ruby("test/run-test.rb")
end

task :default => :test
