local enum, close_namespace = ...

if close_namespace or close_namespace == nil then
   if file_ext == '.hpp' then
      writeln()
   end
   write_template('common/templates/enum_namespace_close', enum)

   if file_ext == '.hpp' then
      write_template('common/templates/enum_traits_decl', enum)
   end
end
