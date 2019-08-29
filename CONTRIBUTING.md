We love pull requests. Here's a quick guide:

1. Fork the repo.

2. Run the tests. We only take pull requests with passing tests, and it's great to know that you have a clean slate: `bundle && bundle exec rake`

3. Please add a test for your change. Only refactoring and documentation changes require no new tests. If you are adding functionality or fixing a bug, we need a test! We use [Minitest](https://github.com/seattlerb/minitest) in this project.

4. We care about code coverage and use `SimpleCov` to analyze the code and generate test coverage reports. It's possible to check the test coverage by running  `open coverage/index.html`. Please make sure to not decrease our `current % covered` and add appropriate test cases when necessary.

5. Methods with optional arguments should use keyword rather than positional arguments. An exception to this could be a method that takes only one optional argument, and it's unlikely that that method would ever take more than one optional argument. 

6. Push to your fork and submit a pull request.

### Github Flow for contributors and collaborators

For those of you with commit access, please check out Scott Chacon's blog post about [github flow](http://scottchacon.com/2011/08/31/github-flow.html)

> * Anything in the master branch is deployable
> * To work on something new, create a descriptively named branch off of master (ie: new-oauth2-scopes)
> * Commit to that branch locally and regularly push your work to the same named branch on the server
> * When you need feedback or help, or you think the branch is ready for merging, open a pull request
> * After someone else has reviewed and signed off on the feature, you can merge it into master

If you're reviewing a PR, you should ask yourself:
> * Does it work as described? A PR should have a great description.
> * Is it understandable?
> * Is it well implemented?
> * Is it well tested?
> * Is it well documented?
> * Is it following the structure of the project?

### Syntax/Good practices:

* Two spaces, no tabs.
* No trailing whitespace. Blank lines should not have any space.
* Prefer `&&`, `||` over `and`, `or`.
* `MyClass.my_method(my_arg)` not `my_method( my_arg )` or `my_method my_arg`.
* `a = b` and not `a=b`.
* use dash syntax for yaml arrays:
```Yaml
# this
a_things:
  - small_thing
  - big_thing
  - other_thing
  
# instead of these: 
b_things: [small_thing, big_thing, other_thing]
c_things: [
  small_thing,
  big_thing,
  other_thing,
]
```
* In general, follow the conventions you see used in the source already.
