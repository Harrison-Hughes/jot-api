# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  {email: "jeff@google.com", user_code: "1", password: "jeff", password_confirmation: "jeff"},
  {email: "suzan@gmail.com", user_code: "2", password: "suzan", password_confirmation: "suzan"},
  {email: "pontiac@cedartree.com", user_code: "3", password: "pontiac", password_confirmation: "pontiac"},
  {email: "wendingo@gmail.com", user_code: "4", password: "wendingo", password_confirmation: "wendingo"}
])

projects = Project.create([
  {name: "econ 101", project_code: "1", description: "economics class 2019", open: true},
  {name: "bio project", project_code: "2", description: "biology project 2020", open: true},
])

collaborations = Collaboration.create([
  {user: users[0], project: projects[0], access: 'admin', nickname: 'nickname'},
  {user: users[1], project: projects[0], access: 'admin', nickname: 'nickname'},
  {user: users[2], project: projects[0], access: 'admin', nickname: 'nickname'},
  {user: users[3], project: projects[0], access: 'admin', nickname: 'nickname'},
  {user: users[0], project: projects[1], access: 'admin', nickname: 'nickname'},
  {user: users[1], project: projects[1], access: 'admin', nickname: 'nickname'}
])

pads = Pad.create([
  {name: "lec01", description: "what is economics", project_id: projects[0].id},
  {name: "lec02", description: "what are numbers", project_id: projects[0].id},
  {name: "respiration", description: "how things breath", project_id: projects[1].id}
])

points = Point.create([
  {text: "economics = money?", author: users[0].user_code, location: "1", pad_id: pads[0].id},
  {text: "economics = maths?", author: users[3].user_code, location: "2", pad_id: pads[0].id},
  {text: "economics sucks!", author: users[2].user_code, location: "3", pad_id: pads[0].id},
  {text: "maths is rubbish", author: users[2].user_code, location: "1", pad_id: pads[1].id},
  {text: "air goes in then out", author: users[0].user_code, location: "1", pad_id: pads[2].id},
  {text: "mammals breath air", author: users[1].user_code, location: "2", pad_id: pads[2].id},
  {text: "fish aren't mammals", author: users[0].user_code, location: "3", pad_id: pads[2].id}
])