# Leaning Lua 

My repo for learning the programming language Lua

## Advent of code 2018 

Lua solutions for Advent of Code 2018

### AOC CLI

CLI helper tool for solving advent of code challenges

#### Create day
`lua AOC.lua create day<n>`

Create a folder `day<n>` where n is some integer. 
Then adds template files:

- `solutions.lua` 
- `input.data`
- `test.data`
- `test.lua`

Example:

Creates a folder namned day 1
`lua AOC create day1`

#### Run tests

`lua AOC.lua test day<n>`

Runs the test located in `day<n>/test.lua`. 

The busted testing library is used. 
Tests should be written in the describe, it syntax. Example:

```lua
describe("Day 1",function(
    it("Test something", function(
        assert.are.same(0,0)
        assert.are.equal({key: 42}, {key: 42})
    ))
))
```

#### Run solutions

`lua AOC.lua run day<n>`

Run the file `day<n>/solution.lua` 

If run with `-t` flag run the test data file.

Test data should be in `test.data` file

Real input data should be in `input.data` file


