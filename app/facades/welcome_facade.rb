class WelcomeFacade
  def holidays
    service.holidays.map do |data|
      Holiday.new(data)
    end
  end

  def service
    USHolidayService.new
  end
end
