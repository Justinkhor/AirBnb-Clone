# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create([{name: 'Justin Khor', age: 18, gender: 'Male', country: 'Malaysia', email: 'khorchengee@gmail.com', password: 'kce0822kce', role: 2}, {name: 'Justin', age: 18, gender: 'Male', country: 'Malaysia', email: 'khorchengee99@gmail.com', password: 'kce0822', role: 1}])
