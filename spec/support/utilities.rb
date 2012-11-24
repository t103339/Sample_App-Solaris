include ApplicationHelper

def full_title(page_title)

   base_title = "Ruby on Rails Tutorial Sample App"

   if page_title.empty?
      base_title
   else
      "#{base_title} | #{page_title}"
   end

end

def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def valid_create(the_email)
  fill_in "Name", with: "Example User"
  fill_in "Email", with: the_email
  fill_in "Password", with: "foobar"
  fill_in "Confirmation", with: "foobar"
  click_button "Create my account"
end

def invalid_create
  fill_in "Name", with: ""
  fill_in "Email", with: ""
  fill_in "Password", with: ""
  fill_in "Confirmation", with: ""
  click_button "Create my account"
end

def sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    if message.empty?
       page.should have_selector('div.alert.alert-error')
    else
       page.should have_selector('div.alert.alert-error', text: message)
    end
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    if message.empty?
       page.should have_selector('div.alert.alert-success')
    else
       page.should have_selector('div.alert.alert-success', text: message)
    end
  end
end

RSpec::Matchers.define :have_error_explanation do |message|
  match do |page|
    page.should have_selector('div.explanations', text: message)
  end
end

RSpec::Matchers.define :have_valid_title do |text|
  match do |page|
    page.should have_selector('title', text: text)
  end
end

RSpec::Matchers.define :have_valid_page_header do |text|
  match do |page|
    page.should have_selector('h1', text: text)
  end
end
