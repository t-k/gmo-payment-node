utils = require "./utils"
gmo = require "./gmo_api"

# ShopAPI
# -
# GMO moduleでは、API呼び出しにGMOから与えられたショップID、ショップパスが必要になるAPIをShop APIと定義しています。 取引登録、決済ステータス変更等、決済に関するAPIが主です。
#
# 初期化の際には、GMOから指定されたショップID、ショップパス、APIのホスト名を引数で渡す必要があります。
class ShopAPI extends gmo.GMOAPI
  constructor: (options = {}) ->
    @host      = options.host
    @shop_id   = options.shop_id
    @shop_pass = options.shop_pass
    unless @shop_id && @shop_pass && @host
      throw new Error("ArgumentError: Initialize must receive a hash with shop_id, shop_pass and either host!")

  # 2.1.2.1.取引登録
  # ---
  # ###entryTran
  # これ以降の決済取引で必要となる取引 ID と取引パスワードの発行を行い、取引を開始します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  entryTran: (options, cb) ->
    name = "EntryTran.idPass"
    required = [
      "order_id"
      "job_cd"
    ]
    required.push("amount") if options["job_cd"] && options["job_cd"] != "CHECK"
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.2.2.2.決済実行
  # ---
  # ###execTran
  # カード番号と有効期限の情報を使用して、カード会社と通信を行い決済を実施し、結果を返します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  execTran: (options, cb) ->
    name = "ExecTran.idPass"
    if options["client_field_1"] || options["client_field_2"] || options["client_field_3"]
      options["client_field_flg"] = "1"
    else
      options["client_field_flg"] = "0"
    options["device_category"] = "0"
    required = [
      "access_id"
      "access_pass"
      "order_id"
      "card_no"
      "expire"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.14.2.1.決済変更
  # ---
  # ###alterTran
  # 仮売上の決済に対して実売上を行います。尚、実行時に仮売上時との金額チェックを行います。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  alterTran: (options, cb) ->
    name = "AlterTran.idPass"
    required = [
      "access_id"
      "access_pass"
      "job_cd"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.15.2.1.金額変更
  # ---
  # ###changeTran
  # 決済が完了した取引に対して金額の変更を行います。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  changeTran: (options, cb) ->
    name = "ChangeTran.idPass"
    required = [
      "access_id"
      "access_pass"
      "job_cd"
      "amount"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.16.2.1.取引状態参照
  # ---
  # ###searchTrade
  # 指定したオーダーID の取引情報を取得します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  searchTrade: (options, cb) ->
    name = "SearchTrade.idPass"
    required = ["order_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 13.1.2.1.取引状態参照
  # ---
  # ###searchTradeMulti
  # 指定したオーダーIDの取引情報を取得します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  searchTradeMulti: (options, cb) ->
    name = "SearchTradeMulti.idPass"
    required = [
      "order_id"
      "pay_type"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  apiCall: (name, options, cb) ->
    extra_params =
      "shop_id": @shop_id
      "shop_pass": @shop_pass
    params = utils.extend(options, extra_params)
    @api name, params, cb

module.exports = ShopAPI