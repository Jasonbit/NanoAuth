NanoAuth
=======

NanoAuth is a super stripped down Rails authentication module. It's comprised (so far) of one file that provides some additional methods to be mixed in to your User model. Over the years I kept tweaking code in various projects and continued to see the same boiler plate code for:

* authentication a user via User.authenticate(email,password)
* encrypt(password)
* authenticated?(password)

So I decided on some down time to pull all this stuff out and make a nice little gem of it.

Requirements
------------

NanoAuth requires Rails. It has not been tested on the 2.x branch, but may work - it's only been used on the 3.x branch.

Installation
------------

gem install nano_auth

NanoAuth does not provide any migrations to set up the necessary user fields. Since I've been using more schemaless ORM's recently, I have no need for migrations. However, for ActiveRecord, you'll need to create your own migration so your User model contains the following structure:

    :email          => String
    :password_salt  => String  
    :password_hash  => String  

For AR users, just add the following to your User model:

    class User < ActiveRecord::Base
      include NanoAuth
    end

User model
----------

NanoAuth requires a User class to be useful. It's been tested with ActiveRecord as well as MongoMapper (the two most common ORM's that I use). A typical MongoMapper User model might look like so:

    class User
    
      include MongoMapper::Document
      include NanoAuth # This must come AFTER MongoMapper::Document
      
      plugin MongoMapper::Plugins::Timestamps 
      
      key :first_name,        String, :required=> true
      key :last_name,         String, :required=> true
      key :email,             String, :required=> true
      key :phone,             String
      key :zip,               String
      key :activated_at,      DateTime
      key :timezone,          String  
      key :password_salt,     String  
      key :password_hash,     String  
    
      timestamps!
    
    end

This will provide the basics for your controllers that will allow you to create a user with a crypted password and allow lookups for a user supplied email and password. I haven't included any controller level logic at this point because there's so many ways to handle authentication that I leave it up to you to decide (see next section on why).

Tests
-----

I am a loyal follower of tests, but am a staunch minimalist TDD guy. There's too much typing involved in Rspec, so I don't use it - sorry folks, been down that road, have life to live with the time I save. That being said, I've included a small unit test in the tests folder that you can swipe, put into your project, and beat up all you want. I also use FactoryGirl for my fixture data and have included that file as well along with the test_helper to glue them together.

The 'why?'
----------

I've seen many Rails authentication schemes come and go and stay. I've worked on some big Rails apps over the years and am sorta in the middle of re-use everyone's code vs. roll your own. One of the problems I saw was the move from a 2.x project to 3.0 when it first came out. One company I worked with had so many plugins and gems that were abandoned that it prevented them from moving to teh latest and greatest and thusly were stuck in the netherlands of the 2.x. They can not haz 3.0 - ever.

That really galvanized my 'diy' philosophy where appropriate. I think it's more important for a team to own and understand ALL their code in order to maintain their 'agility' and also quality control. Now, this is probably not 100% attainable for a lot of teams, but it's an important lesson I always keep in mind when starting a new project. One of the great things about Ruby (and Rails) is that it's not that hard to do all this - to own the code. Maybe you take it in small chunks and keep refactoring or you really isolate a certain gem/module/library, develop a good set of metrics against it, figure out how it works, and then roll your own, if it makes sense. I've done both of these approaches and one great side effect of diy is that it makes it the teams product and no one else's.

So, NanoAuth, to me, is totally understandable and is small and simple enough that I can pull everything in it, if I want, into the User model, remove the gem, and still have it all work.

Future
------

It's possible that more authentication code at the controller level might show up in this module. However, since I mostly use Rails for API work, it will probably be somewhere along those lines and not focus on being web-based. But, then again, I might throw in some web stuff..

License
-------

MIT License. Copyright 2011 Jason Lee.