json.array!(@hold_deals) do |hold_deal|
  json.extract! hold_deal, 
  json.url hold_deal_url(hold_deal, format: :json)
end