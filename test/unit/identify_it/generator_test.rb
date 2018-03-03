require 'test_helper'

class Generator < ActiveSupport::TestCase
  test 'instance creation' do
    generator = IdentifyIt::Generator.new("AA{4}-{2}:{3}")

    assert_equal "AA{4}-{2}:{3}",       generator.identifier_format
    assert_equal ('A'..'Z').to_a,       generator.alphaset
  end

  test 'identifier structure' do
    generator = IdentifyIt::Generator.new("{4}-{2}:{3}")

    assert_equal 9,                     generator.get.scan(/[A-Z]/).count # as 4+2+3
    assert_match /[A-Z]{4}-[A-Z]{2}:[A-Z]{2}/, generator.get

    generator = IdentifyIt::Generator.new("{12}")

    assert_equal 12,                    generator.get.scan(/[A-Z]/).count
    assert_match /[A-Z]{12}/,           generator.get

    generator = IdentifyIt::Generator.new("22{3}:{5}")

    assert_equal 8,                     generator.get.scan(/[A-Z]/).count
    assert_match /22[A-Z]{3}:[A-Z]{5}/, generator.get
  end

  test 'defaults (:letters, :upper)' do
    generator = IdentifyIt::Generator.new("{4}-{2}:{3}")

    assert_equal ('A'..'Z').to_a,       generator.alphaset

  end

  test 'letters lowercase' do
    generator = IdentifyIt::Generator.new("{4}-{2}:{3}", alphabet: :letters, case: :lower)

    assert_equal ('a'..'z').to_a,       generator.alphaset
  end

  test 'numbers' do
    generator = IdentifyIt::Generator.new("{4}-{2}:{3}", alphabet: :numbers)

    assert_equal ('0'..'9').to_a,       generator.alphaset
  end

  test 'mix upercase' do
    generator = IdentifyIt::Generator.new("{4}-{2}:{3}", alphabet: :mix, case: :upper)

    assert_equal ('A'..'Z').to_a + ('0'..'9').to_a,      generator.alphaset
  end

end