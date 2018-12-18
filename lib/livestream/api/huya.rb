require 'httparty'

module Livestream
	class Huya
		API_URL = 'https://www.huya.com'

		def initialize(room_id)
			@room_id = room_id
		end

		def get_stream
			return nil if json_response.keys.length.zero?
			info = json_response['stream']['data'].first['gameStreamInfoList'].first
			"#{info['sHlsUrl']}/#{info['sStreamName']}/playlist.m3u8"
		end

		def json_response
			return @data unless @data.nil?
			begin
				JSON.parse(/hyPlayerConfig = ([^;]+);/.match(get_response.body)[1])
			rescue
				@data = {}
			end
		end

		def get_response
			@res ||= HTTParty.get("#{API_URL}/#{@room_id}")
		end
	end
end