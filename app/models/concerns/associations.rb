# frozen_string_literal: true

module Associations
  extend ActiveSupport::Concern

  included do
    class_attribute :associations, default: {}
    class_attribute :has_one_associations, default: {}
    class_attribute :has_many_associations, default: {}
    class_attribute :belongs_to_associations, default: {}

    # :reek:DataClump
    class << self
      # rubocop:disable Naming/PredicateName
      def has_one(name, klass)
        association(name, klass: klass, relation: :has_one, default: nil)
      end
      # rubocop:enable Naming/PredicateName

      # rubocop:disable Naming/PredicateName
      def has_many(name, klass)
        association(name, klass: klass, relation: :has_many, default: [])
      end
      # rubocop:enable Naming/PredicateName

      def belongs_to(name, klass)
        association(name, klass: klass, relation: :belongs_to, default: [])
      end

      # To prevent `class_attribute` to override value on parent class, use merge to write the Hash-based attribute
      # https://apidock.com/rails/Class/class_attribute#1332-To-use-class-attribute-with-a-hash
      # :reek:LongParameterList { max_params: 5 }
      def association(name, klass:, relation:, type: ActiveModel::Type::Value.new, **options)
        attribute(name, type, **options)
        self.associations = associations.merge(name => klass)
        relation_associations = public_send("#{relation}_associations").merge(name => klass)
        public_send("#{relation}_associations=", relation_associations)
      end
    end
  end

  private

  def assign_associations(attributes)
    assign_has_one_associations(attributes)
    assign_has_many_associations(attributes)
    assign_belongs_to_association(attributes)
  end

  # :reek:NilCheck
  # :reek:TooManyStatements
  def assign_has_one_associations(attributes)
    has_one_associations.each do |attribute_name, klass|
      object_hash = attributes[attribute_name]
      next if object_hash.nil?

      public_send("#{attribute_name}=", klass.new(object_hash))

      define_singleton_method "#{attribute_name}_id" do
        object_hash[:id]
      end
    end
  end

  # :reek:NilCheck
  # :reek:NestedIterators
  # :reek:TooManyStatements
  def assign_has_many_associations(attributes)
    has_many_associations.each do |attribute_name, klass|
      objects_hash = attributes[attribute_name]
      next if objects_hash.nil?

      public_send("#{attribute_name}=", objects_hash.map { |object_hash| klass.new(object_hash) })

      define_singleton_method "#{attribute_name.to_s.singularize}_ids" do
        objects_hash.pluck(:id)
      end
    end
  end

  # :reek:NilCheck
  # :reek:TooManyStatements
  def assign_belongs_to_association(attributes)
    belongs_to_associations.each do |attribute_name, klass|
      object_hash = attributes[attribute_name]
      next if object_hash.nil?

      public_send("#{attribute_name}=", klass.new(object_hash))

      define_singleton_method "#{attribute_name}_id" do
        object_hash[:id]
      end
    end
  end
end
