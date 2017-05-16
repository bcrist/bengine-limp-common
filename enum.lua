include 'common/convert_case'
include 'common/split_namespace'

function make_enum (full_name, datatype, constants, class)
   local data = { }
   local map = { }
   local last_value
   local max_length = 0
   for i = 1, #constants do
      local constant = constants[i]
      if type(constant) ~= 'table' then
         constant = {
            name = constant
         }
      end

      if not constant.name then
         error('Invalid enum constant name: ' .. constant.name)
      end
      
      if map[constant.name] then
         error('Duplicate enum constant: ' .. constant.name)
      end

      max_length = math.max(max_length, #constant.name)

      if not constant.value then
         constant.value = (last_value or -1) + 1
         if last_value == nil or constant.value ~= (last_value + 1) then
            constant.assign_value = constant.value
         end
      else
         constant.assign_value = constant.value
      end

      if type(constant.value) == 'number' then
         last_value = constant.value
      else
         local other = map[constant.value]
         if not other then
            error('Enum constant ' .. constant.value .. ' not defined!')
         else
            last_value = other.value
         end
      end

      data[#data + 1] = constant
      map[constant.name] = constant
   end

   local name, ns = split_namespace(full_name)

   return {
      class = class,
      full_name = full_name,
      name = name,
      ns = ns,
      namespace = table.concat(ns, '::'),
      snake_case_name = to_snake_case(name),
      type = datatype,
      constants = data,
      constant_map = map,
      max_constant_name_length = max_length
   }
end

function make_enum_class (full_name, datatype, constants)
   return make_enum(full_name, datatype, constants, true)
end
