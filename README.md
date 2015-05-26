# Wordalator

Do math calculations using words! Inspired by the calculations that can be done in the google search bar

This gem is a pet project, and was started because of my interest in natural language processing - it is nowhere near done or perfect, and I hope to make it more robust over time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wordalator', :git => "https://github.com/okoyea/wordalator.git"
```

And then execute:

    bundle

Or install it yourself as:

    git clone https://github.com/okoyea/wordalator.git
    cd wordalator && gem build wordalator.gemspec
    gem install ./wordalator-0.0.1.gem

## Usage

Wordalator currently supports the most common math operations:
```
addition, subtraction, multiplication, division, exponents
```
It can be used for single operations, multiple operations, and multiple sentences (which can contain any combination of single and multiple operations)

Note: Everything is being computed in a literal sense, meaning the order of operations is not taken into account.

###Examples:
Single operators:

Addition:
```
Wordalate.parse 'What is 10 plus 2?' returns 12
Wordalate.parse 'What is 10 added to 2?' returns 12
```
Subtraction:
```
Wordalate.parse 'What is 10 minus 2?' returns 8
```
Division:
```
Wordalate.parse 'What is 10 divided by 2?' returns 5
```
Multiplication:
```
Wordalate.parse 'What is 10 times 2?' returns 20
Wordalate.parse 'What is 10 multiplied by 2?' returns 20
```
Exponents:
```
Wordalate.parse 'What is 10 to the power or 2?' returns 100
Wordalate.parse 'What is 10 raised to the power of 2?' returns 100
```
Multiple operators:
```
Wordalate.parse 'What is 4 plus 10 divided by 2?' returns 7
Wordalate.parse 'What is 4 plus 10 plus 5 divided by 2?' returns 9.5
```
Multiple Sentences:
```
Wordalate.parse 'What is 10 divided by 2?', 'What is 4 plus 10 divided by 2?','What is 4 to the 2nd power?' returns [5, 7, 16]
```
## Contributing

1. Fork it ( https://github.com/[my-github-username]/wordalator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Known Issues/Future Additions

Handling sentences where the second operation in the sentence comes first in the calculation.

Ex. `"What is 5 subtracted from 10?"` should be interpreted as `10-5`, not `5-10`
