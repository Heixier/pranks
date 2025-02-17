# Unmute and super max the volume
pactl set-sink-mute 0 0
pactl set-sink-volume 0 150%

set -o ignoreeof

NEWLINE=$'\n'

function command_not_found_handler() {
  printf "\aoi wat command liddat got meh try again la\n#\n"
  return 127
}

exec 2>/dev/null

export PS1="eh terminal open liao${NEWLINE}# "

alias cd='printf "where u wan go stay here la better\n#\n"'
alias pwd='printf "u where now dunno also i not ur gps\n#\n"'
alias ls='printf "see wat see nothing to see one la\n#\n"'
alias tree='printf "walao u think here botanic garden isit\n#\n"'
alias cat='printf "meow meow u pet cat i pet u la\n#\n"'
alias clear='printf "clear wat everything also cannot see liddat\n#\n"'
alias type='printf "type so much for wat get work done can\n#\n"'

alias chmod='printf "eh dun play play with permission hor later kena sgsecure\n#\n"'
alias chown='printf "dis one not ur ting la dun anyhow own\n#\n"'
alias unzip='printf "zip wat zip u tink dis 7-11 isit\n#\n"'
alias tar='printf "tar road ah u tink u LTA meh\n#\n"'

alias env='printf "env wat env outside got haze dun go la\n#\n"'

alias mkdir='printf "make wat dir u tink hdb so easy get meh\n#\n"'
alias touch='printf "touch wat touch i call police u know\n#\n"'

alias git='printf "git wat git just pm me on tele can liao\n#\n"'
alias man='printf "man ah u google urself la so lazy for wat\n#\n"'
alias make='printf "make urself la i where got time sia\n#\n"'

alias whoami='printf "u dunno who u meh got problem ah\n#\n"'
alias uname='printf "unicorn os 4.2.0 sg ver confirm plus chop\n#\n"'

alias lsof='printf "everyting closed liao la very secure one\n#\n"'

alias history='printf "last time british japan merger den independent can liao\n#\n"'

alias cp='printf "copy wat copy later kena copyright how\n#\n"'
alias mv='printf "move where sit down dun walk here n there\n#\n"'

alias groups='printf "we all sg wat one ppl one nation one sg\n#\n"'

alias sudo='printf "u tink u big shot isit where got sudo one\n#\n"'

alias cc='printf "u tink can compile meh where got compiler one\n#\n"'
alias gcc='printf "gcc for wat u where got code can run one\n#\n"'
alias clang='printf "clang ur head la even apple also cannot help u\n#\n"'
alias python='printf "python where got sia here got snake meh siao\n#\n"'
alias python3='printf "python3 also same la version 3 also cannot run\n#\n"'
alias java='printf "java for wat u tink dis starbucks isit\n#\n"'
alias javac='printf "compile java also cannot la no rooftop solar panel\n#\n"'
alias node='printf "node.js also useless one la cannot node anything\n#\n"'
alias npm='printf "npm install ur face la where got internet to download\n#\n"'
alias go='printf "go where go u cannot go anywhere la stay here\n#\n"'
alias rust='printf "rust wat rust u want tetanus shot isit\n#\n"'
alias perl='printf "perl for wat u want jewelry ah go pawn shop la\n#\n"'
alias ruby='printf "ruby so ex now u think can find here meh\n#\n"'

alias code="emacs -nw"
alias vim="nano"
alias vi="nano"
alias nano="emacs -nw"
alias emacs='printf "eh dun try open more editors la no use one\n#\n"'
alias less='printf "less wat less u already got nothing\n#\n"'
alias more='printf "more also no more la everything gone liao\n#\n"'
alias head='printf "head for wat think so clever isit\n#\n"'
alias tail='printf "tail wat tail u think here got cat ah\n#\n"'

alias ping='printf "ping wat ping u think dis msn messenger ah\n#\n"'
alias curl='printf "curl for wat u want perm also no use one\n#\n"'
alias wget='printf "wget also cannot la no internet here sial\n#\n"'
alias ssh='printf "ssh to where u think can escape me meh\n#\n"'
alias telnet='printf "telnet so old school for wat u dinosaur isit\n#\n"'
alias nc='printf "netcat cannot help u la no network here\n#\n"'
alias nmap='printf "scan wat scan u think dis polyclinic isit\n#\n"'
alias ifconfig='printf "check wat ip la all localhost one\n#\n"'
alias ip='printf "ip for wat u think can escape meh\n#\n"'

alias ps='printf "check wat process la everything i control one\n#\n"'
alias top='printf "top of wat la u think dis mountain isit\n#\n"'
alias kill='printf "kill wat kill u think dis pubg ah\n#\n"'
alias pkill='printf "pkill who u think so powerful meh\n#\n"'
alias systemctl='printf "control wat system u think u admin isit\n#\n"'
alias service='printf "service for wat u think dis kopitiam meh\n#\n"'
alias reboot='printf "reboot wat reboot u think can restart meh dream on\n#\n"'
alias shutdown='printf "shutdown u wish la, cannot even if pray\n#\n"'
alias crontab='printf "crontab for wat u think can schedule escape ah\n#\n"'

alias source='printf "source wat source u think dis mineral water ah\n#\n"'
alias exec='printf "exec so powerful meh u wish la\n#\n"'
alias export='printf "export to where sia u think this trade agency ah\n#\n"'
alias eval='printf "eval wat eval u think here school exam isit\n#\n"'
alias set='printf "set wat set everything already fixed one\n#\n"'
alias unset='printf "unset also cannot la nothing to unset\n#\n"'

alias find='printf "find wat find u think dis lost and found ah\n#\n"'
alias locate='printf "locate for wat everything also lost liao\n#\n"'
alias dirname='printf "dir got wat name la all same one\n#\n"'
alias basename='printf "base got wat name u think dis army camp ah\n#\n"'
alias grep='printf "grep wat grep u think can find anything meh\n#\n"'
alias awk='printf "awk for wat this not bird sound\n#\n"'
alias sed='printf "sed wat sed u think dis coffeeshop aunty ah\n#\n"'
alias xargs='printf "xargs wat xargs u think can chain command meh dream on\n#\n"'

# Final escape attempts
alias exit='printf "exit for wat u got passport meh stay here la\n#\n"'
alias logout='printf "logout how to logout u stuck here forever\n#\n"'
alias bash='printf "bash wat bash u think can open new shell isit\n#\n"'
alias sh='printf "sh also cannot la no more shell for u\n#\n"'
alias zsh='printf "zsh fish csh all also same la cannot run one\n#\n"'
alias fsh='printf "sorry got no fish tank for u\n#\n"'
alias screen='printf "screen for wat u think this cinema ah\n#\n"'
alias tmux='printf "tmux also useless one split screen also cannot\n#\n"'


alias echo='printf "echo ur head la u in cave isit\n#\n"'
alias unalias='printf "walao eh trying to unalias for wat so smart for wat\n#\n"'
alias alias='printf "alias ur head la change name still owe $ one\n#\n"'

clear