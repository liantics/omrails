# initializers/s3.rb
  # set credentials from ENV hash
  S3_CREDENTIALS = { 
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
  	:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], 
  	:bucket => ENV['S3_BUCKET_NAME']
  }
