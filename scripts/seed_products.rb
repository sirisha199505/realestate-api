require_relative '../src/app'
require 'bundler'
Bundler.require(:default)

App.load!

puts "Seeding products..."

PRODUCTS = [
  # Rotis
  { name: 'Classic Phulka',    category: 'Rotis',    description: 'Soft, thin whole-wheat roti cooked on direct flame. Perfect with any dal or sabzi.',          price: 5,   badge: 'Bestseller', badge_color: '#E67E22', rating: 4.9, orders_count: 1240, image_url: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=400&q=80' },
  { name: 'Butter Roti',       category: 'Rotis',    description: 'Phulka generously smeared with pure desi ghee. Soft, fragrant, irresistible.',                 price: 8,   badge: 'Popular',    badge_color: '#F1C40F', rating: 4.8, orders_count: 980,  image_url: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=400&q=80' },
  { name: 'Tandoori Roti',     category: 'Rotis',    description: 'Thick, chewy whole-wheat roti baked in a clay tandoor. Smoky & rustic.',                       price: 12,  badge: nil,          badge_color: nil,       rating: 4.7, orders_count: 760,  image_url: 'https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=400&q=80' },
  { name: 'Missi Roti',        category: 'Rotis',    description: 'Spiced chickpea-wheat blend roti with carom seeds & fresh methi. Nutritious.',                 price: 14,  badge: 'Healthy',    badge_color: '#27AE60', rating: 4.6, orders_count: 540,  image_url: 'https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=400&q=80' },
  # Parathas
  { name: 'Aloo Paratha',      category: 'Parathas', description: 'Crispy layered paratha stuffed with spiced mashed potatoes. Served with dahi.',                price: 35,  badge: 'Bestseller', badge_color: '#E67E22', rating: 4.9, orders_count: 2100, image_url: 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d6?auto=format&fit=crop&w=400&q=80' },
  { name: 'Paneer Paratha',    category: 'Parathas', description: 'Flaky paratha loaded with crumbled spiced cottage cheese. Rich & filling.',                    price: 45,  badge: 'Premium',    badge_color: '#9B59B6', rating: 4.8, orders_count: 1750, image_url: 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d6?auto=format&fit=crop&w=400&q=80' },
  { name: 'Mooli Paratha',     category: 'Parathas', description: 'Stuffed with grated white radish & spices. A Punjabi winter classic.',                         price: 32,  badge: 'Seasonal',   badge_color: '#2ECC71', rating: 4.7, orders_count: 820,  image_url: 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d6?auto=format&fit=crop&w=400&q=80' },
  { name: 'Plain Layered Paratha', category: 'Parathas', description: 'Multi-layered flaky paratha cooked on tawa with ghee. Simple perfection.',                price: 22,  badge: nil,          badge_color: nil,       rating: 4.6, orders_count: 1100, image_url: 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d6?auto=format&fit=crop&w=400&q=80' },
  # Combos
  { name: 'Dal Roti Combo',    category: 'Combos',   description: '4 phulkas + creamy dal makhani + raita + pickle. Complete meal deal.',                         price: 99,  badge: 'Hot Deal',   badge_color: '#E74C3C', rating: 4.9, orders_count: 3200, image_url: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=400&q=80' },
  { name: 'Paneer Paratha Combo', category: 'Combos', description: '2 paneer parathas + butter + dahi + green chutney. Punjabi bliss.',                           price: 129, badge: 'Family Fav', badge_color: '#E67E22', rating: 4.8, orders_count: 2800, image_url: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=400&q=80' },
  { name: 'Thali Special',     category: 'Combos',   description: '3 rotis + 2 parathas + sabzi + dal + rice + salad + dessert.',                                 price: 189, badge: 'Value Pack', badge_color: '#F39C12', rating: 4.9, orders_count: 1600, image_url: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=400&q=80' },
  { name: 'Bulk Office Pack',  category: 'Combos',   description: '20 rotis + 2 curries + raita. Perfect for office lunches. Free delivery.',                     price: 350, badge: 'Best Value', badge_color: '#2980B9', rating: 4.7, orders_count: 920,  image_url: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=400&q=80' },
  # Curries
  { name: 'Dal Makhani',       category: 'Curries',  description: 'Slow-cooked black lentils in buttery tomato gravy. 12-hour simmered.',                         price: 79,  badge: "Chef's Pick", badge_color: '#E67E22', rating: 4.9, orders_count: 2400, image_url: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=400&q=80' },
  { name: 'Palak Paneer',      category: 'Curries',  description: 'Fresh cottage cheese cubes in silky spinach gravy. Nutritious & rich.',                        price: 89,  badge: 'Healthy',    badge_color: '#27AE60', rating: 4.8, orders_count: 1900, image_url: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=400&q=80' },
  { name: 'Chole Masala',      category: 'Curries',  description: 'Spiced chickpeas in tangy onion-tomato gravy. A Punjabi staple.',                              price: 69,  badge: nil,          badge_color: nil,       rating: 4.7, orders_count: 1400, image_url: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=400&q=80' },
  { name: 'Mix Veg Curry',     category: 'Curries',  description: 'Seasonal vegetables cooked in a mildly spiced tomato-cashew sauce.',                           price: 65,  badge: 'Light',      badge_color: '#16A085', rating: 4.6, orders_count: 1100, image_url: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=400&q=80' },
]

PRODUCTS.each do |p|
  existing = App::Models::Product.find(name: p[:name])
  if existing
    puts "  skip (exists): #{p[:name]}"
  else
    App::Models::Product.create(p.merge(active: true))
    puts "  created: #{p[:name]}"
  end
end

puts "Done. #{App::Models::Product.count} products total."
