module ModelCache
  class Railtie < Rails::Railtie
    config.after_initialize do
      require "model_cache/cacheable"
    end
  end
end
