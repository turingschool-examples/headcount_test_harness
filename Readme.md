Headcount Test Harness
======================

For testing [headcount](https://github.com/turingschool-examples/headcount).
Project description is [here](https://github.com/turingschool/curriculum/blob/master/source/projects/headcount.markdown)


How to run
----------

1. Put your code in a directory named `headcount`, at the same level as this repo.
   In other words, if you did an `ls`, you should see directories for both
  `headcount` and `heacount_test_harness`.
2. Run `bundle install` (if it doesn't know what `bundle` is, then run `gem install bundler`)
3. Run `rake` for the complete set of default tests (this must pass in order to get a 3 on functional requirements)

How to run individual tests
---------------------------

You can use `mrspec` directly, it is recommended that you also use bundler when running.

```sh
# run all tests
$ bundle exec mrspec

# run a test tagged with "current"
$ bundle exec mrspec -t current

# run until the first failure, then stop
$ bundle exec mrspec --fail-fast
```
