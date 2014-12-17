rows.first.class
#=> Capybara::Node::Element

[28] pry(main)> ls rows.first
Capybara::Node::Finders#methods: all  field_labeled  find  find_button  find_by_id  find_field  find_link  first
Capybara::Node::Actions#methods:
  attach_file  check  choose  click_button  click_link  click_link_or_button  click_on  fill_in  select  uncheck  unselect
Capybara::Node::Matchers#methods:
  ==                  has_button?         has_link?              has_no_field?     has_no_text?             has_table?
  assert_no_selector  has_checked_field?  has_no_button?         has_no_link?      has_no_unchecked_field?  has_text?
  assert_no_text      has_content?        has_no_checked_field?  has_no_select?    has_no_xpath?            has_unchecked_field?
  assert_selector     has_css?            has_no_content?        has_no_selector?  has_select?              has_xpath?
  assert_text         has_field?          has_no_css?            has_no_table?     has_selector?            refute_selector
Capybara::Node::Base#methods: base  find_css  find_xpath  parent  session  synchronize
Capybara::Node::Element#methods:
  []             checked?  disabled?     drag_to  inspect  path    right_click    selected?  tag_name  trigger          value
  allow_reload!  click     double_click  hover    native   reload  select_option  set        text      unselect_option  visible?
