require 'spec_helper'

describe "InitialPages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

	describe "Home page" do

		it "should have the h1 'Sample App'" do
			visit '/initial_pages/home'
			page.should have_selector('h1', text: 'Sample App')
		end

		it "should have the title 'Home'" do
			visit '/initial_pages/home'
			page.should have_selector('title', text: "#{base_title} | Home")
		end

	end

	describe "Help page" do

		it "should have the h1 'Help'" do
			visit '/initial_pages/help'
			page.should have_selector('h1', text: 'Help')
		end

		it "should have the title 'Help'" do
			visit '/initial_pages/help'
			page.should have_selector('title', text: "#{base_title} | Help")
		end

	end

	describe "Contact page" do

		it "should have the h1 'Contact'" do
			visit '/initial_pages/contact'
			page.should have_selector('h1', text: 'Contact')
		end

		it "should have the title 'Contact'" do
			visit '/initial_pages/contact'
			page.should have_selector('title', text: "#{base_title} | Contact")
		end

	end

	describe "About page" do

		it "should have the h1 'About Us'" do
			visit '/initial_pages/about'
			page.should have_selector('h1', text: 'About Us')
		end

		it "should have the title 'About Us'" do
			visit '/initial_pages/about'
			page.should have_selector('title', text: "#{base_title} | About Us")
		end

	end
	
end
