--- the Textadept initializer for the Toml module
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)

textadept.file_types.extensions.toml = 'toml'
textadept.editing.comment_string.toml = '#'

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'toml' then return end

  buffer.tab_width = 2
  buffer.use_tabs = false
end)

return {
  rs = 'rust'
}
