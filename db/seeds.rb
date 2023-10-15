# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
(1..10).each do |item|
  User.create(name: "user #{item}")
end

User.all.each do |user|
  user.posts.create(name: "post #{user.id}")
end

(11..14).each do |item|
  User.create(name: "user #{item}")
end
