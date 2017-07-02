class RecipesController < ApplicationController
  before_action :set_recipe, only: [:destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    if params[:q] && params[:q].length > 0
      @queries = create_search_queries(params[:q].split.map { |string| "%" + string + "%" })
      @recipes = Recipe.where(@queries[0]).or(Recipe.where(@queries[1])).page(params[:page])
    elsif params[:q] && params[:q].length == 0
      redirect_to root_path
    else
      @recipes = Recipe.all.page(params[:page])
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def create_search_queries(array)
      name_query = ""
      description_query = ""
      array.each_with_index do |q, index|
        name_query << "name LIKE " << "'#{q}'"
        name_query << " OR " unless index == array.length - 1
        description_query << "description LIKE " << "'#{q}'"
        description_query << " OR " unless index == array.length - 1
      end
      [name_query, description_query]
    end
end
