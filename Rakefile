require 'rubocop/rake_task' # rubocop:disable Style/FrozenStringLiteralComment
require 'rspec/core/rake_task'

task default: %w[lint spec]

RuboCop::RakeTask.new(:lint) do |task|
  task.requires << 'rubocop-rspec'
  task.requires << 'rubocop-rake'
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb', 'Rakefile']
  task.fail_on_error = false
end

desc 'This task runs the app'
task :run do
  ruby 'main.rb'
end

desc 'This task runs tests'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end
