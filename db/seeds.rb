# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rsolr'
require 'open-uri'

# Initial connection to Solr
rsolr_search = RSolr.connect url: "http://www.food.com/services/mobile/fdc/search"

(1..10000).each do |page|
  # Search for successive result pages
  page = rsolr_search.get 'sectionfront', params: {
    pn: page.to_s,
    recordType: "Recipe",
    sortBy: "quickAndEasy",
    collectionId: "17"
  }

  # Resulting recipe data in array of hashes
  recipes = page["response"]["results"]

  # Create objects of type Recipe and commit to database
  recipes.each do |recipe|
    name = recipe["main_title"]
    image = recipe["recipe_photo_url"]
    description = recipe["main_description"]
    url = recipe["record_url"]
    Recipe.create(name: name, image: image, description: description, url: url)
  end

end

# Search for first page of results
#first_page = rsolr_search.get 'sectionfront', params: {
#  pn: "1",
#  recordType: "Recipe",
#  sortBy: "quickAndEasy",
#  collectionId: "17"
#}
#
# Single recipes in array of hashes
#first_recipes = first_page["response"]["results"]
#
# Create Recipe objects with array
#first_recipes.each do |recipe|
#  name = recipe["main_title"]
#  image = recipe["recipe_photo_url"]
#  description = recipe["main_description"]
#  url = recipe["record_url"]
#  Recipe.create(name: name, image: image, description: description, url: url)
#end
