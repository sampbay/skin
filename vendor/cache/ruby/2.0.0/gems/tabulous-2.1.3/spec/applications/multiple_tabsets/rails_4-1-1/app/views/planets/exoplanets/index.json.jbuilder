json.array!(@planets_exoplanets) do |planets_exoplanet|
  json.extract! planets_exoplanet, :id, :name
  json.url planets_exoplanet_url(planets_exoplanet, format: :json)
end
