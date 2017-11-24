# Test Applications



## What's the point?

Since the behavior of tabulous affects the application as a whole, to really
test it well we need to use integration tests.

We also need to have several different test applications in order to test
various configurations, such as using it with Twitter Bootstrap, using it with
or without subtabs, etc.

And finally, we care that tabulous works well in multiple versions of Rails.

So if we had four test applications and were testing against three versions of
Rails, all of a sudden we've got twelve different applications and their
accompanying tests to manage.  Ouch!

So the whole point of this setup is to take away the pain of testing multiple
test applications against multiple versions of Rails.



## Okay, so how does this work?

We use Rails application templates to generate our test apps.  This means that
we don't want to make changes to any Rails test app directly, because those
changes will get lost when the app is re-generated.

Each kind of test application lives under its own directory in spec/applications
(e.g., spec/applications/main).

The Rails application template lives in this directory and should be called
application_template.rb.  This gives instructions for how to generate the test
app.

When we generate a new test application and specify a Rails version, the test
application will end up in spec/applications/[app_name]/[rails-version].

When the application in generated, it uses the gems described in
spec/applications/universal_gemfile.rb.

Any files and directories in spec/applications/universal will be copied over to
the new Rails app.  This is where we would put any tests that we would want to
run in every one of our test applications.

Any files and directories in spec/applications/[app_name]/shared will be copied
over to the new Rails app.  This is where we would put all of the tests that we
would want run for this kind of test app.



## So how do we generate a test app?

Let's say Rails 17.0.4 is released and we want to test the "main" test app
against this.  Run this script:

    $ script/create_test_app main 17.0.4

This will create a Rails app in spec/applications/main/rails_17-0-4.  When it is
finished generating, we can go into the new Rails app's directory and run tests
like so:

    $ bundle exec rake test
    $ bundle exec rake spec
    $ bundle exec rake



## So how do we set up a new kind of test application?

* Create a new directory under spec/applications.
* Create a new application_template.rb file in this directory.  Follow the
  pattern of the other test app's application templates.
* Create a shared directory in this directory.  Any files put here will be
  copied when we generate a new Rails app based on the application template.
* Any specs or tests should live in this shared directory.
* If we need to add any gems to the Rails app, modify
  spec/applications/universal_gemfile.rb.



## WTF?! Why isn't this working for me?

Two things can be particularly problematic when testing multiple versions of
Rails apps from within a gem:

### Wrong Gemfile

Bundler can get confused and accidentally use the tabulous gem's Gemfile
instead of the Gemfile found in the test app.  So if you have gem version
problems, consider this.  More info is here: http://spectator.in/2011/01/28/bundler-in-subshells/

### Wrong Rails Executable

When you have multiple versions of Rails installed, it can be very difficult
to target the correct version of the rails executable to use.  Even if you
use the rails _version.number_ trick, the wrong version of Rails may still
be used.  This is because rails is a dependency in tabulous's Gemfile, and so
even if you try to force the usage of a different rails executable, the version
specified in the Gemfile may be winning.  This probably depends on what tools
you are using to manage your gems and rubies (rvm, Bundler, rubygems-bundler,
etc.).

If you have this problem, one way to get the generation of a new test application
to work is to create a fresh, new gemset and install just that version of
Rails in it.  Then you can create a new test application targeted to that
version of Rails.
