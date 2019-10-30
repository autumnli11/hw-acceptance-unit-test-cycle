require 'spec_helper'
require 'rails_helper'

describe MoviesController, :type => :controller do

    describe 'find movies with same director' do
    context 'selected movie has director info' do 

        it 'should render :similar template' do
            movie = double('movie', :id => '1', :director => '1')
            similar_movies = [double('similar movies', :director => '1'), double('similar movies', :director => '1')]
            Movie.stub(:get_similar_movies).and_return(similar_movies)
            get :similar, {:id => movie.id}
            expect(response).to render_template(:similar)
        end

        it 'it should return similar movies with selected movies' do
            movie = double('movie', :id => 1)
            similar_movies = [double('similar movies'), double('similar movies')]
            Movie.stub(:get_similar_movies).and_return(similar_movies)
            get :similar, {:id => movie.id}
            expect(assigns(:similar_movies)).to eq(similar_movies)
        end
        
    end

    context 'selected movie has no director info' do
        it 'should redirect to home page' do
            movie = double('movie', :id => 1)
            similar_movies = nil
            Movie.stub(:get_similar_movies).and_return(similar_movies)
            get :similar, {:id => movie.id}
            response.should redirect_to movies_path
        end

        it 'should pops up flash message saying the movie has no director info' do
            movie = double('movie', :id => '3', :title => '1')
            similar_movies = nil
            Movie.stub(:get_similar_movies).and_return(similar_movies)
            Movie.stub(:find).and_return(movie)
            get :similar, {:id => movie.id}
            flash[:notice].should eq("'#{movie.title}' has no director info")
        end

    end
end

end





    