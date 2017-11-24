require 'spec_helper'

describe 'home tab' do
  before(:each) do
    visit '/'
  end
  it 'should work' do
    page.should have_content('This tests the most basic usage of tabulous.')
  end
end

describe 'galaxies tab' do
  before(:each) do
    visit '/'
    click_link 'Galaxies'
  end
  it 'should work' do
    page.should have_content('Listing Galaxies')
    page.should_not have_content('Listing Stars')
    page.should_not have_content('Listing Planets')
  end
end

describe 'stars tab' do
  before(:each) do
    visit '/'
    click_link 'Stars'
  end
  it 'should work' do
    page.should_not have_content('Listing Galaxies')
    page.should have_content('Listing Stars')
    page.should_not have_content('Listing Planets')
  end
end

describe 'planets tab' do
  before(:each) do
    visit '/'
    click_link 'Planets'
  end
  it 'should work' do
    page.should_not have_content('Listing Galaxies')
    page.should_not have_content('Listing Stars')
    page.should have_content('Listing Planets')
  end
end
