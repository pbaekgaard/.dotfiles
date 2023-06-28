let-env STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { || create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = ": "
let-env PROMPT_INDICATOR_VI_NORMAL = "〉"
let-env PROMPT_MULTILINE_INDICATOR = "::: "
let-env EDITOR = lvim

# SET LUNARVIM ALIAS
alias lvim = nvim -u C:\Users\Peter\AppData\Roaming\lunarvim\lvim\init.lua

# SET REPOS ALIAS
alias repos = cd ~/source/repos/

# SET SANDBOX ALIAS
alias sandbox = cd ~/source/sandbox/
