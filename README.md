# IdentifyIt
Adds easy to use identifier creation mechanism.


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'identify_it'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install identify_it
```
## Usage
Add migration to your project
```ruby
class YourModelName < ActiveRecord::Migration
  def up
    add_column :your_model_name, :string
  end

  def down
    remove_column :your_model_name, :string
  end
end
``` 
Just add to your ActiveRecord model a DSL instuction:
```ruby
has_identifier(format, options)
```
format - string  
options - hash of symbols

With format you are defining how identifier will look like. Main syntax is
that a curly brackets you are defining how long each literal would be.

```
{4}:{5} -> ABCD:ABCDE
```  
In options you can specify:
1. alphabet (:letters, :numbers, :mix)
2. case  (:upper, :lower, :mix)

##Examples
```ruby
has_identifier('AA:{2}-{4}', alphabet: :numbers)
> 'AA:34-1324'
has_identifier('{3}:{3}', alphabet: :mix, case: :upper)
> 'A22:8BS'
has_identifier('{8}', alphabet: :mix, case: :mix)
> '1s5DFG67'
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
