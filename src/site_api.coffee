utils = require "./utils"
gmo = require "./gmo_api"

class SiteAPI extends gmo.GMOAPI
  constructor: (options = {}) ->
    @host      = options.host
    @site_id   = options.site_id
    @site_pass = options.site_pass
    unless @site_id && @site_pass && @host
      throw new Error("ArgumentError: Initialize must receive a hash with site_id, site_pass and either host!")

  saveMember: (options, cb) ->
    name = "SaveMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  updateMember: (options, cb) ->
    name = "UpdateMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  deleteMember: (options, cb) ->
    name = "DeleteMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  searchMember: (options, cb) ->
    name = "SearchMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  saveCard: (options, cb) ->
    name = "SaveCard.idPass"
    required = ["member_id", "card_no", "expire"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  deleteCard: (options, cb) ->
    name = "DeleteCard.idPass"
    required = ["member_id", "card_seq"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  updateMember: (options, cb) ->
    name = "UpdateMember.idPass"
    required = ["member_id"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  searchCard: (options, cb) ->
    name = "SearchCard.idPass"
    required = ["member_id", "card_seq", "seq_mode"]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

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

module.exports.SiteAPI = SiteAPI