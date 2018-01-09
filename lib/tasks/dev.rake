namespace :dev do
  # task fake_restaurant: :environment do
  task fake: :environment do
    Restaurant.destroy_all

    200.times do |i|
      Restaurant.create!(
        id: i+1,
        image: File.new(Rails.root.join('app', 'assets', 'images', "pic_#{rand(78).to_s.rjust(3,'0')}.jpg")),
        name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel_no: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  # end

  # task fake_user: :environment do
    num = [*0..72].sample(20)
    20.times do |i|
      User.create!(
        id: i+2,
        avatar: File.new(Rails.root.join('app', 'assets', 'images', "pic1_#{num[i].to_s.rjust(3,'0')}.jpg")),
        email: FFaker::Internet.email,
        password: "123123"
      )
    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  # end

  # task fake_comment: :environment do
    Comment.destroy_all
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.paragraph,
          user: User.all.sample
        )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"
  # end

  # task fake_favorite: :environment do
    Favorite.destroy_all
    User.all.each do |user|
      rand(50).times do |i|
        user.favorites.create!(
          user_id: user.id, 
          restaurant_id: Restaurant.all.sample.id)
      end
    end
    Restaurant.all.each do |restaurant|
      restaurant.favorites_count = Favorite.where(restaurant_id: restaurant.id).count
      restaurant.save
    end
    puts "have created fake favorites"
    puts "now you have #{Favorite.count} favorites data"
  # end

  # task fake_followship: :environment do
    Followship.destroy_all
    User.all.each do |user|
      rand_user = User.select{|x| x!=user}.sample(5)
      rand(5).times do |i|
        user.followships.create!(
          user_id: user.id, 
          following_id: rand_user[i].id)
      end
    end
   
    puts "have created fake followship"
    puts "now you have #{Followship.count} followships data"
  # end

  # task fake_friendship: :environment do
    Friendship.destroy_all
    User.all.each do |user|
      rand_user = User.select{|x| x!=user}.sample(5)
      rand(5).times do |i|
        user.friendships.create!(
          user_id: user.id, 
          friend_id: rand_user[i].id)
      end
    end
   
    puts "have created fake friendship"
    puts "now you have #{Friendship.count} friendships data"
  end

  # task fake_p: :environment do
  #   uploaders = Restaurant.first(10).map(&:image)
  #   Restaurant.last(490).each do |restaurant|
  #     restaurant.image = uploaders.sample
  #   end
  #   puts "other fake image"
  # end
end