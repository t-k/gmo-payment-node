gmo = require "../src/gmo"
assert = require "assert"
helper = require "./spec_helper"
fs = require "fs"
Replay = require "replay"
Replay.mode = "record"

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
      @service.entryTran options , (err, res) ->
        assert.notEqual res["AccessID"], null
        assert.notEqual res["AccessPass"], null
        done()

    it "should throws an error if no config values provided", (done) ->
      try
        order_id = helper.generateOrderId()
        @service.entryTran {} , (err, res) -> ;
      catch error
        assert.equal(error, "Error: ArgumentError: Required order_id, job_cd were not provided.")
      done()

  describe "#execTran", ->
    it "should have data about a transaction", (done) ->
      order_id = "1366398099976"
      access_id = "6cf5c999ee7fb7ed2cf5c175fe6d0c62"
      access_pass = "a7cf9525cb9317f03e90180c3536e5f8"
      client_field_1 = "hogehoge"
      options =
        order_id: order_id
        access_id: access_id
        access_pass: access_pass
        card_no: "4111111111111111"
        expire: "1405"
        pay_times: "1"
        method: "1"
        client_field_1: client_field_1
      @service.execTran options , (err, res) ->
        assert.notEqual res["ACS"], null
        assert.notEqual res["OrderID"], null
        assert.notEqual res["Forward"], null
        assert.notEqual res["Method"], null
        assert.notEqual res["PayTimes"], null
        assert.notEqual res["Approve"], null
        assert.notEqual res["TranID"], null
        assert.notEqual res["TranDate"], null
        assert.notEqual res["CheckString"], null
        assert.notEqual res["ClientField1"], null
        assert.equal res["ClientField1"], client_field_1
        done()

  describe "#alterTran", ->
    it "should have data about a transaction", (done) ->
      order_id = "1366398099976"
      access_id = "6cf5c999ee7fb7ed2cf5c175fe6d0c62"
      access_pass = "a7cf9525cb9317f03e90180c3536e5f8"
      options =
        order_id: order_id
        access_id: access_id
        access_pass: access_pass
        card_no: "4111111111111111"
        expire: "1405"
        pay_times: "1"
        method: "1"
      @service.execTran options , (err, res) =>
        options =
          access_id: access_id
          access_pass: access_pass
          job_cd: "AUTH"
          amount: 100
        @service.alterTran options , (err, res) ->
          assert.notEqual res["AccessID"], null
          assert.notEqual res["AccessPass"], null
          assert.notEqual res["Forward"], null
          assert.notEqual res["Approve"], null
          assert.notEqual res["TranID"], null
          assert.notEqual res["TranDate"], null
          done()

  describe "#changeTran", ->
    it "should have data about a transaction", (done) ->
      access_id = "9e6c3b46f7fd03ac22693b335286e622"
      access_pass = "faec7412b6090024b0a700cd0218a0f5"
      options =
        access_id: access_id
        access_pass: access_pass
        job_cd: "AUTH"
        amount: "1000"
      @service.changeTran options , (err, res) ->
        assert.notEqual res["AccessID"], null
        assert.notEqual res["AccessPass"], null
        assert.notEqual res["Forward"], null
        assert.notEqual res["Approve"], null
        assert.notEqual res["TranID"], null
        assert.notEqual res["TranDate"], null
        done()

  describe "#searchTrade", ->
    it "should have data about a transaction", (done) ->
      order_id = "1366400470231"
      options =
        order_id: order_id
      @service.searchTrade options , (err, res) ->
        assert.notEqual res["OrderID"], null
        assert.notEqual res["AccessID"], null
        assert.notEqual res["AccessPass"], null
        assert.notEqual res["Forward"], null
        assert.notEqual res["Approve"], null
        assert.notEqual res["TranID"], null
        done()
