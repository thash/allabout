$ cat first.rb
[1, 2, 3, 4, 5].map do |i| puts i ** i end

$ cat > .rubocop.yml
Style/SpaceAroundOperators:
  Enabled: false
Style/BlockDelimiters:
  Enabled: false
^C

$ bundle exec rubocop first.rb
Inspecting 1 file
.

1 file inspected, no offenses detected
