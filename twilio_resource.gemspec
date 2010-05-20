spec = Gem::Specification.new do |s|
  s.name = 'twilio_resource'
  s.version = '0.1.0'
  s.summary = 'An ActiveResource API wrapper for Twilio'
  s.add_dependency "activeresource", '>= 2.3.2'
  s.author = "Justin Weiss"
  s.email = "justin@uberweiss.org"
  s.homepage = "http://github.com/justinweiss/twilio_resource"
  s.extra_rdoc_files = ['README.md']
  s.has_rdoc = true
  
  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.test_files = Dir.glob('test/*_test.rb')
  
end
