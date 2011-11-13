Gem::Specification.new do |s|

  s.name = %q{NanoAuth}
  s.version = "0.1.0"
  s.date = %q{2011-11-13}
  s.summary = %q{NanoAuth is a super stripped down Rails authentication module. It's comprised (so far) of one file that provides some additional methods to be mixed in to your User model.}
  s.description = %q{NanoAuth is a super stripped down Rails authentication module. It's comprised (so far) of one file that provides some additional methods to be mixed in to your User model. Over the years I kept tweaking code in various projects and continued to see the same boiler plate code for:

  * authentication a user via User.authenticate(email,password)
  * encrypt(password)
  * authenticated?(password)

  So I decided on some down time to pull all this stuff out and make a nice little gem of it.}
  s.authors = ["Jason Lee"]
  s.email = "jasonlee9@gmail.com"
  s.homepage = "https://github.com/jasonbits/nano_auth/blob/master"
  
  s.files = [
    "lib/nano_auth.rb"
  ]

  s.require_paths = ["lib"]
  
  s.add_dependency 'bcrypt-ruby'
  
end
