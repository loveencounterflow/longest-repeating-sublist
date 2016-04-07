

############################################################################################################
njs_util                  = require 'util'
njs_path                  = require 'path'
njs_fs                    = require 'fs'
#...........................................................................................................
CND                       = require 'cnd'
rpr                       = CND.rpr
badge                     = 'scratch'
log                       = CND.get_logger 'plain',     badge
info                      = CND.get_logger 'info',      badge
whisper                   = CND.get_logger 'whisper',   badge
alert                     = CND.get_logger 'alert',     badge
debug                     = CND.get_logger 'debug',     badge
warn                      = CND.get_logger 'warn',      badge
help                      = CND.get_logger 'help',      badge
urge                      = CND.get_logger 'urge',      badge
echo                      = CND.echo.bind CND

#-----------------------------------------------------------------------------------------------------------
@_is_sublist_at = ( me, my_start, your_start, your_stop, equals ) ->
  ### Return whether the sublist of `me` that extends through `[ your_start ... your_stop ]` is fully
  contained within list `me`, starting at `me`'s index as given by `my_start`'. This will be trivially
  false if `your_start` or `your_stop` lie outside the legal indixes into `me`, or if the start lies on or
  to the right of the stop (zero-length sublists being treated as not contained in any list); it
  will be trivially true if none of the above exclusions are met with and `my_start` is on the same position
  as `your_start`.  ###
  return false if your_start < 0
  return false if your_start > ( my_stop = me.length )
  return false if your_start >= your_stop
  return false if your_stop  < 0
  return false if your_stop  > my_stop
  return false if me.length - my_start < ( your_length = your_stop - your_start )
  return true if my_start is your_start
  for idx in [ 0 ... your_length ] by +1
    # debug '©30775', me[ my_start + idx ], me[ your_start + idx ]
    return false unless equals me[ my_start + idx ], me[ your_start + idx ]
  return true

#-----------------------------------------------------------------------------------------------------------
@_find_longest_repeating_sublist = ( me, equals = null ) ->
  equals ?= ( a, b ) -> a is b
  max_length  = me.length // 2
  for your_length in [ max_length .. 1 ] by -1
    for my_start in [ 0 .. me.length - 2 * your_length ] by +1
      my_stop = my_start + your_length
      for your_start in [ my_start + your_length .. me.length - your_length ] by +1
        your_stop = your_start + your_length
        # whisper '©87447', ( rpr your_length ), [ my_start, my_stop, ], me[ my_start ... my_stop ], [ your_start, your_stop, ], me[ your_start ... your_stop ]
        if @_is_sublist_at me, my_start, your_start, your_stop, equals
          return [ your_start, your_stop, ]
  return null

#-----------------------------------------------------------------------------------------------------------
@find_longest_repeating_sublist = ( me, equals = null ) ->
  return R unless ( R = @._find_longest_repeating_sublist me, equals )?
  return me[ R[ 0 ] ... R[ 1 ] ]
























