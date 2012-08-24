module SharedPostMethods

	def self.included(base)
	  # add methods in ClassMethods into the meta class
	  base.extend(ClassMethods)
	end

	def valid_date_string?(date_string)
	  # accessing the meta class to call the
	  # real method
	  class << self
	   self.valid_date_string?(date_string)
	  end
	end


	def string_to_time(string)
	  # accessing the meta class to call the
	  # real method
	  class << self
	   self.string_to_time(string)
	  end
	end
	
	module ClassMethods

	  def string_to_time(string)
	  	begin
		  	endArr = string.split('/')
				endArr.each {|r| puts r.to_i}
				t = Time.mktime(endArr[2].to_i, endArr[0].to_i, endArr[1].to_i)
			rescue
				Time.now()
			end
	  end

	  def valid_date_string?(date_string)
	  	puts "date string: #{date_string}"
	  	if date_string
				arr = date_string.split('/')
				begin 
					t = Time.mktime(arr[2].to_i, arr[0].to_i, arr[1].to_i)
				rescue
					t = false
				end
				return t
			#its fine if there is no date
			else 
				true
			end
		end
	end
end