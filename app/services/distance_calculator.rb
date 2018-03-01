class DistanceCalculator
  KEY_PATTERN = "%{lat}_%{lng}_%{id}"
  def initialize from, restaurants
    @from, @restaurants = from, restaurants
  end

  def process
    @restaurants.inject({}) do |memo, r|
      distance = r.distance @from[:lat], @from[:lng]
      r.radius ||= 0
      key = KEY_PATTERN % { lat: @from[:lat], lng: @from[:lng], id: r.id }
      if distance <= r.radius
        memo[key] = distance
      else
        memo[key] = r.radius - distance
      end

      storage @from, r.id, distance
      memo
    end
  end

  def storage from, restaurant_id, distance
    key = KEY_PATTERN % { lat: from[:lat], lng: from[:lng], id: restaurant_id }
    Rails.cache.fetch key, expires_in: 2.hours do
      distance
    end
  end
end
