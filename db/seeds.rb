# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  {email: "jeff@google.com", user_code: 'jeffjeff', password: "jeff", password_confirmation: "jeff", default_nickname: "jeff"},
  {email: "suzan@gmail.com", user_code: 'suzansuz', password: "suzan", password_confirmation: "suzan", default_nickname: "suzan"},
  {email: "pontiac@cedartree.com", user_code: 'pontiacp', password: "pontiac", password_confirmation: "pontiac", default_nickname: "pontiac"},
  {email: "wendingo@gmail.com", user_code: 'wendingo', password: "wendingo", password_confirmation: "wendingo", default_nickname: "wendingo"}
])

projects = Project.create([
  {name: "econ 101", project_code: "econ 101", description: "economics class 2019", open: true, default_access: 'admin'},
  {name: "bio project", project_code: "bio proj", description: "biology project 2020", open: true, default_access: 'admin'},
  {name: "secret project", project_code: "secret p", description: "top secret things to say", open: false, default_access: 'admin'}
])

collaborations = Collaboration.create([
  {user: users[0], project: projects[0], access: 'admin', nickname: 'jeff'},
  {user: users[1], project: projects[0], access: 'admin', nickname: 'suzan'},
  {user: users[2], project: projects[0], access: 'admin', nickname: 'pontiac'},
  {user: users[3], project: projects[0], access: 'admin', nickname: 'wendingo'},
  {user: users[0], project: projects[1], access: 'admin', nickname: 'jeff'},
  {user: users[1], project: projects[1], access: 'admin', nickname: 'suzan'},
  {user: users[0], project: projects[2], access: 'admin', nickname: 'jeff'},
  {user: users[1], project: projects[2], access: 'admin', nickname: 'suzan'}
])

pads = Pad.create([
  {name: "lec01", pad_code: "lec01lec", description: "what is economics", project_id: projects[0].id},
  {name: "lec02", pad_code: "lec02lec", description: "what are numbers", project_id: projects[0].id},
  {name: "respiration", pad_code: "respirat", description: "how things breath", project_id: projects[1].id}
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