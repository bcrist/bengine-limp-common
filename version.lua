-- Writes preprocessor directives to define BE_*_VERSION and BE_*_VERSION_STRING

local ns, name = ...

write_template('common/templates/version', {
   name = name or ns,
   ns_shouting = string.upper(ns:gsub('::', '_'))
})
