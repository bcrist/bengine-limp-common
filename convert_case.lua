function to_snake_case (identifier)
   local first = true
   local last_was_snake = false
   return string.gsub(tostring(identifier), '.', function (c)
      if c == ' ' then
         c = '_'
      else
         local lower = c:lower()
         if lower ~= c then
            if first or last_was_snake then
               c = lower
            else
               c = '_' .. lower
            end
         end
      end

      if last_was_snake then
         if c == '_' then
            c = ''
         else
            last_was_snake = false
         end
      else
         last_was_snake = c == '_'
      end
      
      first = false
      return c
   end)
end
