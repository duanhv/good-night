# frozen_string_literal: true

module GlobalHelper
  def json_body
    @json_body ||= json_body!
  end

  def json_body!
    body = response.body.sub(/^\)\]\}'\,\n/, "")
    JSON.parse(body, quirks_mode: true)
  end

  def json_body_reload!
    body = response.body.sub(/^\)\]\}'\,\n/, "")
    @json_body = JSON.parse(body, quirks_mode: true)
  end

  def login(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end

RSpec.configure do |config|
  config.include GlobalHelper
end

