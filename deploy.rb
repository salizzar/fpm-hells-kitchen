require 'aws-sdk'

args = {
  access_key_id:      ENV['AWS_ACCESS_KEY'],
  secret_access_key:  ENV['AWS_SECRET_KEY'],
}

bucket_name = ENV['S3_BUCKET_NAME']
folder_name = ENV['S3_FOLDER_NAME']

s3 = AWS::S3.new args
bucket = s3.buckets[bucket_name]

packages = Dir["#{folder_name}/**/pkg/*.rpm"]

packages.each do |package|
  path = File.join(folder_name, File.basename(package))

  object = bucket.objects[path]
  object.write(file: package)

  puts %{
    Successfully uploaded #{package}.
    Uploaded to: #{object.public_url}
    To download: #{object.url_for(:read)}
  }
end

