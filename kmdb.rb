# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!

# Delete existing data
Studio.destroy_all
Movie.destroy_all
Actor.destroy_all
# Assuming you have a model that represents the join between movies and actors, e.g., Cast
Cast.destroy_all

puts "Existing data deleted"


# Generate models and tables, according to the domain model.
# TODO!

rails generate model Studio name:string
rails generate model Movie title:string year:integer rating:string studio:references
rails generate model Actor name:string
rails generate model Casting movie:references actor:references role:string

rails db:migrate



# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!
# Find or create the studio
warner_bros = Studio.find_or_create_by(name: 'Warner Bros.')

# Movies
batman_begins = Movie.find_or_create_by(title: 'Batman Begins', year: 2005, rating: 'PG-13', studio: warner_bros)
the_dark_knight = Movie.find_or_create_by(title: 'The Dark Knight', year: 2008, rating: 'PG-13', studio: warner_bros)
the_dark_knight_rises = Movie.find_or_create_by(title: 'The Dark Knight Rises', year: 2012, rating: 'PG-13', studio: warner_bros)

# Actors
christian_bale = Actor.find_or_create_by(name: 'Christian Bale')
michael_caine = Actor.find_or_create_by(name: 'Michael Caine')
liam_neeson = Actor.find_or_create_by(name: 'Liam Neeson')
katie_holmes = Actor.find_or_create_by(name: 'Katie Holmes')
gary_oldman = Actor.find_or_create_by(name: 'Gary Oldman')
heath_ledger = Actor.find_or_create_by(name: 'Heath Ledger')
aaron_eckhart = Actor.find_or_create_by(name: 'Aaron Eckhart')
maggie_gyllenhaal = Actor.find_or_create_by(name: 'Maggie Gyllenhaal')
tom_hardy = Actor.find_or_create_by(name: 'Tom Hardy')
joseph_gordon_levitt = Actor.find_or_create_by(name: 'Joseph Gordon-Levitt')
anne_hathaway = Actor.find_or_create_by(name: 'Anne Hathaway')

# Castings for Batman Begins
Casting.find_or_create_by(movie: batman_begins, actor: christian_bale, role: 'Bruce Wayne')
Casting.find_or_create_by(movie: batman_begins, actor: michael_caine, role: 'Alfred')
Casting.find_or_create_by(movie: batman_begins, actor: liam_neeson, role: "Ra's Al Ghul")
Casting.find_or_create_by(movie: batman_begins, actor: katie_holmes, role: 'Rachel Dawes')
Casting.find_or_create_by(movie: batman_begins, actor: gary_oldman, role: 'Commissioner Gordon')

# Castings for The Dark Knight
Casting.find_or_create_by(movie: the_dark_knight, actor: christian_bale, role: 'Bruce Wayne')
Casting.find_or_create_by(movie: the_dark_knight, actor: heath_ledger, role: 'Joker')
Casting.find_or_create_by(movie: the_dark_knight, actor: aaron_eckhart, role: 'Harvey Dent')
Casting.find_or_create_by(movie: the_dark_knight, actor: michael_caine, role: 'Alfred')
Casting.find_or_create_by(movie: the_dark_knight, actor: maggie_gyllenhaal, role: 'Rachel Dawes')

# Castings for The Dark Knight Rises
Casting.find_or_create_by(movie: the_dark_knight_rises, actor: christian_bale, role: 'Bruce Wayne')
Casting.find_or_create_by(movie: the_dark_knight_rises, actor: gary_oldman, role: 'Commissioner Gordon')
Casting.find_or_create_by(movie: the_dark_knight_rises, actor: tom_hardy, role: 'Bane')
Casting.find_or_create_by(movie: the_dark_knight_rises, actor: joseph_gordon_levitt, role: 'John Blake')
Casting.find_or_create_by(movie: the_dark_knight_rises, actor: anne_hathaway, role: 'Selina Kyle')

puts "Sample data inserted successfully."

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""


# Query the movies data and loop through the results to display the movies output.
# TODO!
# Query all movies and print their details
Movie.includes(:studio).order(:year).each do |movie|
    puts "#{movie.title.ljust(25)} #{movie.year.to_s.ljust(15)} #{movie.rating.ljust(10)} #{movie.studio.name}"
  end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!
# Query all movies and prepare for looping
movies = Movie.includes(:studio).order(:year).all

# Using a for loop to iterate through the movies
for movie in movies
  puts "#{movie.title.ljust(25)} #{movie.year.to_s.ljust(15)} #{movie.rating.ljust(10)} #{movie.studio.name}"
end