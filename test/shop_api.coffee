gmo = require "../src/gmo"
assert = require "assert"
helper = require "./spec_helper"
# nvcr = require "nock-vcr"

describe "ShopAPI", ->
  before (done) ->
    opt =
      host: helper.conf.host
      shop_id: helper.conf.shop_id
      shop_pass: helper.conf.shop_pass
    @service = new gmo.ShopAPI opt
    done()

  describe "#entryTran", ->
    it "should have AccessID, AccessPass", (done) ->
      order_id = helper.generateOrderId()
      options =
        order_id: order_id
        job_cd: "AUTH"
        amount: "100"
      # nvcr.insertCassette '#entryTran should have AccessID AccessPass'
      @service.entryTran options , (err, res) ->
        assert.notEqual res["AccessID"], null
        assert.notEqual res["AccessPass"], null
        # nvcr.ejectCassette()
        done()
