require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recipe_app.db")
 
class Recipe
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :instructions, Text
  property :created_at, DateTime
  
  has n, :ingredients
end
 
class Ingredient
  include DataMapper::Resource
  property :id, Serial
  property :name, String

  belongs_to :recipe
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @recipes = Recipe.all :order => :id.desc
  @ingredients = Ingredient.all :order => :id.desc
  erb :home
end