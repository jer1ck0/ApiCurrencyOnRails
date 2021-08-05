json.array! @currencies do |cur|
    json.id cur.id
    json.name cur.name
    json.rate cur.rate
  end