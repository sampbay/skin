json.array!(@rogue_planets) do |rogue_planet|
  json.extract! rogue_planet, :id, :name
  json.url rogue_planet_url(rogue_planet, format: :json)
end
