require 'spec_helper'

describe "UserPages" do

   subject { page }
  
	describe "signup page" do

		before { visit signup_path }

		it { should have_selector('h1', 
           text: 'Sign up') }
		it { should have_selector('title', 
           text: full_title('Sign up')) }

	end

	describe "signup page functionality" do

		before { visit signup_path }

      describe "submit empty form" do

        it "should not create a user" do
            expect do 
              click_button "Create my account"
            end.not_to change(User, :count)
        end

        it "should show error messages" do
          click_button "Create my account"
          page.should have_content ( "The form contains")
          page.should have_content ( "Name can't be blank")
          page.should have_content ( "Email can't be blank")
          page.should have_content ( "Email is invalid")
          page.should have_content ( "Password can't be blank")
          page.should have_content ( "Password is too short")
          page.should have_content ( "Password confirmation can't be blank")
          page.should_not have_content ( "Password digest")
        end

      end

      describe "submit valid form" do
        before do
           fill_in "Name", with: "Example User"
           fill_in "Email", with: "user@example.com"
           fill_in "Password", with: "foobar"
           fill_in "Confirmation", with: "foobar"
        end

        it "should create a user" do
           expect do 
             click_button "Create my account" 
           end.to change(User, :count).by(1)
        end

        describe "after saving the user" do
           before { click_button "Create my account" }
           let(:user) { User.find_by_email('user@example.com') }
           it { should have_selector('title', text: user.name) }
           it { should have_selector('div.alert.alert-success', text: 'Welcome') }
           it { should have_link('Sign out') }
        end

      end

   end

   describe "profile page" do

     let(:user) { FactoryGirl.create(:user) }

     before { visit user_path(user)}

     it { should have_selector('h1',    text: user.name)}
     it { should have_selector('title', text: user.name)}

   end

end
