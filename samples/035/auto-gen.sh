$ bundle exec rubocop --auto-gen-config

Inspecting 1 file
C

Offenses:

first.rb:1:21: C: Prefer {...} over do...end for single-line blocks.
[1, 2, 3, 4, 5].map do |i| puts i ** i end
                    ^^
first.rb:1:35: C: Space around operator ** detected.
[1, 2, 3, 4, 5].map do |i| puts i ** i end
                                  ^^

1 file inspected, 2 offenses detected
Created .rubocop_todo.yml.
Run `rubocop --config .rubocop_todo.yml`, or
add inherit_from: .rubocop_todo.yml in a .rubocop.yml file.
