require "identify_it/generator"

module IdentifyIt
  module HasIdentifier
    module ClassMethods
      def has_identifier(format, options={})
        @identifier_generator = IdentifyIt::Generator.new(format, options)
        define_singleton_method(:identifier_generator) { @identifier_generator }

        validates :identifier, presence: true, uniqueness: true
        before_validation :set_unique_identifier, on: :create

        send(:include, InstanceMethods)
      end
    end

    module InstanceMethods
      private

      def identifier=(val)
        super(val)
      end

      def set_unique_identifier
        return if identifier
        loop do
          self.identifier = self.class.identifier_generator.get
          break unless self.class.exists?(identifier: identifier)
        end
      end
    end
    ActiveRecord::Base.send(:extend, ClassMethods)
  end
end
