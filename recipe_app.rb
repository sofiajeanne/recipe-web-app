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
  @recipes = Recipe.all :order => :title.asc
  @ingredients = Ingredient.all :order => :id.asc
  @relations = Relation.all :order => :id.asc
  erb :home
end

post '/' do
  r = Recipe.new
  r.title = params[:title]
  r.instructions = params[:instructions]
  r.created_at = Time.now
  r.save
  i1 = Ingredient.new
  i1.name = params[:ingredient1]
  i1.save
  i2 = Ingredient.new
  i2.name = params[:ingredient2]
  i2.save
  i3 = Ingredient.new
  i3.name = params[:ingredient3]
  i3.save
  rel1 = Relation.new
  rel1.amount = params[:amount1]
  rel1.unit = params[:unit1]
  rel1.recipe_id = r.id
  rel1.ingredient_id = i1.id
  rel1.save
  rel2 = Relation.new
  rel2.amount = params[:amount2]
  rel2.unit = params[:unit2]
  rel2.recipe_id = r.id
  rel2.ingredient_id = i2.id
  rel2.save
  rel3 = Relation.new
  rel3.amount = params[:amount3]
  rel3.unit = params[:unit3]
  rel3.recipe_id = r.id
  rel3.ingredient_id = i3.id
  rel3.save
  redirect '/'
end






