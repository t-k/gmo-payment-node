utils = require "./utils"
gmo = require "./gmo_api"

# ShopAndSiteAPI
# -
# GMO moduleでは、API呼び出しにGMOから与えられたショップID、ショップパス、サイトID、サイトパスが必要になるAPIをShopAndSite APIと定義しています。
#
# 初期化の際には、GMOから指定されたショップID、ショップパス、サイトID、サイトパス、APIのホスト名を引数で渡す必要があります。
class ShopAndSiteAPI extends gmo.GMOAPI
  constructor: (options = {}) ->
    @host      = options.host
    @site_id   = options.site_id
    @site_pass = options.site_pass
    @shop_id   = options.shop_id
    @shop_pass = options.shop_pass
    unless @shop_id && @shop_pass && @site_id && @site_pass && @host
      throw new Error("ArgumentError: Initialize must receive a hash with shop_id, shop_pass, site_id, site_pass and either host!")

  # 2.17.2.1.決済後カード登録
  # ---
  # ###entryTran
  # 指定されたオーダーID の取引に使用したカードを登録します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  tradedCard: (options, cb) ->
    name = "TradedCard.idPass"
    required = [
      "order_id"
      "member_id"
    ]
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

module.exports = ShopAndSiteAPI