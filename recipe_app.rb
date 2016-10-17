require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recipe_app.db")

class Recipe
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :instructions, Text
  property :created_at, DateTime
  
  has n, :relations
end
 
class Ingredient
  include DataMapper::Resource
  property :id, Serial
  property :name, String

  has n, :relations
end

class Relation
  include DataMapper::Resource

  property :id, Serial
  property :amount, String
  property :unit, String

  belongs_to :recipe
  belongs_to :ingredient
end


DataMapper.finalize.auto_upgrade!


get '/' do
  @recipes = Recipe.all :order => :id.asc
  @ingredients = Ingredient.all :order => :id.asc
  @relations = Relation.all :order => :id.asc
  erb :home
end

get '/join' do
  @recipes = Recipe.all :order => :id.asc
  @ingredients = Ingredient.all :order => :id.asc
  @relations = Relation.all :order => :id.asc
  erb :join
end