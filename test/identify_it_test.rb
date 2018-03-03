#class User < ApplicationRecord
#  has_identifier "{4}:{4}", alphabet: :letters, case: :mix
#end

require 'test_helper'

class IdentifyIt::Test < ActiveSupport::TestCase

  test 'model creates identifier' do
    user = User.new(name: 'Jon Smith')
    user.save

    assert_not_empty                        user.identifier
    assert_match /[A-Za-z]{4}:[A-Za-z]{4}/, user.identifier
  end

  test 'User has identifier validation' do
    assert_empty %w(PresenceValidator UniquenessValidator) -
                 User.validators_on(:identifier).map{|v| v.class.name.split('::').last}
  end

  test 'User has before validation callback :set_unique_identifier' do
    assert_empty [:set_unique_identifier] - User._validation_callbacks.map(&:filter)
  end
end
