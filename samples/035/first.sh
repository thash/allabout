$ ruby first.rb
1
4
27
256
3125

$ bundle exec rubocop first.rb 
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
