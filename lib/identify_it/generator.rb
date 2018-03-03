# frozen_string_literal: true

module IdentifyIt
  class Generator
    UPPERCASE    = ("A".."Z")
    LOWERCASE    = ("a".."z")
    NUMBERS      = ("0".."9")

    attr_reader :alphabet, :set_case, :alphaset, :identifier_format
    # format: '{4}:{4}'
    #         '{4}-{4}-{2}'
    # options:
    #         alphabet: :letters
    #                   :numbers
    #                   :mix
    #         case:     :upper
    #                   :lower
    #                   :mix

    def initialize(format, options={})
      @identifier_format = format
      @alphabet = options[:alphabet] || :letters
      @set_case = options[:case] || :upper
      generate_set
    end

    def get
      identifier = identifier_format.dup
      identifier_set = alphaset.sample(length)
      literals = literal_sizes.map {|size| identifier_set.shift(size).join }
      literals.each {|literal| identifier.sub!(/(\{\d+\})/, literal) }
      identifier
    end

    private

    def length
      literal_sizes.sum
    end

    def literal_sizes
      identifier_format.scan(/\{(\d+)\}/).flatten.map(&:to_i)
    end

    def generate_set
      @alphaset = []
      @alphaset << UPPERCASE.dup.to_a if add_upper_letters?
      @alphaset << LOWERCASE.dup.to_a if add_lower_letters?
      @alphaset << NUMBERS.dup.to_a   if add_numbers?
      @alphaset.flatten!
    end

    def add_upper_letters?
      %i[letters mix].include?(alphabet) && %i[upper mix].include?(set_case)
    end

    def add_lower_letters?
      %i[letters mix].include?(alphabet) && %i[lower mix].include?(set_case)
    end

    def add_numbers?
      %i[numbers mix].include?(alphabet)
    end
  end
end
