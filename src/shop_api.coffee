utils = require "./utils"
gmo = require "./gmo_api"

class ShopAPI extends gmo.GMOAPI
  constructor: (options = {}) ->
    @host      = options.host
    @shop_id   = options.shop_id
    @shop_pass = options.shop_pass
    unless @shop_id && @shop_pass && @host
      throw new Error("ArgumentError: Initialize must receive a hash with shop_id, shop_pass and either host!")

  entryTran: (options, cb) ->
    name = "EntryTran.idPass"
    required = ["order_id", "job_cd"]
    required.push("amount") if options["job_cd"] && options["job_cd"] != "CHECK"
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  execTran: (options, cb) ->
    name = "ExecTran.idPass"
    if options["client_field_1"] || options["client_field_2"] || options["client_field_3"]
      options["client_field_flg"] = "1"
    else
      options["client_field_flg"] = "0"
    options["device_category"] = "0"
    required = ["access_id", "access_pass", "order_id", "card_no", "expire"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  alterTran: (options, cb) ->
    name = "AlterTran.idPass"
    required = ["access_id", "access_pass", "job_cd"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  changeTran: (options, cb) ->
    name = "ChangeTran.idPass"
    required = ["access_id", "access_pass", "job_cd", "amount"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  searchTrade: (options, cb) ->
    name = "SearchTrade.idPass"
    required = ["order_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  searchTradeMulti: (options, cb) ->
    name = "SearchTradeMulti.idPass"
    required = ["order_id", "pay_type"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  apiCall: (name, options, cb) ->
    extra_params =
      "shop_id": @shop_id
      "shop_pass": @shop_pass
    params = utils.extend(options, extra_params)
    @api name, params, cb

module.exports.ShopAPI = ShopAPI