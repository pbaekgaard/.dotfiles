# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/school/p7"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "p7"; then

  # Create a new window inline within session layout definition.
  new_window "nvim"
  new_window "servers"
  split_h 50
  run_cmd "cd client; clear;"
  select_pane 1
  run_cmd "cd backend; clear;"
  # Load a defined window layout.
  #load_window "example"
  new_window "term"

  # Select the default active window on session creation.
  select_window 1
  run_cmd "nvim ."

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
