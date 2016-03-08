module Cacheable
  extend ActiveSupport::Concern

  included do
    after_commit do
      self.class.updated_at = Time.now.to_f
    end
  end


  def cache(cache_key, options = {}, &block)
    cache_key = ActiveSupport::Cache.expand_cache_key (Array(cache_key) + [self, updated_at])
    Rails.cache.fetch cache_key, options, &block
  end


  def method_missing(method, *arguments, &block)
    if method.to_s =~ /^cached_(.*)$/
      cache $1 do
        value = send $1.to_sym
        value = value.to_a if value.is_a? ActiveRecord::Relation
        value
      end
    else
      super
    end
  end


  def self.respond_to?(method_sym, include_private = false)
    if method.to_s =~ /^cached_(.*)$/
      true
    else
      super
    end
  end


  module ClassMethods

    def updated_at(options = {})
      value = Rails.cache.fetch "#{name}_updated_at"
      if value.blank? || options[:force]
        value = maximum :updated_at
        Rails.cache.write "#{name}_updated_at", value
      end
      value
    end


    def updated_at=(value)
      Rails.cache.write "#{name}_updated_at", value
    end


    def cache(cache_key, options = {}, &block)
      cache_key = ActiveSupport::Cache.expand_cache_key (Array(cache_key) + [self, updated_at])
      Rails.cache.fetch cache_key, options, &block
    end


    def method_missing(method, *arguments, &block)
      if method.to_s =~ /^cached_(.*)$/
        cache $1 do
          value = send $1.to_sym
          value = value.to_a if value.is_a? ActiveRecord::Relation
          value
        end
      else
        super
      end
    end


    def self.respond_to?(method_sym, include_private = false)
      if method.to_s =~ /^cached_(.*)$/
        true
      else
        super
      end
    end

  end
end


ActiveRecord::Base.send :include, Cacheable
