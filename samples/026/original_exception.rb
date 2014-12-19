class TooSleepyError < StandardError; end

raise TooSleepyError.new('zzzz') #=> original_exception.rb:3:in `<main>': zzzz (TooSleepyError)
