# This script is designed to read the twitter using iphone developers here -> http://is.gd/hlhV and follow them with your twitter account
# plug in your google and twitter account details below
# Credit for this script goes to David Clements
# See his blog post here -> http://shortpath.blogspot.com/2009/01/follow-over-100-iphone-developers-on.html
# You'll need the google spreadsheet gem (http://github.com/gimite/google-spreadsheet-ruby/tree/master) and the twitter gem
# You may want to change the 1..1000 below so it only adds 10 followers at a time (every hour or so). Twitter will like you more then


require "rubygems"
require "google_spreadsheet"
require 'twitter'

google_user = "XXXXXXXX"
google_pw   = "XXXXXX"
twitter_user  = "XXXXXXX"
twitter_pw    = "XXXXXXX"

session = GoogleSpreadsheet.login(google_user, google_pw)

ws = session.spreadsheet_by_key("p3LA_Q08eM-VAAyq03ZSjYQ").worksheets[0]

base =  Twitter::Base.new(twitter_user, twitter_pw)

(1..1000).each do |row|
        url = ws[row,2]
        matched_user = url.match(/http:\/\/.*twitter.com\/(.*)/)
        next unless matched_user
        matched_user = matched_user[1]

        puts "Attmepting to follow #{matched_user}"

        begin
                base.create_friendship(matched_user)
                puts "success"
        rescue
                puts "******* Failed  #{$!.message}"
        end
end

