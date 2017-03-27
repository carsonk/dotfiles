#!/bin/zsh
SESSION=thesis

_tmux_send_keys_all_panes_ () {
    for _pane in $(tmux list-panes -F '#P'); do
        tmux send-keys -t ${_pane} "$@"
    done
}

tmux -2 new-session -d -s $SESSION

tmux split-window -h
tmux select-pane -t 1
tmux split-window -v
_tmux_send_keys_all_panes_ "cd ~/Projects/tablefetchserver" C-m
tmux select-pane -t 0
tmux send-keys "vim ." C-m

tmux new-window -t $SESSION:1 -n 'Server Log'
tmux split-window -h
tmux select-pane -t 1
tmux send-keys "cd ~/Projects/tablefetchserver && python3 manage.py runserver" C-m

tmux select-window -t $SESSION:0

tmux -2 attach-session -t $SESSION

