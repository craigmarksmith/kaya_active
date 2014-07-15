task :import => :environment do
  count = 0
  Dir.glob("/Users/craigmarksmith/Programming/kaya_images/*.jpg") do |image|
    response = Cloudinary::Uploader.upload(image)
    puts response.inspect
    Product.create!(name: "Product #{count+=1}", cloudinary_image_ref: response['public_id'])
    break if count == 10
  end
end