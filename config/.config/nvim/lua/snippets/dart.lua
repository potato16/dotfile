local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

local function current_filename()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file_name = vim.api.nvim_buf_get_name(current_buffer)
  local file_name = string.match(current_file_name, "([^/]+)%.%w+$")
  return file_name
end

return {
  s('freezed',fmt([[
    {import}
    @freezed
    class {classname} with _${classname} {{
      const factory {classname}({{
      }}) = _{classname};

      factory {classname}.fromJson(Map<String, Object?> json) => _${classname}FromJson(json);
    }}
  ]],{
    import = c(1,{
      t(""),
      sn(nil,
      fmt([[
        import 'package:flutter/foundation.dart';
        import 'package:freezed_annotation/freezed_annotation.dart';

        part '{filename}.freezed.dart';
        part '{filename}.g.dart';

      ]],{filename=f(current_filename)})
      )
    }),
    classname = i(2,"MyClass")
  },{
    repeat_duplicates = true
  })),
  s({trig='stl',dscr="Flutter Stateless Widget"},fmt([[
class {name} extends StatelessWidget {{
  const {name}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    // TODO: implement build
    throw UnimplementedError();
  }}
}}
  ]],{name=i(1,"MyWidget")},{repeat_duplicates=true})),
}
