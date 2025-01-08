# Step 1: Create a function to track key sequence
space_pressed=false

# Define the widget for Ctrl+Space (to set the flag and wait for Ctrl+F)
ctrl_space_action() {
  space_pressed=true

  # Function to handle Ctrl+F press after Ctrl+Space
  wait_for_ctrl_f() {
    while :; do
      read -s -k 1 key  # Read a single key press
      if [[ "$key" == $'\x06' ]]; then  # Ctrl+F is pressed (ASCII 6)
        if $space_pressed; then
          # Make sure tmux-sessionizer is called in the foreground
          exec </dev/tty
          exec <&1
          tmux-sessionizer; zle redisplay;
          space_pressed=false
          break
        fi
      else
        # If any other key is pressed, reset the sequence
        space_pressed=false
        break
      fi
    done
  }

  # Call wait_for_ctrl_f synchronously (in the same terminal session)
  wait_for_ctrl_f
}

# Step 2: Register the function as a widget
zle -N ctrl_space_action

# Step 3: Bind the key sequence Ctrl+Space to the widget
bindkey '^ ' ctrl_space_action  # Ctrl+Space
