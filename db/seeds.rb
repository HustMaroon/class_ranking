# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = [
  {
    name: 'Vũ Khánh Ly',
    email: 'vukhanhly@thaitho.edu'
  },
  {
    name: 'Trần Thị Thu Hằng',
    email: 'tranthithuhang@thaitho.edu'
  },
  {
    name: 'Vũ Quỳnh Chi',
    email: 'vuquynhchi@thaitho.edu'
  },
  {
    name: 'Nguyễn Yến Trang',
    email: 'nguyenyentrang@thaitho.edu'
  },
  {
    name: 'Phạm Trần Diệu Anh',
    email: 'phamtrandieuanh@thaitho.edu'
  },
  {
    name: 'Phạm Tuyết Nhi',
    email: 'phạmtuyetnhi@thaitho.edu'
  },
  {
    name: 'Trịnh Phương Linh',
    email: 'trinhphuonglinh@thaitho.edu'
  },
  {
    name: 'Trịnh Thị Ngọc Diệu',
    email: 'trinhthingocdieu@thaitho.edu'
  }
]

users.each do |user|
  User.create!(name: user[:name], email: user[:email], password: user[:email].split('@').first, role: :assessor)
end

User.create!(name: 'Nguyễn Ngọc Bảo Trâm', email: 'nguyengocbaotram@thaitho.edu', password: 'nguyengocbaotram', role: :mod)
User.create!(name: 'Hà Thị Thảo', email: 'hathithao@thaitho.edu', password: 'hathithao', role: :admin)

klasses = [
  {
    name: '6A',
    attendees: 47
  },
  {
    name: '6B',
    attendees: 47
  },
  {
    name: '7A',
    attendees: 46
  },
  {
    name: '7B',
    attendees: 44
  },
  {
    name: '8A',
    attendees: 33
  },
  {
    name: '8B',
    attendees: 31
  },
  {
    name: '9A',
    attendees: 39
  },
  {
    name: '9B',
    attendees: 40
  }
]

klasses.each do |klass|
  Klass.create!(name: klass[:name], attendees: klass[:attendees])
end


