


############################################################################################################
CND                       = require 'cnd'
rpr                       = CND.rpr
badge                     = 'JIZURA/tests'
log                       = CND.get_logger 'plain',     badge
info                      = CND.get_logger 'info',      badge
whisper                   = CND.get_logger 'whisper',   badge
alert                     = CND.get_logger 'alert',     badge
debug                     = CND.get_logger 'debug',     badge
warn                      = CND.get_logger 'warn',      badge
help                      = CND.get_logger 'help',      badge
urge                      = CND.get_logger 'urge',      badge
echo                      = CND.echo.bind CND
#...........................................................................................................
test                      = require 'guy-test'
#...........................................................................................................
FLSL                      = require './main'
ƒ                         = Array.from


#===========================================================================================================
# TESTS
#-----------------------------------------------------------------------------------------------------------
@[ "FLSL._is_sublist_at accepts and rejects flat sublists" ] = ( T ) ->
  probes_and_matchers = [
    [ [ ( ƒ 'abcdefgh'  ), 0, 0, 2, ], true,  ]
    [ [ ( ƒ 'abcdefgh'  ), 3, 3, 5, ], true,  ]
    [ [ ( ƒ 'abc'       ), 0, 0, 3, ], true,  ]
    [ [ ( ƒ 'abcdefgh'  ), 1, 0, 2, ], false, ]
    [ [ ( ƒ 'abcdefgh'  ), 0, 3, 5, ], false, ]
    [ [ ( ƒ 'abc'       ), 1, 0, 3, ], false, ]
    [ [ ( ƒ 'abc'       ), 0, 0, 4, ], false, ]
    ]
  for equals in [ ( ( a, b ) -> a is b ), CND.equals, ]
    for [ probe, matcher, ] in probes_and_matchers
      # debug '©60285', probe, matcher, ( FLSL._is_sublist_at probe... )
      T.eq ( FLSL._is_sublist_at probe..., equals ), matcher

#-----------------------------------------------------------------------------------------------------------
@[ "FLSL.find_longest_repeating_sublist 1" ] = ( T ) ->
  probes_and_matchers = [
    [ 'abcdef', null, ]
    [ 'abcabc', 'abc', ]
    [ 'abcdefcd', 'cd', ]
    ]
  for equals in [ null, CND.equals, ]
    for [ probe, matcher, ] in probes_and_matchers
      probe = ƒ probe
      # debug '©26039', ( FLSL.find_longest_repeating_sublist probe ), matcher
      if ( result = FLSL.find_longest_repeating_sublist probe, equals )?
        result = result.join ''
      T.eq result, matcher

#-----------------------------------------------------------------------------------------------------------
@[ "FLSL.find_longest_repeating_sublist 2" ] = ( T ) ->
  probes_and_matchers = [
    [ "fallacy idiocy idiot fall sample cosomos osmosis", "cy idio", ]
    ]
  for equals in [ null, CND.equals, ]
    for [ probe, matcher, ] in probes_and_matchers
      probe = ƒ probe
      if ( result = FLSL.find_longest_repeating_sublist probe, equals )?
        result = result.join ''
      T.eq result, matcher

#-----------------------------------------------------------------------------------------------------------
@[ "FLSL.find_longest_repeating_sublist 3" ] = ( T ) ->
  probes_and_matchers = [
    ["𣎱",["月","日","日","丶","&cdp#x887a;","矢"],["日"]]
    ["叔",["尗","又"],null]
    ["叕",["㕛","㕛"],["㕛"]]
    ["叕",["㕛","㕛"],["㕛"]]
    ["取",["耳","又"],null]
    ["𣎎",["月","龹","人","人"],["人"]]
    ["𣎱",["月","日","日","丶","&cdp#x887a;","矢"],["日"]]
    ["𣓠",["木","戶","戶"],["戶"]]
    ["𣓡",["木","丿","呂"],null]
    ["𣓢",["无","无","木"],["无"]]
    ["𠫒",["厡","厡","厡"],["厡"]]
    ["𧾭",["𣥚","𣥚","𣥚"],["𣥚"]]
    ["𧢛",["䀠","目","几","几","几"],["几"]]
    ]
  for equals in [ null, CND.equals, ]
    for [ glyph, probe, matcher, ] in probes_and_matchers
      result = FLSL.find_longest_repeating_sublist probe, equals
      echo JSON.stringify [ glyph, probe, result, ]
      T.eq result, matcher
  #.........................................................................................................
  return null

#-----------------------------------------------------------------------------------------------------------
@[ "benchmark" ] = ( T, done ) ->
  probes_and_matchers = [
    ["𣎱",["月","日","日","丶","&cdp#x887a;","矢"],["日"]]
    ["叔",["尗","又"],null]
    ["叕",["㕛","㕛"],["㕛"]]
    ["叕",["㕛","㕛"],["㕛"]]
    ["取",["耳","又"],null]
    ["𣎎",["月","龹","人","人"],["人"]]
    ["𣎱",["月","日","日","丶","&cdp#x887a;","矢"],["日"]]
    ["𣓠",["木","戶","戶"],["戶"]]
    ["𣓡",["木","丿","呂"],null]
    ["𣓢",["无","无","木"],["无"]]
    ["𠫒",["厡","厡","厡"],["厡"]]
    ["𧾭",["𣥚","𣥚","𣥚"],["𣥚"]]
    ["𧢛",["䀠","目","几","几","几"],["几"]]
    ]
  #.........................................................................................................
  for equals in [ null, CND.equals, ]
    t0 = +new Date()
    #.......................................................................................................
    for n in [ 0 ... 1e3 ]
      for [ glyph, probe, matcher, ] in probes_and_matchers
        # probe = ƒ probe
        result = FLSL.find_longest_repeating_sublist probe, equals
    #.......................................................................................................
    t1 = +new Date()
    help "equals: #{rpr equals}"
    help "dt: #{t1 - t0}"
  #.........................................................................................................
  done()

###
string = """fallacy idiocy idiot fall sample cosomos osmosis"""
string = """abcdefabc"""

formulas = [
  [ '叔', '尗又' ]
  [ '叕', '㕛㕛' ]
  [ '叕', '双双' ]
  [ '取', '耳又' ]
  [ '𣎎', '月龹人人' ]
  [ '𣎱', '月(日日丶&cdp#x887a;矢)' ]
  [ '𣓠', '(木戶戶)' ]
  [ '𣓡', '木丿呂' ]
  [ '𣓢', '无无木' ]
  ]

# node ../hollerith/lib/dump.js --limit=500 ../jizura-datasources/data/leveldb-v2 "spo|叔|formula/ic0"

glyphs_and_ic0s = [
  [ '𣎱', [ '月', '日', '日', '丶', '&cdp#x887a;', '矢' ], ]
  [ '叔', [ '尗', '又' ], ]
  [ '叕', [ '㕛', '㕛' ], ]
  [ '叕', [ '㕛', '㕛' ], ]
  [ '取', [ '耳', '又' ], ]
  [ '𣎎', [ '月', '龹', '人', '人' ], ]
  [ '𣎱', [ '月', '日', '日', '丶', '&cdp#x887a;', '矢' ], ]
  [ '𣓠', [ '木', '戶', '戶' ], ]
  [ '𣓡', [ '木', '丿', '呂' ], ]
  [ '𣓢', [ '无', '无', '木' ], ]
  ]
###




#===========================================================================================================
# MAIN
#-----------------------------------------------------------------------------------------------------------
@_main = ( handler ) ->
  test @, 'timeout': 2500

# #-----------------------------------------------------------------------------------------------------------
# @_prune = ->
#   for name, value of @
#     continue if name.startsWith '_'
#     delete @[ name ] unless name in include
#   return null

############################################################################################################
unless module.parent?
  # include = []
  # @_prune()
  @_main()

