CountrySelect::FORMATS[:with_alpha2] = lambda do |country|
  "#{country.name} (#{country.alpha2})"
end
