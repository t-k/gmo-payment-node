utils = require "./utils"
gmo = require "./gmo_api"

class ShopAndSiteAPI extends gmo.GMOAPI
  constructor: (options = {}) ->
    @host      = options.host
    @site_id   = options.site_id
    @site_pass = options.site_pass
    @shop_id   = options.shop_id
    @shop_pass = options.shop_pass
    unless @shop_id && @shop_pass && @site_id && @site_pass && @host
      throw new Error("ArgumentError: Initialize must receive a hash with shop_id, shop_pass, site_id, site_pass and either host!")

  tradedCard: (options, cb) ->
    name = "TradedCard.idPass"
    required = ["order_id", "member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  apiCall: (name, options, cb) ->
    extra_params =
      "site_id": @site_id
      "site_pass": @site_pass
      "shop_id": @shop_id
      "shop_pass": @shop_pass
    params = utils.extend(options, extra_params)
    @api name, params, cb

module.exports.ShopAndSiteAPI = ShopAndSiteAPI