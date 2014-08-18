class ActorSearch < Searchlight::Search
  search_on Actor.all

  searches :query

  def search_query
    search.where("nombre ILIKE :query OR acronimo ILIKE :query OR id IN(:actor_ids)", query: "%#{query}%", actor_ids: actores_ids_from_iniciativas)
  end

  def actores_ids_from_iniciativas
    Iniciativa.where("nombre ILIKE :query", query: "%#{query}%").pluck(:actor_id)
  end
end
