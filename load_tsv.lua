function load_tsv (tsv_path, value_parser_func, header_parser_func, key_parser_func)
   if be.fs.exists(tsv_path) then
      dependency(be.fs.ancestor_relative(be.fs.canonical(tsv_path), root_dir))
      local contents = be.fs.get_file_contents(tsv_path)
      local header = true
      local keys = { }
      local rows = { }

      for line, nl in string.gmatch(contents, '([^\n\r]*)(\r?\n?)') do
         if #line == 0 and #nl == 0 then
            break
         end
         if header then
            local i = 1
            local k = 0
            for token, tab in string.gmatch(line, '([^\t]*)(\t?)') do
               if #token == 0 and #tab == 0 then
                  break
               end
               if #token > 0 then
                  if header_parser_func then
                     token = header_parser_func(token, i)
                  end
                  keys[i] = token
               elseif i ~= 1 then
                  if header_parser_func then
                     k = header_parser_func(nil, i, k)
                  else
                     k = k + 1
                  end
                  keys[i] = k
               end
               i = i + 1
            end
            header = false
         else
            local row = { }
            local i = 1
            local row_key
            for token, tab in string.gmatch(line, '([^\t]*)(\t?)') do
               if #token == 0 and #tab == 0 then
                  break
               end
               local key = keys[i]
               if i == 1 and key == nil then
                  if #token > 0 then
                     if key_parser_func then
                        token = key_parser_func(token)
                     end
                     row_key = token
                     rows[row_key] = row
                  end
               else
                  if i == 1 then
                     row_key = #rows + 1
                     rows[row_key] = row
                  end
                  if key ~= nil then
                     if value_parser_func then
                        token = value_parser_func(token, key, row_key)
                     elseif #token == 0 then
                        token = nil
                     end
                     row[key] = token
                  end
               end
               i = i + 1
            end
         end
      end
      return rows
   end
end
