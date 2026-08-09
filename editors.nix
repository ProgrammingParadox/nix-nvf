{
  config,
  inputs,
  ...
}: let
  username = config.meta.username;
in {
  config.flake.modules.nixos.editors = {pkgs, ...}: {
    home-manager.users.${username} = {
      imports = [inputs.nvf.homeManagerModules.default];

      programs.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
        extraPackages = epkgs: [
          epkgs.treesit-grammars.with-all-grammars
          epkgs.vterm
        ];
      };

      services.emacs = {
        package = pkgs.emacs-pgtk;
        enable = true;
      };

      home.packages = [pkgs.neovide];

      xdg.configFile."neovide/config.toml".text = ''
        [font]
        normal = [{ family = "IosevkaTerm Nerd Font" }]
        size = 14.0
      '';

      programs.nvf = {
        enable = true;
        defaultEditor = true;

        settings.vim = {
          viAlias = true;
          vimAlias = true;

          lineNumberMode = "relNumber";

          debugMode = {
            enable = false;
            level = 16;
            logFile = "/tmp/nvim.log";
          };

          opts = {
            expandtab = true;
            tabstop = 2;
            shiftwidth = 2;

            clipboard = "unnamedplus";
          };

          spellcheck.enable = false;

          lsp = {
            enable = true;
            formatOnSave = true;
            lspkind.enable = false;
            lightbulb.enable = true;
            lspsaga.enable = false;
            trouble.enable = true;
            otter-nvim.enable = true;
            nvim-docs-view.enable = true;
          };

          debugger.nvim-dap.enable = false;

          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;

            nix.enable = true;
            markdown.enable = true;
            bash.enable = true;
            css.enable = true;
            html.enable = true;
            json.enable = true;
            typescript.enable = true;
            lua.enable = true;
            python.enable = true;
            rust.enable = true;
            toml.enable = true;
            env.enable = true;
            svelte.enable = true;
          };

          visuals = {
            nvim-scrollbar.enable = true;
            nvim-web-devicons.enable = true;
            nvim-cursorline.enable = true;
            cinnamon-nvim.enable = false;
            fidget-nvim.enable = true;
            highlight-undo.enable = true;
            indent-blankline.enable = true;
          };

          statusline.lualine = {
            enable = true;
          };

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
            transparent = false;
          };

          autopairs.nvim-autopairs.enable = true;

          autocomplete.blink-cmp.enable = true;

          snippets.luasnip.enable = false;

          filetree.neo-tree.enable = true;

          tabline.nvimBufferline.enable = true;
          # mini.tabline.enable = true;

          mini.surround.enable = true;
          mini.surround.setupOpts.mappings = {
            add = "<leader>sa";
            delete = "<leader>sd";
            highlight = "<leader>sh";
            replace = "<leader>sr";
            update_n_lines = "<leader>sn";
          };

          treesitter.context.enable = true;

          binds = {
            whichKey.enable = true;
            cheatsheet.enable = true;
          };

          telescope.enable = true;

          git = {
            enable = true;
            gitsigns.enable = true;
            gitsigns.codeActions.enable = false;
            neogit.enable = true;
          };

          dashboard = {
            dashboard-nvim.enable = false;
            alpha.enable = false;
          };

          notify.nvim-notify.enable = true;

          utility = {
            diffview-nvim.enable = true;
            surround.enable = true;
            undotree.enable = true;
            grug-far-nvim.enable = true;
            motion.flash-nvim.enable = true;
            motion.flash-nvim.mappings.toggle = "<leader>sf";
          };

          notes.todo-comments.enable = true;

          ui = {
            borders.enable = true;
            colorizer.enable = true;
            illuminate.enable = true;
            breadcrumbs = {
              enable = true;
              navbuddy.enable = true;
            };
            fastaction.enable = true;
          };

          comments.comment-nvim.enable = true;

          keymaps = [
            {
              key = "<leader>wh";
              action = "<C-w>h";
              mode = ["n"];
              desc = "Move to left window";
            }
            {
              key = "<leader>wj";
              action = "<C-w>j";
              mode = ["n"];
              desc = "Move to window below";
            }
            {
              key = "<leader>wk";
              action = "<C-w>k";
              mode = ["n"];
              desc = "Move to window above";
            }
            {
              key = "<leader>wl";
              action = "<C-w>l";
              mode = ["n"];
              desc = "Move to right window";
            }

            {
              key = "<leader>e";
              action = ":Neotree toggle<CR>";
              mode = ["n"];
              desc = "Toggle file tree";
            }

            {
              key = "<leader>ot";
              action = ":vsplit | term<CR>";
              mode = ["n"];
              desc = "Open a terminal";
            }

            {
              key = "<Esc>";
              action = "<C-\\><C-n>";
              mode = ["t"];
              desc = "Exit terminal mode";
            }

            {
              key = "<leader>bd";
              action = ":bp | bd #<CR>";
              mode = ["n"];
              desc = "Close buffer";
            }
          ];
        };
      };
    };
  };
}
