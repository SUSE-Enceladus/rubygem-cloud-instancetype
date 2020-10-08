# Cloud::InstanceType

[![Build Status](https://travis-ci.org/suse-enceladus/rubygem-cloud-instancetype.svg?branch=master)](https://travis-ci.org/suse-enceladus/rubygem-cloud-instancetype)
[![Gem Version](https://badge.fury.io/rb/cloud-instancetype.svg)](https://badge.fury.io/rb/cloud-instancetype)

Public Clouds have _a lot_ of instance types. You don't want to make your users choose from every instance type under the sun; better to hand pick a few appropriate instance types and present them in a simple user interface.

To that end, Cloud::InstanceType is simply a guide, providing a framework for you to easily and consistently present a handful of instance types in a thoughtful way.

Cloud::InstanceType has a few conveniences if run as part of a Rails application, but Rails is not a requirement.

The InstanceType class was originally developed for [Velum](https://github.com/kubic-project/velum), a web dashboard for a kubernetes cluster.

Cloud::InstanceType is now maintained as a dependency of [blue-horizon](https://github.com/SUSE-Enceladus/blue-horizon), a web application for terraforming over public clouds.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cloud-instancetype'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloud-instancetype

## Usage

Config files are JSON, and contain structured information about both the instance types, and the categories they belong to.  The convention is to name these files `#{cloud}-types.json`, where _cloud_ is the lower case name of the framework you're working in (e.g. for Amazon Web Services, I use `aws-types.json`)

### Rails

Place your default instance type data in `config/data/#{cloud}-types.json`, or override with `vendor/data/#{cloud}-types.json`.

Load your instance types by the framework key:

```
instance_types = Cloud::InstanceType.for(cloud)
```

This will return a collection of `InstanceType` (Descriptions will be applied to each as )

### Off the rails

Load your instance types directly from the data file:

```
Cloud::InstanceType.load('path/to/your/data.json')
```

### Loaded

Either way, the return is a collection of `InstanceType`, so iterate along your merry way.

```
instance_types.each do |instance_type|
    puts instance_type.key
    puts instance_type.name
    puts instance_type.vcpu_count
    puts instance_type.category.features
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the test suite. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/suse-enceladus/rubygem-cloud-instancetype .

## Licensing

Copyright © 2019 SUSE LLC.
Distributed under the terms of GPL-3.0+ license, see [LICENSE](LICENSE) for details.
