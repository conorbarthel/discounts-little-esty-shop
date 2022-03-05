class Holiday
  attr_reader :date,
              :localName,
              :name,
              :countryCode,
              :fixed,
              :global,
              :counties,
              :launchYear,
              :type
  def initialize(data)
  	@date = data[:date]
	  @localName = data[:localName]
	  @name = data[:name]
  	@countryCode = data[:countryCode]
  	@fixed = data[:fixed]
  	@global = data[:global]
    @counties = data[:counties]
    @launchYear = data[:launchYear]
    @type = data[:type]
  end
end
