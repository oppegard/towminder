require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "notify" do
    @expected.subject = 'Notifier#notify'
    @expected.body    = read_fixture('notify')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_notify(@expected.date).encoded
  end

end
