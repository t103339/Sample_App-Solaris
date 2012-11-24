require 'spec_helper'

describe "UserPages" do

   subject { page }

   describe "index page" do

     let(:user) { FactoryGirl.create(:user) }

     #before do
     #  sign_in FactoryGirl.create(:user)
     #  FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
     #  FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
     #  FactoryGirl.create(:user, name: "Bill", email: "bill@example.com")
     #  FactoryGirl.create(:user, name: "Barn", email: "barn@example.com")
     #  FactoryGirl.create(:user, name: "Brick", email: "brick@example.com")
     #  visit users_path
     #end

     before(:all) { 5.times { FactoryGirl.create(:user) } }
     after(:all) { User.delete_all }

     before(:each) do
       # print "\n Name: " + user.name + " Signing in, count=" + 
       # User.paginate(page: 1).count.to_s + " \n"
       sign_in user
       visit users_path
     end

     it { should have_valid_title("All users") }
     it { should have_valid_page_header("All users") }

     describe "pagination" do
       
        it { should have_selector('div.pagination') }


        it "should list each user" do
          # first=User.paginate(page: 1, per_page: 5).first
          # last=User.paginate(page: 1, per_page: 5).last
          User.paginate(page: 1, per_page: 5).each do |user|
            # User.paginate(page: 1).each do |user|
            # print user.name + " should be on page. \n" 
            page.should have_selector('li', text: user.name)
          end
        end

     end # pagination

     describe "delete links" do

       it { should_not have_link('delete') }
       
       describe "as an admin user" do

         let(:admin) { FactoryGirl.create(:admin) }
         before do
           sign_in admin
           visit users_path
         end

         it { should have_link('delete', href: user_path(User.first)) }
         it "should be able to delete another user" do
           expect { click_link('delete') }.to change(User, :count).by(-1)
         end
         it { should_not have_link('delete', href: user_path(admin)) }

       end

     end

   end # index page
  
	describe "signup page" do

		before { visit signup_path }

      it { should have_valid_title (full_title('Sign up'))}
		it { should have_valid_page_header('Sign up') }

	end

	describe "signup page functionality" do

		before { visit signup_path }

      describe "submit empty form" do

        it "should not create a user" do
          expect { invalid_create }.not_to change(User, :count)
        end

        describe "error messages" do
          before { click_button "Create my account" }
          it { should have_error_message("The form contains")}
          it { should have_error_explanation ( "Name can't be blank") }
          it { should have_error_explanation ( "Email can't be blank") }
          it { should have_error_explanation ( "Email is invalid") }
          it { should have_error_explanation ( "Password can't be blank") }
          it { should have_error_explanation ( "Password is too short") }
          it { should have_error_explanation ( "Password confirmation can't be blank") }
          it { should_not have_error_explanation ( "Password digest") }
        end

      end

      describe "submit valid form" do

        let(:the_email) {"user@example.com"} 

        it "should create a user" do
          expect { valid_create(the_email) }.to change(User, :count).by(1)
        end

        describe "after saving the user" do

           before { valid_create(the_email) }

           let(:user) { User.find_by_email(the_email) }

           it { should have_valid_title (user.name) }
           it { should have_success_message('Welcome')}

           it { should have_link('Sign out') }

        end

      end

   end

   describe "profile page" do

     let(:user) { FactoryGirl.create(:user) }

     before { visit user_path(user)}

     it { should have_valid_title (user.name) }
     it { should have_valid_page_header(user.name)}

   end

   describe "edit" do

     let(:user) { FactoryGirl.create(:user) }

     before do 
       # sign in necessary to access edit and update as required
       # in user controller.
       sign_in user
       visit edit_user_path(user)
     end

     describe "page" do
        it { should have_valid_title ("Edit user") }
        it { should have_valid_page_header("Update your profile")}
        it { should have_link('change', href: 'http://gravatar.com/emails') }
     end

     describe "with invalid information" do
       before { click_button "Save changes" }
       it { should have_error_message("")}
     end

     describe "with valid information" do

       let(:new_name) { "New Name" }
       let(:new_email) { "new@example.com" }

       before do
         fill_in "Name",          with: new_name
         fill_in "Email",         with: new_email
         fill_in "Password",      with: user.password
         fill_in "Confirmation",  with: user.password
         click_button "Save changes"
       end

       it { should have_success_message("")}
       it { should have_valid_title(new_name)}
       it { should have_valid_page_header(new_name)}
       it { should have_link('Sign out', href: signout_path) }
       specify { user.reload.name.should == new_name } 
       specify { user.reload.email.should == new_email } 
       
     end

   end

end
