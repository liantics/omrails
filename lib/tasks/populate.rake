namespace :db do
desc "Fill database with sample data"
	task populate: :environment do
		10.times do |n|
		puts "[DEBUG] creating user #{n+1} of 10"
		name = Faker::Name.name
		email = "user-#{n+1}@example.com"
		password = "password"
		User.create!(name: name,
		email: email,
		password: password,
		password_confirmation: password)
		end

		User.all.each do |user|
		puts "[DEBUG] uploading images for user #{user.id} of #{User.last.id}"
			10.times do |n|
			puts "[DEBUG] before image file open"
			image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample)
			puts "[DEBUG] after image file open"
			description = %w(cool awesome crazy wow adorbs incredible).sample
			puts "[DEBUG] creating image #{n+1} of 10 for #{User.last.id}"
			user.pins.create!(image: image,
			description: description)
			puts "[DEBUG] image created #{n+1} of 10 for #{User.last.id}"

			end
		end
	end
end