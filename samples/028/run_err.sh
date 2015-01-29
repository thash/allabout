$ bundle exec rspec string_spec_err.rb
F

Failures:

  1) String should be a kind of Integer
     Failure/Error: it { expect("100".to_f).to be_a(Integer)  }
       expected 100.0 to be a kind of Integer
     # ./string_spec_err.rb:2:in `block (2 levels) in <top (required)>'

Finished in 0.00078 seconds (files took 0.08033 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./string_spec_err.rb:2 # String should be a kind of Integer
