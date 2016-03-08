ModelCache
=======

An ActiveRecord extension that allows for caching based on latest `updated_at` time.

This is particularly useful when some expensive data depends on the entire contents of the table.

Usage
-----

```ruby
# Return the latest updated_at of a collection, and uses Rails.cache to cache it.
Model.updated_at

# Caches and returns contents of the block based on the Model.updated_at and cache_key.
Model.cache(cache_key, options = {}, &block)

# Returns a method after passing it through the Model.cache method.
Model.cached_* # (e.g. User.cached_all)

# Same as Model.cached_*, but on a model instance.
model_instance.cached_* # (e.g. user.cached_things)

Installation
------------

Install with RubyGems:

```
gem install model_cache
```

License
-------

Copyright (c) 2016 Patrick Hogan, released under the MIT License.
http://www.opensource.org/licenses/mit-license
