products = Product.create!([
  {title: 'Noose', description: 'The best', details: 'The best', hand: true, image_url: 'new'},
  {title: 'Swang1', description: 'The best', details: '', hand: true, image_url: 'new'},
  {title: 'Swang2', description: 'The best', details: 'The best', hand: true, image_url: 'new'},
  {title: 'Swang3', description: 'The best', details: '', hand: true, image_url: 'new'},
  {title: 'Swang4', description: 'The best', details: '', hand: true, image_url: 'new'},
  {title: 'Swang5', description: 'The best', details: '', hand: true, image_url: 'new'},
  {title: 'Swang6', description: 'The best', details: '', hand: true, image_url: 'new'},
  {title: 'Swang7', description: 'The best', details: 'The best', hand: true, image_url: 'new'},
  {title: 'Swang8', description: 'The best', details: 'The best', hand: true, image_url: 'new'},
  {title: 'Swang9', description: 'The best', details: 'The best', hand: true, image_url: 'new'}
])

users = User.create!([
  {email: 'test@test.com', password: '123456', admin: true},
  {email: 'test@mail.com', password: '123456'}
])

#Product.destroy_all
#User.destroy_all

