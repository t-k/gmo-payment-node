gmo = require "../src/gmo"
assert = require "assert"
helper = require "./spec_helper"

describe "ShopAndSiteAPI", ->
  before (done) ->
    opt =
      host: helper.conf.host
      site_id: helper.conf.site_id
      site_pass: helper.conf.site_pass
      shop_id: helper.conf.shop_id
      shop_pass: helper.conf.shop_pass
    @service = new gmo.ShopAndSiteAPI opt
    done()

  describe "#initialize", ->
    it "should throws an error if no config values provided", (done) ->
      try
        service = new gmo.ShopAndSiteAPI
      catch error
        assert.equal(error, "Error: ArgumentError: Initialize must receive a hash with shop_id, shop_pass, site_id, site_pass and either host!")
      done()

    it "should user config values from args", (done) ->
      opt =
        host: "foo.com"
        site_id: "site_id"
        site_pass: "site_pass"
        shop_id: "shop_id"
        shop_pass: "shop_pass"
      service = new gmo.ShopAndSiteAPI opt
      assert.equal service.host, opt.host
      assert.equal service.site_id, opt.site_id
      assert.equal service.site_pass, opt.site_pass
      assert.equal service.shop_id, opt.shop_id
      assert.equal service.shop_pass, opt.shop_pass
      done()