https://courses.fit.cvut.cz/NI-RUB/lectures/06/task.html

# Build and install GEM:

<pre>
cd roman
gem build roman.gemspec
gem install roman-0.1.0.gem
roman --help
</pre>

# Use CLI (after install):

<pre>
roman
roman -h
roman --help
roman -a 42
roman -r 42
roman --arabic 55
roman --roman 58
roman -a nonsense
</pre>

# Generate documentation (after install):

<pre>
bundle install
bundle exec yard
</pre>
And go to: docs/index.html to view it.


# Run tests (after install):

<pre>
bundle install
bundle exec rspec
</pre>