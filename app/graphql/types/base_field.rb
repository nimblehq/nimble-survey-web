# frozen_string_literal: true

module Types
  class BaseField < GraphQL::Schema::Field
    argument_class Types::BaseArgument

    # Add `null: false` and `camelize: false` which provide default values
    # in case the caller doesn't pass anything for those arguments.
    # **kwargs is a catch-all that will get everything else
    def initialize(*args, null: false, camelize: false, **kwargs, &block)
      # Then, call super _without_ any args, where Ruby will take
      # _all_ the args originally passed to this method and pass it to the super method.
      super
    end
  end
end
