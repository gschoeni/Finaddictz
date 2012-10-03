module ApplicationHelper
	def top_ten_keywords
		keywords = {}

		#check the angler posts
		AnglerPost.all.each do |post|
			check_phrase keywords, post.title
			check_phrase keywords, post.description
		end

		#check the guide posts
		GuidePost.all.each do |post|
			check_phrase keywords, post.title
			check_phrase keywords, post.description
		end

		PropertyPost.all.each do |post|
			check_phrase keywords, post.title
			check_phrase keywords, post.description
		end
		#add any other things to check here

		sorted = keywords.sort_by {|key, value| value}.reverse
		retString = ''
		i = 0
		sorted.each do |key, val|
			break if i == 10
			retString += " #{val} #{key} <br>"
			i = i + 1
		end
		retString.html_safe
	end

	#logic for checking if the keywords already has the keyword and incrementing otherwise
	def check_phrase keywords, phrase
		phrase.split(/\W/).each do |word|
			break unless word.length > 3
			word = word.downcase
			unless keywords.include? word
				keywords.merge!({"#{word}" => 1})
			else
				num = keywords.values_at("#{word}")[0]
				keywords.update({"#{word}" => num+1})
			end
		end
	end
end
