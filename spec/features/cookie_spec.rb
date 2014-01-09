require 'spec_helper'

describe "Hello world", js: true do
  subject { page }

  it "returns http success" do
    visit '/hello/world'
    expect(page).to have_content('Hello')

    config = Rails.application.config

    cookie = page.driver.cookies[config.session_options[:key]]

    message = CGI.unescape(cookie.value)

    key_generator = ActiveSupport::KeyGenerator.new(
      config.secret_key_base, iterations: 1000
      )

    secret = key_generator.generate_key(
      config.action_dispatch.encrypted_cookie_salt
      )

    sign_secret = key_generator.generate_key(
      config.action_dispatch.encrypted_signed_cookie_salt
      )

    encryptor = ActiveSupport::MessageEncryptor.new(
      secret, sign_secret
      )

    cookie = encryptor.decrypt_and_verify(message)

    expect(cookie["flash"]["flashes"][:notice]).to eq("example")
  end

end
