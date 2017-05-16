local enum, open_namespace = ...

if open_namespace or open_namespace == nil then
   writeln()
   write_template('common/templates/enum_namespace_open', enum)
end

if file_ext == '.hpp' then
   write_template('common/templates/enum_decl', enum)
   write_template('common/templates/enum_is_valid_decl', enum)
   write_template('common/templates/enum_name_decl', enum)
   write_template('common/templates/enum_values_decl', enum)
   write_template('common/templates/enum_stream_insertion_decl', enum)
else
   write_template('common/templates/enum_is_valid', enum)
   write_template('common/templates/enum_name', enum)
   write_template('common/templates/enum_values', enum)
   write_template('common/templates/enum_stream_insertion', enum)
end
