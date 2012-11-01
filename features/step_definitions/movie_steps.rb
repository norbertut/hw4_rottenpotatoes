# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  regexp = /#{e1}.*#{e2}/m
  assert_match(regexp, page.body)
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |elt|
    #puts elt para ver los valores
    step "I #{uncheck}check \"ratings_#{elt}\""
  end
end

Then /I should see all of the movies/ do
  table_rows=page.body.split(/\<tbody|\<\/tbody/)[1]
  assert_equal table_rows.split(/\<tr/).count-1, 10  #counts number of tr, but there is one more due to the remaining part of the tbody tag
end

Then /the director of "(.*)" should be "(.*)"/ do |title,director|
  regexp = /#{title}.*#{director}/m
  assert_match(regexp,page.body)
end
