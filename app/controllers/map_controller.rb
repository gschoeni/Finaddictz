class MapController < ApplicationController
	def index
		@pins = River.all
	end
end
