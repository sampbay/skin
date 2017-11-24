#**************************************************************************************#
#   Refer to spec/applications/README for a full understanding of test applications.   #
#**************************************************************************************#

# This method describes the Gemfile that will be used by all test applications.
def create_gemfile

  remove_file 'Gemfile'

  gemfile = <<-CODE.strip_heredoc
    source 'https://rubygems.org'
    gem 'tabulous', :path => "../../../.."
    gem 'sqlite3', '>= 1.3.9'
    group :test, :development do
      gem "rspec-rails"
    end
    group :test do
      gem 'capybara', "~> 2.2.0"
      gem 'launchy'
    end
  CODE
  if rails_version? '3.0'
    gemfile += <<-CODE.strip_heredoc
      gem 'rails', '~> 3.0.0'
    CODE
  elsif rails_version? '3.1'
    gemfile += <<-CODE.strip_heredoc
      gem 'rails', '~> 3.1.0'
      group :assets do
        gem 'sass-rails',   '~> 3.1.4'
        gem 'coffee-rails', '~> 3.1.1'
        gem 'uglifier', '>= 1.0.3'
      end
      gem 'jquery-rails'
      group :test do
        gem 'turn', :require => false
        gem 'minitest'
      end
    CODE
  elsif rails_version? '3.2'
    gemfile += <<-CODE.strip_heredoc
      gem 'rails', '~> 3.2.0'
      group :assets do
        gem 'sass-rails',   '~> 3.2.3'
        gem 'bootstrap-sass', '= 2.3.1.0'
        gem 'coffee-rails', '~> 3.2.1'
        gem 'uglifier', '>= 1.0.3'
      end
      gem 'jquery-rails'
      group :test do
        gem 'turn', :require => false
        gem 'minitest'
      end
    CODE
  elsif rails_version? '4.0'
    gemfile += <<-CODE.strip_heredoc
      gem 'rails', '~> 4.0.5'
      gem 'sass-rails',   '~> 4.0.2'
      gem 'bootstrap-sass', '~> 3.0.2.0'
      gem 'coffee-rails', '~> 4.0.0'
      gem 'uglifier', '>= 1.3.0'
      gem 'jquery-rails'
      gem 'turbolinks'
      gem 'jbuilder', '~> 1.2'
      group :test do
        gem 'turn', :require => false
        gem 'minitest'
      end
    CODE
  elsif rails_version? '4.1'
    gemfile += <<-CODE.strip_heredoc
      gem 'rails', '~> 4.1.1'
      gem 'sass-rails',   '~> 4.0.3'
      gem 'bootstrap-sass', '~> 3.0.2.0'
      gem 'coffee-rails', '~> 4.0.0'
      gem 'uglifier', '>= 1.3.0'
      gem 'jquery-rails'
      gem 'turbolinks'
      gem 'jbuilder', '~> 2.0'
      group :test do
        gem 'turn', :require => false
        gem 'minitest'
      end
      group :development do
        gem 'spring'
      end
    CODE
  elsif rails_version? '4.2'
    gemfile += <<-CODE.strip_heredoc
      gem 'rails', '~> 4.2.0'
      gem 'sass-rails',   '~> 5.0'
      gem 'bootstrap-sass', '~> 3.0.2.0'
      gem 'coffee-rails', '~> 4.1.0'
      gem 'uglifier', '>= 1.3.0'
      gem 'jquery-rails'
      gem 'turbolinks'
      gem 'jbuilder', '~> 2.0'
      group :test do
        gem 'turn', :require => false
        gem 'minitest'
      end
      group :development do
        gem 'web-console', '~> 2.0'
        gem 'spring'
      end
    CODE
  end

  add_file 'Gemfile', gemfile

end
