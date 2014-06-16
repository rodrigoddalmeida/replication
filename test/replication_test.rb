require "test_helper"

class ReplicationTest < ActiveSupport::TestCase

  test "Replication defaults when the ORM is ActiveRecord" do
    assert_includes Replication.defaults, :except
    assert_includes Replication.defaults, :strand_class
  end
end
