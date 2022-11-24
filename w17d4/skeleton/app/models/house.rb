class House < ApplicationRecord
  has_many :gardeners,
    class_name: 'Gardener',
    foreign_key: :house_id,
    primary_key: :id

  has_many :plants,
    through: :gardeners,
    source: :plants

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  def better_seeds_query
    # TODO: your code here
    #Create an array of all the seeds within a given house.
    #house -> gardener (h-id)-> plants( gard -id ) -> seed(plant-id)
    plant_ids = Plant.joins(:gardener)
        .select("id")
        .where(['gardeners.house_id = ?', self.id])
        .ids
    Seed.joins(:plant).where(plant_id: plant_ids)
  end 


  
end
