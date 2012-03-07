rails_version = "~> #{ENV['RAILS_VERSION']}" if ENV.key?('RAILS_VERSION')

spec = Gem::Specification.new do |s|
  s.name = 'twilio_resource'
  s.version = '0.3.0'
  s.summary = 'An ActiveResource API wrapper for Twilio'
  s.add_dependency "reactive_resource", '>= 0.7.0'
  if rails_version
    s.add_dependency "activeresource", rails_version
    s.add_dependency "activesupport", rails_version
  end

  s.author = "Justin Weiss"
  s.email = "justin@uberweiss.org"
  s.homepage = "http://github.com/justinweiss/twilio_resource"
  s.extra_rdoc_files = ['README.md']
  s.has_rdoc = true

  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.test_files = Dir.glob('test/*_test.rb')

end
