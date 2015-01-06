--- TOML snippets.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- copyright 2015
-- @license MIT (see LICENSE)
-- @module toml

return {
  -- random
  ["d"]     = "%1(year)-%2(month)-%3(day)T%4(time)",

  -- arrays and tables
  ["kt"]     = "%1(key) = [\n\t%0\n]",
  ["kv"]     = '\n%1(key) = "%2(value)"',
}

