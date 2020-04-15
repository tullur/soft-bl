# frozen_string_literal: true

class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere

  # Example
  # routing /reply\+.+@reply.test.com/i => :replies
  # routing :all =>:replies
end
