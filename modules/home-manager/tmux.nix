{ pkgs, config, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.better-mouse-mode
    ];

    extraConfig = ''
      # Easy config reload
      bind-key R source-file ~/.tmux.conf \; display-message "tmux.conf reloaded."

      # vi is good
      setw -g mode-keys vi

      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set-option -g default-terminal screen-256color

      bind-key : command-prompt
      bind-key r refresh-client
      bind-key L clear-history

      bind-key space next-window
      bind-key bspace previous-window
      bind-key enter next-layout

      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on

      # Window monvement & spliting
      bind-key v split-window -h -c "#{pane_current_path}"
      bind-key s split-window -v -c "#{pane_current_path}"
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key [ copy-mode
      bind-key ] paste-buffer

      # Setup 'v' to begin selection as in Vim
      bind-key -T edit-mode-vi Up send-keys -X history-up
      bind-key -T edit-mode-vi Down send-keys -X history-down
      unbind-key -T copy-mode-vi Space     ;   bind-key -T copy-mode-vi v send-keys -X begin-selection
      unbind-key -T copy-mode-vi Enter     ;   bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
      unbind-key -T copy-mode-vi C-v       ;   bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      unbind-key -T copy-mode-vi [         ;   bind-key -T copy-mode-vi [ send-keys -X begin-selection
      unbind-key -T copy-mode-vi ]         ;   bind-key -T copy-mode-vi ] send-keys -X copy-selection

      set-window-option -g display-panes-time 2000

      # Pane resizing
      bind -n M-h resize-pane -L 1
      bind -n M-j resize-pane -D 1
      bind -n M-k resize-pane -U 1
      bind -n M-l resize-pane -R 1
      unbind-key M-Up
      unbind-key M-Down
      unbind-key M-Left
      unbind-key M-Right
      unbind-key C-Up
      unbind-key C-Down
      unbind-key C-Left
      unbind-key C-Right

      bind c new-window -c
    '';
  };
}