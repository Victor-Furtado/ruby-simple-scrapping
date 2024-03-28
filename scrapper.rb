require 'sinatra'
require 'json'
require 'eventmachine'

require "httparty" 
require "nokogiri"

require "mongo"

set :port, 4567

get '/' do
	"I GOT YA!"
end

post '/salve_info' do
	status 201
	request.body.rewind
	content_type :json

	client = Mongo::Client.new("mongodb+srv://admin:admin@speedio.nm2kl8o.mongodb.net/Speedio")

	begin
		collection = client[:websiteinfo]
		url = JSON.parse(request.body.read)["url"]
		if url.nil?
			raise "URL NÃO INFORMADA"
		end
		url.sub!("https://", "")
		url.sub!("http://", "")

		response = HTTParty.get("https://www.similarweb.com/website/#{url}", { 
			headers: headers={
				"Accept-Language": "en-US,en;q=0.9",
				"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36",
				"Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
				"Accept-Encoding": "gzip, deflate, br",
				"Cookie": "_abck=D2F915DBAC628EA7C01A23D7AA5DF495~0~YAAQLvR6XFLvH1uOAQAAJcI+ZgtcRlotheILrapRd0arqRZwbP71KUNMK6iefMI++unozW0X7uJgFea3Mf8UpSnjpJInm2rq0py0kfC+q1GLY+nKzeWBFDD7Td11X75fPFdC33UV8JHNmS+ET0pODvTs/lDzog84RKY65BBrMI5rpnImb+GIdpddmBYnw1ZMBOHdn7o1bBSQONMFqJXfIbXXEfhgkOO9c+DIRuiiiJ+y24ubNN0IhWu7XTrcJ6MrD4EPmeX6mFWUKoe/XLiLf1Hw71iP+e0+pUOCbQq1HXwV4uyYOeiawtCcsedRYDcyBM22ixz/6VYC8W5lSVPAve9dabqVQv6cqNBaaCM2unTt5Vy+xY3TCt1s8a0srhH6qdAFdCf9m7xRuRsi6OarPvDYjyp94oDlKc0SowI=~-1~-1~-1"
			}, 
		})


		document = Nokogiri::HTML(response.body)

		rank = document.css(".wa-rank-list__value").first.text
		category = document.css(".app-company-info__link").last.text
		total_visits = document.css(".engagement-list__item-value")[0].text
		bounce_rate = document.css(".engagement-list__item-value")[1].text
		pages_per_visit = document.css(".engagement-list__item-value")[2].text
		avg_visit_dur = document.css(".engagement-list__item-value")[3].text
		main_countries = document.css(".wa-geography__country-name").map { |elm| elm.text }.join(", ")
		gender_dis = document.css(".wa-demographics__gender-legend-item-value").map { |elm| elm.text }.join(", ")
		age_dis = document.css(".wa-demographics__age-data-label").map { |elm| elm.text }.join(", ")
		

		result = collection.insert_one({
			rank: rank,
			url: url,
			category: category,
			avg_visit_dur: avg_visit_dur,
			pages_per_visit: pages_per_visit,
			bounce_rate: bounce_rate,
			main_countries: main_countries,
			gender_dis: gender_dis,
			age_dis: age_dis,
			total_visits: total_visits
		})

		{ message: "INFORMAÇÕES SALVAS COM SUCESSO", data: result }.to_json
	rescue => e
		status 500
		{ data: {}, error: e }.to_json
	end
end

post '/get_info' do
	status 201
	request.body.rewind
	content_type :json

	client = Mongo::Client.new("mongodb+srv://admin:admin@speedio.nm2kl8o.mongodb.net/Speedio")

	begin
		collection = client[:websiteinfo]
		url = JSON.parse(request.body.read)["url"]
		if url.nil?
			raise "URL NÃO INFORMADA"
		end
		url.sub!("https://", "")
		url.sub!("http://", "")

		result = collection.find( { url: url } ).first

		{ message: "INFORMAÇÕES RECUPERADAS COM SUCESSO", data: result }.to_json
	rescue => e
		status 500
		{ data: {}, error: e }.to_json
	end
end