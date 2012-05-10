autoload -U colors && colors

PS1='\
%{$fg[red]%}➜ \
%{$FX[no-bold]%}%{$FG[250]%}%3c\
%{$FG[247]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FX[italic]%}%{$FG[237]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[088]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[106]%}✓%{$reset_color%}"
