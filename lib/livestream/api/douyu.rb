require 'digest'
require 'httparty'

module Livestream
	class Douyu
		API_URL = 'http://www.douyutv.com/api/v1/room'

		def initialize(room_id)
			@room_id = room_id
		end

		def get_stream
			return nil if json_response.keys.length.zero?
			json_response['data']['hls_url']
		end

		def json_response
			return @data unless @data.nil?
			begin
				JSON.parse(get_response.body)
			rescue
				@data = {}
			end
		end

		def get_response
			@res ||= HTTParty.get("#{API_URL}/#{@room_id}", options)
		end

		def args
			@args ||= {
					aid: 'wp',
					client_sys: 'wp',
					time: Time.now.to_i
			}
		end

		def auth
			seed = "room/#{@room_id}?#{args.map {|k, v| "#{k}=#{v}"}.join('&')}zNzMV1y4EMxOHS6I5WKm"
			::Digest::MD5.hexdigest(seed)
		end

		def options
			{
					headers: {
							'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36'
					},
			    query: {
						auth: auth
			    }.merge(args)
			}
		end
	end
end