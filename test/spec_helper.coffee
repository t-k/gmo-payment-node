module.exports =
  generateOrderId: ->
    date = new Date
    date.getTime().toString()

  conf:
    host: "hoge.mul-pay.jp"
    shop_id: "shop_id"
    shop_pass: "shop_pass"
    site_id: "site_id"
    site_pass: "site_pass"