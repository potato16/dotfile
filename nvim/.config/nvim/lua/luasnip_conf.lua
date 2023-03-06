local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
})
-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({"i", "s"}, "<c-k>", function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end,{silent = true})

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({"i", "s"}, "<c-j>", function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end,{silent = true})

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes
vim.keymap.set({"i", "s"} , "<c-l>", function ()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end,{silent = true})

require("luasnip.loaders.from_lua").load({paths =vim.fn.stdpath('config') .. '/lua/snippets',})
