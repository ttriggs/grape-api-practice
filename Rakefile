require 'rspec/core/rake_task'
require_relative './lib/api'

RSpec::Core::RakeTask.new :spec do |task|
  task.pattern = Dir['spec/**/*_spec.rb']
end

task default: ['spec']

desc 'Print compiled grape routes'
task :routes do
  GrapeApp::API.routes.each do |route|
    options = route.instance_variable_get(:@options)
    puts "method: #{options[:method]}\tpath: #{options[:path]}"
  end
end
