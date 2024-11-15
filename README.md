# 🎉 vio.nvim

vio.nvim is a Neovim plugin that provides helper functions to enhance your development experience within Neovim in Vio. 🚀

---

## ✨ Features

- **🔍 Get Story Description from Git Branch**: Automatically fetch the story description tied to your current branch with a single command.
- **🧪 Run BoVio API Tests from Neovim**: Execute tests directly from your Neovim environment, with the output displayed in a separate buffer.

---

## 📦 Installation

### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)

To install vio.nvim using Lazy.nvim, add the following to your plugin configuration:

```lua
{
  "vicentedpsantos/vio-nvim",
  config = function()
    local shortcut_api_key = os.getenv("SHORTCUT_SERVICE_API_KEY")

    require("vio-nvim").setup({ shortcut_api_key = shortcut_api_key })

    local wk = require("which-key")

    wk.add({
      {"<leader>ss", "<cmd>VioDisplayStory<cr>", desc = "Display Shortcut Story" },
      {"<leader>rt",  "<cmd>BoVioAPIRunFileTest<cr>", desc = "Run test file." },
      {"<leader>rc", "<cmd>BoVioAPIRunClosestTest<cr>", desc = "Run test file." },
    }, {
        mode = "n",
        silent = true,
    })
  end,
}
```
---

## 🌱 Environment Variables

To successfully fetch story information, you need to set the following environment variable:

`SHORTCUT_SERVICE_API_KEY`: This key is required for authenticating requests to the shortcut service. Make sure to add it to your environment before running the plugin.

---

## Running tests

The BoVio plugin allows you to run Elixir tests with the output displayed in either a buffer (default) or a floating terminal (floaterm). Here’s a quick guide on using the new floaterm mode.

### Prerequisites to run in a Floaterm

Make sure you have the vim-floaterm plugin installed, for example:

```vim
Plug 'voldikss/vim-floaterm'
```

### Switching to Buffer Output
To revert to buffer output mode:

```lua
require('vio-nvim').setup({
  output = "buffer" -- Default behavior
})
```

In buffer mode, results are shown in a split. Press <CR> (Enter) to close the split.

---

## 📜 License

This plugin is released under the MIT License. See [LICENSE](./LICENSE) for more details.

---

Happy coding with vio.nvim! 🚀✨
