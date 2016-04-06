--- TOML LPeg lexer.
-- Used yaml.lua and lua.lua for reference.
-- @author [Alejandro Baez](https://keybase.io/baez)
-- copyright 2016
-- @license MIT (see LICENSE)
-- @module toml

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
local dq_str = P('U')^-1 * l.delimited_range('"', true)
local raw_sq_str = P('u')^-1 * l.delimited_range("'", false, false)
local multi_dq_str = '"""' * (l.any - '"""')^0 * P('"""')^-1
local multi_raw_sq_str = "'''" * (l.any - "'''")^0 * P("'''")^-1
local string = token(l.STRING, multi_raw_sq_str + multi_dq_str +
                               raw_sq_str + dq_str)

-- Numbers.
local number = token(l.NUMBER, l.float + l.integer)

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

-- kewwords.
local keyword = token(l.KEYWORD, word_match{
  'true', 'false'
})


-- Identifiers.
local identifier = token(l.IDENTIFIER, l.word)

-- Operators.
local operator = token(l.OPERATOR, S('#=+-,.{}[]()'))

M._rules = {
  {'indent', indent},
  {'whitespace', ws},
  {'comment', comment},
  {'timestamp', ts},
  {'keyword', keyword},
  {'operator', operator},
  {'string', string},
  {'number', number},
  {'identifier', identifier},
}

M._tokenstyles = {
  indent_error = 'back:%(color.red)',
  timestamp = l.STYLE_NUMBER,
}

M._FOLDBYINDENTATION = true

return M
