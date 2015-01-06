--- the Textadept initializer for the Toml module.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module init

textadept.file_types.extensions.toml = 'toml'
textadept.editing.comment_string.toml = '#'

if type(snippets) == 'table' then
  snippets.toml = require("modules.toml.snippets")
end

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'toml' then return end

  buffer.tab_width = 2
  buffer.use_tabs = false
end)

return {
  toml = 'toml'
}
