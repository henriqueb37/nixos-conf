{
  config,
  ...
}: {
  xdg.configFile."zsh/zshrc.sh".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/zsh/.zshrc";
  xdg.configFile."zsh/zshenv.sh".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/zsh/.zshenv";
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    prezto = {
      enable = true;
      editor.keymap = "vi";
      pmodules = [
        "autosuggestions"
        "environment"
        "terminal"
        "editor"
        "history"
        "history-substring-search"
        "syntax-highlighting"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "prompt"
      ];
      prompt.theme = "powerlevel10k";
    };
    envExtra = ''
      source ${config.xdg.configHome}/zsh/zshrc.sh
    '';
  };
}
