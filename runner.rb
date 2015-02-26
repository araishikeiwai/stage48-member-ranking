Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file if !file.eql?('./runner.rb') }

Stage48MemberRanking.new.vote
