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


def-env repos [] {
  if $env.COMPUTERNAME == "DESKTOPPC" {
    cd Z:\source\repos 
  } else {
    cd ~/source/repos
  }
}

# SET SANDBOX ALIAS
alias sandbox = cd ~/source/sandbox/



# LUNARVIM ENV's
$env.XDG_DATA_HOME = $env.APPDATA
$env.XDG_CONFIG_HOME = $env.LOCALAPPDATA
$env.XDG_CACHE_HOME = $env.TEMP

$env.LUNARVIM_RUNTIME_DIR = ($env.XDG_DATA_HOME + \lunarvim)
$env.LUNARVIM_CONFIG_DIR = ($env.XDG_CONFIG_HOME + \lvim)
$env.LUNARVIM_CACHE_DIR = ($env.XDG_CACHE_HOME + \lvim)
$env.LUNARVIM_BASE_DIR = ($env.LUNARVIM_RUNTIME_DIR + \lvim)

# SET LUNARVIM ALIAS
alias lvim = nu ~/.config/nushell/lvim.nu

# SET LUNARVIM AS DEFAULT EDITOR
$env.EDITOR = "nvim -u " + ($env.LUNARVIM_BASE_DIR + \init.lua)
