namespace :URLShortener do 
  desc "Prunes old urls and dependent visits/tags from the database in mins"
  task :prune, [:minutes] => [:environment] do |task, args|
    minutes = args[:minutes] || 1
    print "Pruning #{minutes}-minute old urls..."
    ShortenedUrl.prune(minutes.to_i)
  end
end
#"/tmp/crontab.3Y85EaBlaw" 1L, 240B
