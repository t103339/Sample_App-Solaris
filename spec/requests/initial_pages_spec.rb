require 'spec_helper'
require 'pp'

class Tests
  SUBTESTS = %w( Home Help Contact About )
end

describe "InitialPages" do

   subject { page }

   shared_examples_for "all static pages" do

		it { should have_selector('h1', text: heading) }
      it { should have_selector('title', text: full_title(page_title)) }

	end

   Tests::SUBTESTS.each do |test|

     describe ", #{test}" do

       before (:each) do

         case test

         when 'Home'
           visit root_path

         when 'Help'
           visit help_path

         when 'Contact'
           visit contact_path

         when 'About'
           visit about_path

         end

       end
       
       describe "page," do

          if test == "Home"
            let (:heading) {'Sample App'}
            let (:page_title) {''}
            it { should_not have_selector('title', text: full_title('Home') ) }
          else
            let (:heading) {test}
            let (:page_title) {test}
          end

          it_should_behave_like "all static pages"


       end # End of page describe

     end # End of page describe

   end # End of pages loop

   it "should have the right links on the layout"  do

      visit root_path
      click_link "About"
      page.should have_selector( 'title', text: full_title('About') )
      click_link "Help"
      page.should have_selector( 'title', text: full_title('Help') )
      click_link "Contact"
      page.should have_selector( 'title', text: full_title('Contact') )
      click_link "Home"
      page.should have_selector( 'title', text: full_title('') )
      click_link "sample app"
      page.should have_selector( 'title', text: full_title('') )
      click_link "Sign up now!"
      page.should have_selector( 'title', text: full_title('Sign up') )

   end





#	describe "Home page" do
#     before { visit root_path }
#
#     let (:heading) {'Sample App'}
#     let (:page_title) {''}
#
#     it_should_behave_like "all static pages"
#
#     it { should_not have_selector('title', text: full_title('Home') ) }
#
#	end

#	describe "Home page" do
#
#		before { visit root_path }
#
#		it { should have_selector('h1', text: 'Sample App') }
#		it { should have_selector('title', text: full_title('')) }
#      it { should_not have_selector('title', text: full_title('Home') ) }
#
#	end

#	describe "Help page" do
#
#		before { visit help_path }
#
#		it { should have_selector('h1', text: 'Help') }
#		it { should have_selector('title', text: full_title('Help')) }
#
#	end
#
#	describe "Contact page" do
#
#		before { visit contact_path }
#
#		it { should have_selector('h1', text: 'Contact') }
#		it { should have_selector('title', text: full_title('Contact')) }
#
#	end
#
#	describe "About page" do
#
#		before { visit about_path }
#
#		it { should have_selector('h1', text: 'About Us') }
#		it { should have_selector('title', text: full_title('About Us')) }
#
#	end
#	
end
