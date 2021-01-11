# tmux settings
{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    shortcut = "b";

    # Replaces ~/.tmux.conf
    extraConfig = ''
      ## 256 colors, please
      set -g default-terminal "screen-256color"

      ## Mouse scrolling
      set -g mode-mouse on
      # Make mouse useful in copy mode
      setw -g mode-mouse on

      # Allow mouse to select which pane to use
      set -g mouse-select-pane on

      # Allow xterm titles in terminal window, terminal scrolling with scrollbar, and setting overrides of C-Up, C-Down, C-Left, C-Right
      set -g terminal-overrides "xterm*:XT:smcup@:rmcup@:kUP5=\eOA:kDN5=\eOB:kLFT5=\eOD:kRIT5=\eOC"

      # Scroll History
      set -g history-limit 30000

      # Set ability to capture on start and restore on exit window data when running an application
      setw -g alternate-screen on

      # Lower escape timing from 500ms to 50ms for quicker response to scroll-buffer access.
      set -s escape-time 50

      ## Vim
      set-window-option -g mode-keys vi
      bind-key -t vi-copy 'v' begin-selection
      bind-key -t vi-copy 'y' copy-selection
      bind P paste-buffer

      #### COLOR (Solarized dark)

      # default statusbar colors
      set-option -g status-bg black #base02
      set-option -g status-fg yellow #yellow
      set-option -g status-attr default

      # default window title colors
      set-window-option -g window-status-fg brightblue #base0
      set-window-option -g window-status-bg default
      #set-window-option -g window-status-attr dim

      # active window title colors
      set-window-option -g window-status-current-fg brightred #orange
      set-window-option -g window-status-current-bg default
      #set-window-option -g window-status-current-attr bright

      # pane border
      set-option -g pane-border-fg black #base02
      set-option -g pane-active-border-fg brightgreen #base01

      # message text
      set-option -g message-bg black #base02
      set-option -g message-fg brightred #orange

      # pane number display
      set-option -g display-panes-active-colour blue #blue
      set-option -g display-panes-colour brightred #orange

      # clock
      set-window-option -g clock-mode-colour green #green

      # time to recognize esc
      set -sg escape-time 0
    '';
  };
}
