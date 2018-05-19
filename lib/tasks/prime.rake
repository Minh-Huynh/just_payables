require 'faker'
require 'factory_bot_rails'

namespace :dev do
  desc "Generate dummy data for development" 
  task :prime => :environment do
    500.times do
      FactoryBot.create(:order)
    end
  end
end

    
