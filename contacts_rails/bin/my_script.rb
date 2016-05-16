
require 'addressable/uri'
require 'rest-client'

def create_user(args = {})
	begin
		url = Addressable::URI.new(
			scheme: 'http',
			host: 'localhost',
			port: 3000,
			path: '/users.json'
		).to_s

		puts RestClient.post(
			url,
			{
				user: args
			}

		)
	rescue => e
		p e
		puts "something bad happened"
	end
end

def show_user( id )
	begin
		url = Addressable::URI.new(
			scheme: 'http',
			host: 'localhost',
			port: 3000,
			path: "/users/#{id}"
		).to_s

		puts RestClient.get(url)
	rescue => e
		p e
		puts "something bad, but different, happened"
	end
end

def update_user( id, args = {})
		begin
			url = Addressable::URI.new(
				scheme: 'http',
				host: 'localhost',
				port: 3000,
				path: "/users/#{id}"
			).to_s

			puts RestClient.patch(
				url,
				{
					user: args
				}
			)
		rescue => e
			p e
			puts "something bad happened"
		end
	end

	def delete_user( id )
			begin
				url = Addressable::URI.new(
					scheme: 'http',
					host: 'localhost',
					port: 3000,
					path: "/users/#{id}"
				).to_s

				puts RestClient.delete(url)
			rescue => e
				p e
				puts "something bad happened"
			end
		end
