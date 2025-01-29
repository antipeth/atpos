{
  programs.joplin-desktop = {
    enable = true;
    sync.target = "s3";
    general.editor = "nvim";
  };
}
