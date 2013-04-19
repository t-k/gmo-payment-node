gmo = require "../src/gmo"
assert = require "assert"
helper = require "./spec_helper"

describe "SiteAPI", ->
  before (done) ->
    opt =
      host: helper.conf.host
      site_id: helper.conf.site_id
      site_pass: helper.conf.site_pass
    @service = new gmo.SiteAPI opt
    done()

  describe "#initialize", ->
    it "should throws an error if no config values provided", (done) ->
      try
        service = new gmo.SiteAPI
      catch error
        assert.equal(error, "Error: ArgumentError: Initialize must receive a hash with site_id, site_pass and either host!")
      done()

    it "should user config values from args", (done) ->
      opt =
        host: "foo.com"
        site_id: "site_id"
        site_pass: "site_pass"
      service = new gmo.SiteAPI opt
      assert.equal service.host, opt.host
      assert.equal service.site_id, opt.site_id
      assert.equal service.site_pass, opt.site_pass
      done()