# $LOAD_PATH, $:は同じものを指すグローバル変数
p $LOAD_PATH == $: # => true

p $LOAD_PATH
# => ["/Users/hash/.rbenv/versions/2.1.2/lib/ruby/site_ruby/2.1.0",
#     "/Users/hash/.rbenv/versions/2.1.2/lib/ruby/site_ruby/2.1.0/x86_64-darwin13.0",
#     "/Users/hash/.rbenv/versions/2.1.2/lib/ruby/site_ruby",
#     "/Users/hash/.rbenv/versions/2.1.2/lib/ruby/vendor_ruby/2.1.0",
#     "/Users/hash/.rbenv/versions/2.1.2/lib/ruby/vendor_ruby/2.1.0/x86_64-darwin13.0",
#     "/Users/hash/.rbenv/versions/2.1.2/lib/ruby/vendor_ruby",
#     "/Users/hash/.rbenv/versions/2.1.2/lib/ruby/2.1.0",
#     "/Users/hash/.rbenv/versions/2.1.2/lib/ruby/2.1.0/x86_64-darwin13.0"]
