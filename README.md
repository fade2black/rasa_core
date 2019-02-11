# RasaCore

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rasa_core`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rasa_core'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rasa_core

## Usage

```
require 'rasa_core'

client = RasaCore::Client.new(server:'172.18.0.3', port:5005)
client.check_health
#=> {:success=>true, :timed_out=>false, :return_message=>"No error", :code=>200, :body=>"hello from Rasa Core: 0.11.3"}
```

The response is always a hash having five key/values
* `success` - boolean true or false
* `timed_out` - boolean true or false
* `code` - HTTP response code
* `return_message` - a return message in could not get an http response
* `body` - body response, may be in a simple string form, Ruby `OpenStruct` object, or a JSON format. By default body is an `OpenStruct` object.   

The `check_health` methods return a simple **'Hello'** string if Core is running.

```
client.version
#=> {:success=>true, :timed_out=>false, :return_message=>"No error", :code=>200, :body=>#<OpenStruct minimum_compatible_version="0.11.0", version="0.11.3">}
```
```
client.status
#=> {:success=>true, :timed_out=>false, :return_message=>"No error", :code=>200, :body=>#<OpenStruct is_ready=true, model_fingerprint="12c788db30b74a5a8eb88a640aea9ce6">}
```

We can change the response format
```
client.response_format = :json
client.version
#=> {:success=>true, :timed_out=>false, :return_message=>"No error", :code=>200, :body=>"{\"minimum_compatible_version\":\"0.11.0\",\"version\":\"0.11.3\"}\n"}
client.status
#=> {:success=>true, :timed_out=>false, :return_message=>"No error", :code=>200, :body=>"{\"is_ready\":true,\"model_fingerprint\":\"12c788db30b74a5a8eb88a640aea9ce6\"}\n"}
```

To send a message to Core
```
client.send_message(message:'hello')
#=> {:success=>true, :timed_out=>false, :return_message=>"No error", :code=>200, :body=>[#<OpenStruct recipient_id="default", text="Greetings!">]}
```

We can also specify a sender id when sending a message
```
client.send_message(message:'hello', sender_id: 'bayram')
=> {:success=>true, :timed_out=>false, :return_message=>"No error", :code=>200, :body=>[#<OpenStruct recipient_id="bayram", text="Hi there, friend!">]}
```
## Client methods
#### check_health
Simple sends a GET request `http://<server>:<port>/` and gets a `hello` response in case the core server is running.
#### status
Receives information about the currently loaded agent.
#### version
Receives metadata about the running Core instance.
#### send_message(args={})
Sends a user message <br>
Arguments: `sender_id`, `message`<br>
For example `client.send_message(sender_id: 'bkuliyev@gmail.com', message: 'Hello')`
#### conversation_tracker(args={})
Retrieve a conversations tracker
Arguments: `sender_id`, `include_events`
#### append_event_to_tracker(args={})
Retrieve a conversations tracker<br>
Arguments: `sender_id`, `include_events`, `event`, `timestamp`, `name`, `policy`, `confidence`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rasa_core. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RasaCore project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rasa_core/blob/master/CODE_OF_CONDUCT.md).
