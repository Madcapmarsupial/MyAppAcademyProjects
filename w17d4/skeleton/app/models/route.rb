class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    # TODO: your code here
    # i need a list of bus ids
    # need a list of drivers for each bus
    #route <-bus <- driver
     #    buses

     buses = self.buses.includes(:drivers)
     all_drivers = {}

     buses.each do |bus|
       drivers_list = []

       bus.drivers.each do |driver|
         drivers_list << driver.name
       end

      all_drivers[bus.id] = drivers_list
     end
     
     all_drivers
  end 


end
