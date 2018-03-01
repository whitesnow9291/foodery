class DistanceStorage
  def self.get lat, lng, restaurant
    return -1 unless lat || lng
    key = DistanceCalculator::KEY_PATTERN % { lat: lat, lng: lng, id: restaurant.id }
    Rails.cache.fetch key, expires_in: 2.hours do
      distance_calc = DistanceCalculator.new({ lat: lat, lng: lng }, [restaurant])
      result = distance_calc.process
      result[key]
    end
  end
end
