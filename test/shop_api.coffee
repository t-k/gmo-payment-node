gmo = require "../src/gmo"
assert = require "assert"
helper = require "./spec_helper"
nvcr = require "nock-vcr"

describe "ShopAPI", ->
  before (done) ->
    opt =
      host: helper.conf.host
      shop_id: helper.conf.shop_id
      shop_pass: helper.conf.shop_pass
    @service = new gmo.ShopAPI opt
    done()

  describe "#initialize", ->
    it "should throws an error if no config values provided", (done) ->
      try
        service = new gmo.ShopAPI
      catch error
        assert.equal(error, "Error: ArgumentError: Initialize must receive a hash with shop_id, shop_pass and either host!")
      done()

    it "should user config values from args", (done) ->
      opt =
        host: "foo.com"
        shop_id: "shop_id"
        shop_pass: "shop_pass"
      service = new gmo.ShopAPI opt
      assert.equal service.host, opt.host
      assert.equal service.shop_id, opt.shop_id
      assert.equal service.shop_pass, opt.shop_pass
      done()

  describe "#entryTran", ->
    it "should have AccessID, AccessPass", (done) ->
      order_id = helper.generateOrderId()
      options =
        order_id: order_id
        job_cd: "AUTH"
        amount: "100"
      nvcr.insertCassette '#entryTran should have AccessID AccessPass'
      @service.entryTran options , (err, res) ->
        assert.notEqual res["AccessID"], null
        assert.notEqual res["AccessPass"], null
        nvcr.ejectCassette()
        done()
