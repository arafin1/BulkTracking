# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create Buyers
buyer1 = Buyer.find_or_create_by(email: "hm@example.com") do |b|
  b.name = "H&M"
  b.country = "Sweden"
end

buyer2 = Buyer.find_or_create_by(email: "zara@example.com") do |b|
  b.name = "Zara"
  b.country = "Spain"
end

buyer3 = Buyer.find_or_create_by(email: "next@example.com") do |b|
  b.name = "Next"
  b.country = "UK"
end


puts "✅ Buyers created"

# Create Styles
style1 = Style.find_or_create_by(style_number: "ST001") do |s|
  s.description = "Men's Polo Shirt"
  s.buyer = buyer1
end

style2 = Style.find_or_create_by(style_number: "ST002") do |s|
  s.description = "Women's Embroidery Top"
  s.buyer = buyer2
end

style3 = Style.find_or_create_by(style_number: "ST003") do |s|
  s.description = "Kids Casual Shirt"
  s.buyer = buyer3
end

puts "✅ Styles created"

# Create Samples
sample1 = Sample.create(
  style: style1,
  sample_type: "Proto",
  date_sent: Date.today - 20,
  status: "approved",
  buyer_comments: "Approved. Proceed to bulk"
)

sample2 = Sample.create(
  style: style2,
  sample_type: "Salesman",
  date_sent: Date.today - 10,
  status: "pending",
  buyer_comments: "Please check embroidery"
)

sample3 = Sample.create(
  style: style3,
  sample_type: "Pre Production",
  date_sent: Date.today - 5,
  status: "rejected",
  buyer_comments: "Wrong fabric used"
)

puts "✅ Samples created"

# Create Bulk Orders
BulkOrder.create(
  sample: sample1,
  quantity: 5000,
  quantity_unit: "pcs",
  delivery_date: Date.today + 30,
  production_status: "in_progress",
  factory_notes: "Running on schedule"
)

BulkOrder.create(
  sample: sample1,
  quantity: 2000,
  quantity_unit: "yds",
  delivery_date: Date.today + 45,
  production_status: "not_started",
  factory_notes: "Waiting for fabric"
)

puts "✅ Bulk Orders created"

puts ""
puts "🎉 Seed data complete!"
puts "Buyers: #{Buyer.count}"
puts "Styles: #{Style.count}"
puts "Samples: #{Sample.count}"
puts "Bulk Orders: #{BulkOrder.count}"