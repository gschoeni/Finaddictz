module AdvertisementsHelper
	def getAdForPage(type)
		ad = nil
		if Page.find_by_name(type)
			ads = Page.find_by_name(type).advertisements
			if ads.length == 1
				ad = ads[0]
			elsif ads.length != 0
				ad = ads[Random.rand(ads.length-1)]
			end
		end
		formHtml(ad)
	end

	def formHtml(ad)
		if ad
			"<a href='#{ad.url}'><img src='#{ad.photo.url(:full)}'' alt='#{ad.headline}'/></a>"
		else
			"<a href='#'><img src='/images/OGBbanner.jpg' alt='Finnaddictz'/></a>"
		end
	end

	def listPagesForAdvertisement(ad)
		ret = ""
		ad.pages.each do |page|
			ret += page.name 
			ret += ", " unless page == ad.pages.last
		end
		return ret if ad.pages.count > 0
		return "no" if ad.pages.count == 0
	end
end
