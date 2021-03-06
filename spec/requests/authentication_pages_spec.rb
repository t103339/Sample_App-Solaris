require 'spec_helper'

describe "AuthenticationPages" do

   subject { page }

   describe "signin page" do

      before { visit signin_path }

      it { should have_valid_page_header('Sign in')}
      it { should have_valid_title('Sign in')}

   end

   describe "signin" do

      before { visit signin_path }

      describe "submitting an empty form" do

         before { click_button "Sign in" }
 
         it { should have_valid_title('Sign in')}
         it { should have_error_message("Invalid email/password combination") }

         # Note: flash persist for one request but re-rendering with render
         #       does not count as a request. The result would be that the
         #       flash message will appear on the next page requested.
         describe "after visiting another page" do
           before { click_link "Home" }
           it { should_not have_error_message("") }
         end

      end # empty form

      describe "with valid information" do

         let(:user) { FactoryGirl.create(:user) }

         before { sign_in user }

         it { should have_valid_title(user.name)}
         it { should have_valid_page_header(user.name)}

         it { should have_link('Users',    href: users_path) }
         it { should have_link('Profile',  href: user_path(user)) }
         it { should have_link('Settings', href: edit_user_path(user)) }
         it { should have_link('Sign out', href: signout_path) }

         it { should_not have_link('Sign in', href: signin_path) }

      end # valid information

  end # describe "signin" do

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_valid_title('Sign in') }
        end

        describe "submitting to the update action" do
          
          # There is no way for a browser to visit the update 
          # action directly—it can only get there indirectly 
          # by submitting the edit form using the put request.
          # The put request gets routed to the update action.
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          # if not signed in will be rerouted to signin page.
          it { should have_valid_title("Sign in") }
        end

      end

      describe "when attempting to visit a protected page" do

        before do
          visit edit_user_path(user)
          # users not signed in trying to access edit page will be routed
          # to the sign in page.
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          # once signed in, the user will be routed to the edit
          # page as originally desired.
          it "should render the desired protected page" do
            page.should have_valid_title("Edit user")
          end
        end

      end # attempting to visit protected page

    end # describe "for non-signed-in users"

    describe "as wrong user" do

      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) do
         FactoryGirl.create(:user, email: "wrong@example.com")
      end

      before { sign_in user }

      describe "visiting User#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_valid_title(full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end

    end # describe "as wrong user"

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end

    end

  end # describe "Authorization"

end # describe "AuthenticationPages" do
