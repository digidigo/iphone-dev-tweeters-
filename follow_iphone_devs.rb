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

