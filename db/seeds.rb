# Users
controlled_users = [
  ["camol88@gmail.com",            "Kamil",   'Leczycki', '12345678', true  ],
  ["martyna@gmail.com",            "Martyna",   'Waniewska', '12345678', false  ],
  ["michal@gmail.com",            "Michal",   'Leczycki', '12345678', false  ],
  ["karol@gmail.com",            "Karol",   'Morawski', '12345678', false  ],
  ["piotr@gmail.com",            "Piotr",   'Waniewski', '12345678', false  ],
]

controlled_users.each_with_index do |index, mail, name, surname, password, admin|
  User.find_or_create_by_email(mail, {
    login: name,
    name: name,
    surname: surname,
    password: password,
    password_confirmation: password,
    enabled: true,
    admin: admin,
  })
end


20.times do |i|
  User.find_or_create_by_email("dummy_#{i}@gmail.com",{
    login: "dummy_#{i}",
    name: "Dummy_#{i}",
    surname: "Dummy",
    password: "12345678",
    password_confirmation: "12345678",
    enabled: true,
    admin: false,
  })
end


User.all.each do |user|
  4.times do |i|
    user.root_catalog.children.create(catalogable: user.root_catalog, name: "#{user.name}_#{i}", description: "Seeded catalog", creator_id: user.id)
  end
end

controlled_users.each do |email|
  user = User.find_by_email(email)

  2.times do |i|
    user.groups.create(name: "#{user.name}'s Group_#{i}")
    user.projects.create(name: "#{user.name}'s Project_#{i}")
  end
end
