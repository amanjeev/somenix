{ pkgs }:
''
set fish_function_path ${pkgs.fishPlugins.foreign-env}/share/fish-foreign-env/functions $fish_function_path

${builtins.readFile ./functions/__fancy_history.fish }
${builtins.readFile ./config.fish }
${builtins.readFile ./alias.fish }
${builtins.readFile ./functions/fish_user_key_bindings.fish }
${builtins.readFile ./functions/gen-shell.fish }
${builtins.readFile ./functions/__history_previous_command_arguments.fish }
${builtins.readFile ./functions/__history_previous_command.fish }
${builtins.readFile ./functions/e.fish }
${builtins.readFile ./functions/nrepl.fish }
${builtins.readFile ./functions/nxs.fish }
${builtins.readFile ./functions/restart.fish }
${builtins.readFile ./functions/search.fish }
${builtins.readFile ./functions/__skim_cd.fish }
''
