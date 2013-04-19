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

  describe "#saveMember", ->
    it "should have data about a transaction", (done) ->
      member_name = "John Smith"
      client_field_1 = "hogehoge"
      options =
        member_id: "111111111111"
        member_name: member_name
      @service.saveMember options , (err, res) ->
        assert.notEqual res["MemberID"], null
        done()

  describe "#updateMember", ->
    it "should have data about a transaction", (done) ->
      member_name = "John Smith2"
      options =
        member_id: "111111111111"
        member_name: member_name
      @service.updateMember options , (err, res) ->
        assert.notEqual res["MemberID"], null
        done()

  describe "#deleteMember", ->
    it "should have data about a transaction", (done) ->
      options =
        member_id: "111111111111"
      @service.deleteMember options , (err, res) ->
        assert.notEqual res["MemberID"], null
        done()

  describe "#searchMember", ->
    it "should have data about a transaction", (done) ->
      options =
        member_id: "1111111111112"
      @service.searchMember options , (err, res) ->
        assert.notEqual res["MemberID"], null
        done()

  describe "#saveCard", ->
    it "should have data about a transaction", (done) ->
      card_no = "4111111111111111"
      options =
        member_id: "1111111111112"
        card_no: card_no
        expire: "1405"
      @service.saveCard options , (err, res) ->
        assert.notEqual res["CardNo"], null
        done()

  describe "#searchCard", ->
    it "should have data about a transaction", (done) ->
      options =
        member_id: "1111111111112"
        seq_mode: "0"
        card_seq: "0"
      @service.searchCard options , (err, res) ->
        assert.notEqual res["CardNo"], null
        assert.notEqual res["CardSeq"], null
        assert.notEqual res["DefaultFlag"], null
        assert.notEqual res["CardName"], null
        assert.notEqual res["Expire"], null
        assert.notEqual res["HolderName"], null
        assert.notEqual res["DeleteFlag"], null
        done()

  describe "#deleteCard", ->
    it "should have data about a transaction", (done) ->
      options =
        member_id: "1111111111112"
        card_seq: "0"
      @service.deleteCard options , (err, res) ->
        assert.notEqual res["CardSeq"], null
        done()