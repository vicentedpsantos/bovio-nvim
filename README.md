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
    -- Optional: Setup keybinding (explained below) 🎯

    vim.keymap.set("n", "<leader>ss", "<cmd>VioDisplayStory<cr>", { desc = "📖 Display Story" })
    vim.keymap.set("n", "<leader>rt", "<cmd>RunFileTest<cr>", { desc = "🧪 Run all tests in the current file" })
    vim.keymap.set("n", "<leader>rc", "<cmd>RunClosestTest<cr>", { desc = "🧪 Run the closest test" })
  end
}
```

### Using [Packer.nvim](https://github.com/wbthomason/packer.nvim)

If you're using Packer, here's the configuration:

```lua
use {
  "vicentedpsantos/vio-nvim",
  config = function()
    -- Optional: Setup keybinding (explained below) 🎯

    vim.keymap.set("n", "<leader>ss", "<cmd>VioDisplayStory<cr>", { desc = "📖 Display Story" })
    vim.keymap.set("n", "<leader>rt", "<cmd>RunFileTest<cr>", { desc = "🧪 Run all tests in the current file" })
    vim.keymap.set("n", "<leader>rc", "<cmd>RunClosestTest<cr>", { desc = "🧪 Run the closest test" })
  end
}
```

---

🌱 Environment Variables
To successfully fetch story information, you need to set the following environment variable:

`SHORTCUT_SERVICE_API_KEY`: This key is required for authenticating requests to the shortcut service. Make sure to add it to your environment before running the plugin.

---

## 📜 License

This plugin is released under the MIT License. See [LICENSE](./LICENSE) for more details.

---

Happy coding with vio.nvim! 🚀✨
