
RSpec.configure do |config|

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end

def sign_up(username)
  visit new_user_path
  fill_in "Username", with: username
  fill_in "Password", with: "password"
  click_button 'Create User'
end

def sign_up_as_testing_username
  sign_up("testing_username")
end

def sign_in(username)
  visit new_session_path
  fill_in "Username", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Sign In'
end
