Headcount Test Harness
======================

For testing [headcount](https://github.com/turingschool-examples/headcount).

Project description is [here](https://github.com/turingschool/curriculum/blob/master/source/projects/headcount.markdown)

## Project Structure

For this harness to work, all the `require` statements in your
Headcount project must be `require_relative`.

For example a file at `headcount/lib/district_repository.rb` that needed
to require the adjacent `district` file, it would require it like so:

```
require_relative "district"
```

This is one of the few times we will ask you to use `require_relative`, but
it will make things much easier in this case since we are using this
external test harness to verify the functionality of your code.

## Installing Locally

Git clone this project into a directory that lives at the same level
as your `headcount` project directory. It should be arranged like:

    <my_code_directory>
    |
    |\
    | \headcount/
    |
    |\
    | \headcount_test_harness/
    |

## Usage

Change directories into the `headcount_test_harness/` directory and then execute:

    $ bundle

To load in dependencies for the spec harness.

To test your implementation against the evaluation specs, run:

    $ rake
