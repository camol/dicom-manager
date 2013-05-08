# Users
controlled_users = [
  ["camol88@gmail.com",            "Kamil",   'Leczycki', '12345678', true  ],
  ["martyna@gmail.com",            "Martyna",   'Waniewska', '12345678', false  ],
  ["michal@gmail.com",            "Michal",   'Leczycki', '12345678', false  ],
  ["karol@gmail.com",            "Karol",   'Morawski', '12345678', false  ],
  ["piotr@gmail.com",            "Piotr",   'Waniewski', '12345678', false  ],
]

controlled_users.each do |mail, name, surname, password, admin|
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
  User.find_or_create_by_email("dummy_#{i.to_s}@gmail.com",{
    login: "dummy_#{i.to_s}",
    name: "Dummy_#{i.to_s}",
    surname: "Dummy",
    password: "12345678",
    password_confirmation: "12345678",
    enabled: true,
    admin: false,
  })
end


User.all.each do |user|
  4.times do |i|
    user.root_catalog.children.create(catalogable: user.root_catalog.catalogable, name: "#{user.name}_#{i.to_s}", description: "Seeded catalog", creator_id: user.id)
  end
end

controlled_users.each do |user|
  user = User.find_by_email(user.first)

  2.times do |i|
    user.groups.create(name: "#{user.name}'s Group_#{i.to_s}", creator_id: user.id)
    user.created_projects.create(name: "#{user.name}'s Project_#{i.to_s}", creator_id: user.id)
    user.save!
  end
end

User.all.each do |user|
  non_user_groups = user.groups.any? ? Group.where("id NOT IN (?)", user.groups) : Group.all
  user.groups << Group.find(non_user_groups.map(&:id).sample)
  user.save!
end

Group.all.each do |group|
  non_group_projects = group.projects.any? ? Project.where("id NOT IN (?)", group.projects) : Project.all
  group.projects << Project.find(non_group_projects.map(&:id).sample)
  group.save!
end
