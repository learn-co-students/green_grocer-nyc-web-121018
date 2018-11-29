def consolidate_cart(cart)
      new_cart = {}
  cart.each do|food|
    food.each do|food_item, info_hash|

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
    discount = {}
    cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count]= info[:count] - coupon[:num]
        if discount ["#{food} W/COUPON"]
          discount ["#{food} W/COUPON"][:count] += 1
        else
          discount ["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    discount[food] = info
  end
  discount
end

def apply_clearance(cart)
  cart.map do |food, info_hash|
      if info_hash[:clearance] == true
          info_hash[:price] = info_hash[:price] * 4/5
      end
  end
    cart
end

def checkout(cart, coupons)
  cart_one = consolidate_cart(cart)
  cart_two = apply_coupons(cart_one, coupons)
  cart_three = apply_clearance(cart_two)
    
    total = 0
    
    cart_three.each do |name, price_hash|
         total += price_hash[:price] * price_hash[:count]
  end

  total > 100 ? total * 0.9 : total


end
