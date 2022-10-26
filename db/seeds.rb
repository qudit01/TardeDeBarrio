# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(name: 'Admin', last_name: 'User', email: 'admin@user.com', password: 123_456,
            password_confirmation: 123_456, rol: 'admin')
User.create(name: 'Colab', last_name: 'User', email: 'colab@user.com', password: 123_456,
            password_confirmation: 123_456, rol: 'colab')
Objective.create(content: 'Nuevo objetivo', done: false, user: User.last, student: Student.last)
Objective.create(content: 'Segundo objetivo', done: false, user: User.find_by_email('admin@user.com'),
                 student: Student.last)
Objective.create(content: 'Tercer objetivo', done: false, user: User.find_by_email('admin@user.com'),
                 student: Student.first)
Objective.create(content: 'Cuarto objetivo', done: false, user: User.find_by_email('colab@user.com'),
                 student: Student.first)
Objective.create(content: 'Quinto objetivo', done: false, user: User.find_by_email('colab@user.com'),
                 student: Student.last)

FactoryBot.create_list(:user, 10)
FactoryBot.create_list(:student, 10)
FactoryBot.create_list(:objective, 20)
FactoryBot.create_list(:comment, 30)
FactoryBot.create_list(:answer, 30)
