utils = require "./utils"
gmo = require "./gmo_api"

# SiteAPI
# -
# GMO moduleでは、API呼び出しにGMOから与えられたサイトID、サイトパスが必要になるAPIをSite APIと定義しています。 主にカードや会員に関する操作を担っているAPI群となります。 取引登録、決済ステータス変更等、決済に関するAPIが主です。
#
# 初期化の際には、GMOから指定されたサイトID、サイトパス、APIのホスト名を引数で渡す必要があります。
class SiteAPI extends gmo.GMOAPI
  constructor: (options = {}) ->
    @host      = options.host
    @site_id   = options.site_id
    @site_pass = options.site_pass
    unless @site_id && @site_pass && @host
      throw new Error("ArgumentError: Initialize must receive a hash with site_id, site_pass and either host!")

  # 2.3.2.1.会員登録
  # ---
  # ###saveMember
  # 以降の決済取引で必要となる取引 ID と取引パスワードの発行を行い、取引を開始します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  saveMember: (options, cb) ->
    name = "SaveMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.4.2.1.会員更新
  # ---
  # ###updateMember
  # 指定されたサイトに会員情報を更新します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  updateMember: (options, cb) ->
    name = "UpdateMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.5.2.1.会員削除
  # ---
  # ###deleteMember
  # 指定したサイトから会員情報を削除します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  deleteMember: (options, cb) ->
    name = "DeleteMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.6.2.1.会員参照
  # ---
  # ###searchMember
  # 指定したサイトの会員情報を参照します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  searchMember: (options, cb) ->
    name = "SearchMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.7.2.1.カード登録/更新
  # ---
  # ###saveCard
  # 指定した会員にカード情報を登録します。尚、サイトに設定されたショップ ID を使用してカード会社と通信を行い有効性の確認を行います。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  saveCard: (options, cb) ->
    name = "SaveCard.idPass"
    required = ["member_id", "card_no", "expire"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.8.2.1.カード削除
  # ---
  # ###deleteCard
  # 指定した会員のカード情報を削除します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  deleteCard: (options, cb) ->
    name = "DeleteCard.idPass"
    required = ["member_id", "card_seq"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.9.2.1.カード参照
  # ---
  # ###searchCard
  # お客様が選択したカード登録連番のカード情報を取得します。 カード情報が本人認証サービスに対応していない場合は、カード会社との通信を行い決済を実行します。その際の出力パラメータは「2.10.2.3決済実行」の出力パラメータと同じになります。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  searchCard: (options, cb) ->
    name = "SearchCard.idPass"
    required = ["member_id", "card_seq", "seq_mode"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 2.11.2.3. 決済実行
  # ---
  # ###execTran
  # お客様が選択したカード登録連番のカード情報を取得します。 カード情報が本人認証サービスに対応していない場合は、カード会社との通信を行い決済を実行します。その際の出力パラメータは「2.10.2.3決済実行」の出力パラメータと同じになります。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  execTran: (options, cb) ->
    name = "ExecTran.idPass"
    required = ["access_id", "access_pass", "order_id", "member_id", "card_seq"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  apiCall: (name, options, cb) ->
    extra_params =
      "site_id": @site_id
      "site_pass": @site_pass
    params = utils.extend(options, extra_params)
    @api name, params, cb

module.exports = SiteAPI