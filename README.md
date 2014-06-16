# Replication

Data replication as templates for Ruby ORMs.

> ![DNA]
>
> DNA replication. The [double helix][] is unwound and each strand acts as a template for the next strand. [Bases][] are matched to synthesize the new partner strands.

  [DNA]: https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/DNA_replication_split.svg/200px-DNA_replication_split.svg.png
  [double helix]: https://en.wikipedia.org/wiki/Double_helix "Double helix"
  [Bases]: https://en.wikipedia.org/wiki/Nucleotides "Nucleotides"

## Installation

Add this line to your application's Gemfile:

    gem 'replication'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install replication

## Usage

Extend ```Replication::Process``` in your models and declare it.
```ruby
class Model
  extend Replication::Process
  can_replicate
end
```

Customize the 'pairs' method if you want.
```ruby
class Model
  extend Replication::Process
  can_replicate :attributes_alias # default method is 'attributes'
end
```

Customize the class of the strands if you want.
```ruby
class Model
  extend Replication::Process
  can_replicate strand_class: WeirdStrandClass
end
```

You can blacklist an array of attributes. They'll not be replicated in the new strand.
```ruby
can_replicate except: [:id, :name]
```

To 'unwound' a strand, do:
```ruby
model_instance = Model.new(attrs)
model_instance.unwound(name: 'The Original Model') # returns a new strand
```

To 'unwound' and save a strand, do:
```ruby
model_instance = Model.new(attrs)
model_instance.replicate(name: 'The Original Model') # returns a new persisted strand
```

To be able to 'unwound' only when the object is valid, include Proofreading.
Right now it needs a ```valid?``` method to check.
```ruby
class Model
  extend Replication::Process
  can_replicate with: :proofreading
end

model_instance = Model.new(invalid_attrs)
model_instance.unwound(name: 'The Original Model') # returns nil
model_instance.replicate(name: 'The Original Model') # raises UnwoundError
```

To initialize a object that's descendant from the strand of another object, do:
```ruby
Model.new_from_strand([name or id])
# or
strand.replicate
```

### ActiveRecord

For ActiveRecord strands, ```[:id, :created_at, :updated_at]``` will be blacklisted by default.

It's highly recommended that you save your model instances before trying to replicate, since it
needs the 'id' and 'type' references for the association.

In some cases you don't want/won't need the strands to be associated, so, be free.

### Rails

Migrations are be provided by:
```
rake replication_engine:install:migrations
```

## TODO

- Add ActiveRecord inverse association: 'strands'.
- Refactoring, mainly about dependencies.
- Thorough testing.
- Scoping.
- More ORMs/ODMs.

## Contributing

1. Fork it ( https://github.com/rodrigoddalmeida/replication/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
