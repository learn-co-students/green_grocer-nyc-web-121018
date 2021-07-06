def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do|food_hash|
    food_hash.each do|food_item, info_hash|

      if new_cart.include?(food_item)
        new_cart[food_item][:count]+= 1
      else
        new_cart[food_item]= {
          :price => info_hash[:price],
          :clearance => info_hash[:clearance],
          :count => 1
        }
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
 result = {}
cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  end
  result
end

def apply_clearance(cart)
  # code here

  cart.collect do|food, info_hash|
    if info_hash[:clearance] == true
    info_hash[:price]=  info_hash[:price] * 4/5

end
end
cart
end


def checkout(cart, coupons)
  # code here
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1, coupons)
  cart3 = apply_clearance(cart2)

  total = 0

  cart3.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end

  total > 100 ? total * 0.9 : total

end
