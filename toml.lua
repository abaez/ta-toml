--- TOML LPeg lexer.
-- Used yaml.lua for reference.
-- @module toml
-- @author Alejandro Baez
-- @license MIT

local l = require("lexer")
local token, word_match = l.token, l.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'toml'}

-- Whitespace
local indent = #l.starts_line(S(' \t')) *
               (token(l.WHITESPACE, ' ') + token('indent_error', '\t'))^1
local ws = token(l.WHITESPACE, S(' \t')^1 + l.newline^1)

-- Comments.
local comment = token(l.COMMENT, '#' * l.nonnewline^0)

-- Strings.
local string = token(l.STRING, l.delimited_range("'") + l.delimited_range('"'))

-- Numbers.
local integer = l.dec_num + l.hex_num + '0' * S('oO') * R('07')^1
local special_num = '.' * word_match({'inf', 'nan'}, nil, true)
local number = token(l.NUMBER, special_num + l.float + integer)

-- Datetime.
local ts = token('timestamp', l.digit * l.digit * l.digit * l.digit * -- year
                              '-' * l.digit * l.digit^-1 * -- month
                              '-' * l.digit * l.digit^-1 * -- day
                              ((S(' \t')^1 + S('tT'))^-1 * -- separator
                               l.digit * l.digit^-1 * -- hour
                               ':' * l.digit * l.digit * -- minute
                               ':' * l.digit * l.digit * -- second
                               ('.' * l.digit^0)^-1 * -- fraction
                               ('Z' + -- timezone
                                S(' \t')^0 * S('-+') * l.digit * l.digit^-1 *
                                (':' * l.digit * l.digit)^-1)^-1)^-1)

-- Constants.
local constant = token(l.CONSTANT,
                       word_match({'true', 'false'}, nil, true))
