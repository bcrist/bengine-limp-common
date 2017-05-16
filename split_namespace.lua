function split_namespace (identifier)
   local ns = {}
   return identifier:gsub('([%w_]*)::', function (s) if s then ns[#ns + 1] = s end return '' end), ns
end
