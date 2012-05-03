# Install Redis
package 'redis'

# Make sure Redis launches on startup
ruby_block 'redis_startup' do
	block do
		unless File.exist?('~/Library/LaunchAgents/homebrew.mxcl.redis.plist')
			%x[cp /usr/local/Cellar/redis/2.4.13/homebrew.mxcl.redis.plist ~/Library/LaunchAgents/]
			%x[launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.redis.plist]
		end
	end
end
