class App::Services::Orders < App::Services::Base
  def model; App::Models::Order; end

  def list
    ds = model.order(Sequel.desc(:created_at))
    ds = ds.where(status: qs[:status]) if qs[:status].present?
    count = ds.count
    return_success(
      ds.offset(offset).limit(limit).all.map(&:to_pos),
      total_pages: (count / page_size.to_f).ceil,
      total_count: count
    )
  end

  def get
    return_success(item.to_pos)
  end

  # Public — called from enquiry form (no auth required)
  def place
    p = qs  # params come directly (not nested under :data)

    name  = p[:customer_name].to_s.strip
    phone = p[:customer_phone].to_s.strip

    if name.empty? || phone.empty?
      return_errors!('customer_name and customer_phone are required')
    end

    raw_items = p[:items]
    items_arr = case raw_items
                when Array  then raw_items.map(&:to_h)
                when String then (JSON.parse(raw_items) rescue [])
                else []
                end

    order = model.new(
      customer_name:  name,
      customer_phone: phone,
      address_flat:   p[:address_flat].to_s,
      address_area:   p[:address_area].to_s,
      address_city:   p[:address_city].to_s,
      address_pin:    p[:address_pin].to_s,
      payment_method: p[:payment_method].to_s.presence || 'enquiry',
      items:          Sequel.pg_jsonb(items_arr),
      item_total:     p[:item_total].to_i,
      delivery_fee:   p[:delivery_fee].to_i,
      platform_fee:   p[:platform_fee].to_i,
      grand_total:    p[:grand_total].to_i,
      status:         'pending',
    )

    App.logger.info("Placing order for: #{name} / #{phone}")

    if order.save
      App.logger.info("Order saved with id=#{order.id}")
      return_success(order.to_pos)
    else
      App.logger.error("Order save failed: #{order.errors.inspect}")
      return_errors!(order.errors)
    end
  rescue => e
    App.logger.error("place error: #{e.message}\n#{e.backtrace.first(3).join("\n")}")
    return_errors!(e.message)
  end

  # Authenticated user — fetch their own orders by phone number
  def my_orders
    user = App.cu.user_obj
    ds = model.where(customer_phone: user.phone_number.to_s.strip)
              .order(Sequel.desc(:created_at))
    return_success(ds.all.map(&:to_pos))
  rescue => e
    return_errors!(e.message)
  end

  # Admin — update order status
  def update_status
    new_status = qs[:status]
    unless App::Models::Order::STATUSES.include?(new_status)
      return_errors!("Invalid status. Allowed: #{App::Models::Order::STATUSES.join(', ')}")
    end
    item.update(status: new_status)
    return_success(item.to_pos)
  rescue => e
    return_errors!(e.message)
  end

  def self.fields
    { save: [] }
  end
end
