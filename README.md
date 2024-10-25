# 🎉 vio.nvim

vio.nvim is a Neovim plugin that provides helper functions to enhance your development experience within Neovim in vio. Currently, it integrates with your git workflow to extract and display story descriptions based on your current git branch name, making it easier to stay on top of your tasks without switching contexts. 🚀

---

## ✨ Features

- **🔍 Get Story Description from Git Branch**: Automatically fetch the story description tied to your current branch with a single command.

The main function provided by this plugin is:

### `display_story()`

This function fetches and displays the story description based on the current git branch. 

#### 💻 Usage

```lua
require"vio-nvim".display_story()
```

---

## 📦 Installation

### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)

To install vio.nvim using Lazy.nvim, add the following to your plugin configuration:

```lua
{
  "vicentedpsantos/vio-nvim",
  config = function()
    -- Optional: Setup keybinding (explained below) 🎯
    vim.keymap.set("n", "<leader>bs", function() require"vio-nvim".display_story() end, { desc = "📖 Display Story" })
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
    vim.api.nvim_set_keymap('n', '<leader>bs', ':lua require"vio-nvim".display_story()<CR>', { noremap = true, silent = true })
  end
}
```

---

## ⌨️ Keybindings

To create a convenient shortcut for fetching the story description, you can add the following key mapping to your Neovim configuration:

```lua
vim.keymap.set("n", "<leader>bs", function() require"vio-nvim".display_story() end, { desc = "📖 Display Story" })
```

Now, pressing `<leader>bs` in normal mode will call the `display_story()` function, displaying the story description associated with your current git branch. 📝

---

## 📜 License

This plugin is released under the MIT License. See [LICENSE](./LICENSE) for more details.

---

Happy coding with vio.nvim! 🚀✨
