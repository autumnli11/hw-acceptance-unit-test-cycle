class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  #given a movie, return all similar movies if it has a director, else return empty array
  def self.get_similar_movies(id)
    selected_movie = self.find(id)
    director = selected_movie.director
    if !director.empty?
      return similar_movies = self.where(:director => director)
    else 
      return nil
    end
  end
  
end
