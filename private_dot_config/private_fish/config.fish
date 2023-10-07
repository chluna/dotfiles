#
# ~/.config/fish/config.fish by chluna
#

# environment variables
set -gx PATH $PATH $HOME/.local/bin $HOME/.cargo/bin
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR helix
set -gx VISUAL $EDITOR
set -gx SXHKD_SHELL /bin/sh
set -gx NNN_BMS "d:~/data;e:/run/media/spike/ssd;f:~/data/finance/ledger;h:~/"
set -gx NNN_COLORS 3421
set -gx NNN_FIFO /tmp/nnn.fifo
set -gx NNN_OPTS deEHioU
set -gx NNN_PLUG p:preview-tui
set -gx NNN_TRASH 2
set -gx DIFFPROG "delta --color-only"

if status is-interactive

    # set tty theme to dracula
    if test $TERM = linux
        printf %b '\e[40m' '\e[8]' # set default background to color 0 'dracula-bg'
        printf %b '\e[37m' '\e[8]' # set default foreground to color 7 'dracula-fg'
        printf %b '\e]P0282a36'    # redefine 'black'          as 'dracula-bg'
        printf %b '\e]P86272a4'    # redefine 'bright-black'   as 'dracula-comment'
        printf %b '\e]P1ff5555'    # redefine 'red'            as 'dracula-red'
        printf %b '\e]P9ff7777'    # redefine 'bright-red'     as '#ff7777'
        printf %b '\e]P250fa7b'    # redefine 'green'          as 'dracula-green'
        printf %b '\e]PA70fa9b'    # redefine 'bright-green'   as '#70fa9b'
        printf %b '\e]P3f1fa8c'    # redefine 'brown'          as 'dracula-yellow'
        printf %b '\e]PBffb86c'    # redefine 'bright-brown'   as 'dracula-orange'
        printf %b '\e]P4bd93f9'    # redefine 'blue'           as 'dracula-purple'
        printf %b '\e]PCcfa9ff'    # redefine 'bright-blue'    as '#cfa9ff'
        printf %b '\e]P5ff79c6'    # redefine 'magenta'        as 'dracula-pink'
        printf %b '\e]PDff88e8'    # redefine 'bright-magenta' as '#ff88e8'
        printf %b '\e]P68be9fd'    # redefine 'cyan'           as 'dracula-cyan'
        printf %b '\e]PE97e2ff'    # redefine 'bright-cyan'    as '#97e2ff'
        printf %b '\e]P7f8f8f2'    # redefine 'white'          as 'dracula-fg'
        printf %b '\e]PFffffff'    # redefine 'bright-white'   as '#ffffff'
    end

    # kitty completions
    type -q kitty; and kitty + complete setup fish | source

    # skim (fzf) key bindings
    if command -q sk
        skim_key_bindings
    end

    # aliases
    if not fish_is_root_user
        alias se "sudoedit"
        alias sudo "sudo "
    end

    alias free "free -m"                # show sizes in MB
    alias cp "cp -i --reflink=always"   # confirm before overwriting something
    alias df "df -h"                    # human-readable sizes
    alias cl "clear"
    alias jc "journalctl -rb"
    command -q nnn; and alias fm nnn
    command -q kitty; and alias kt "kitty +kitten themes"
    command -q fastfetch; and alias ff fastfetch
    command -q btop; and alias t btop
    command -q nvtop; and alias gt nvtop
    command -q powertop; and alias pt "sudo powertop"
    command -q codium; and alias c codium
    command -q helix; and alias e helix
    command -q fd; and alias find fd
    command -q hledger; and alias run "hledger -f $HOME/data/health/running/running.journal"
    if command -q nvim
        alias e nvim
        alias vi nvim
        alias vim nvim
        alias vimdiff "nvim -d"
        alias xxd "nvim -b"
    end
    if command -q lsd
        alias ls "lsd -AF --group-dirs first"
        alias ll "lsd -alF --group-dirs first"
    end
    if command -q rg
        alias grep rg
        alias egrep rg
        alias fgrep rg
    else
        alias grep "grep --color=auto"
        alias egrep "egrep --color=auto"
        alias fgrep "fgrep --color=auto"
    end
    if command -q chezmoi
        alias cz chezmoi
        alias dot "chezmoi cd"
    end

    # functions
    function pm -d "wrapper for paru/pacman"
        argparse -i "i/install" "r/remove" "q/query" "p/purge" "m/mirror" \
            "e/export" "c/clean" "d/diff" "u/update" "U/upgrade" -- $argv
        or return
        if command -q paru
            set -f pkg paru
            set -f supkg paru
        else
            set -f pkg pacman
            set -f supkg "sudo pacman"
        end
        if set -q _flag_i
            $pkg -Slq | sk --multi --preview "$pkg -Si {}" | xargs -ro $supkg -S
        else if set -q _flag_r
            $pkg -Qq | sk --multi --preview "$pkg -Qi {}" | xargs -ro $supkg -Rsn
        else if set -q _flag_q
            $pkg -Slq | sk --preview "$pkg -Si {}"
        else if set -q _flag_p
            set -f orphans ($pkg -Qtdq)
            and echo $orphans | $supkg -Rsn -
        else if set -q _flag_m
            sudo systemctl start reflector
        else if set -q _flag_e
            set -f exp (cz source-path)/pacman
            if not test -d $exp
                mkdir -p $exp
            end
            $pkg -Qqen > $exp/arch_packages.txt
            $pkg -Qqem > $exp/aur_packages.txt
        else if set -q _flag_c
            $supkg -Sc
        else if set -q _flag_d
            DIFFPROG=delta sudo -E pacdiff
        else if set -q _flag_u
            checkupdates
        else if set -q _flag_U
            set -f log (mktemp)
            script -q $log -c "$supkg -Syu"
            grep -q '.+\.pac(new|orig|save)' $log
            if test $status -eq 0
                pm --diff
            end
            rm $log
            pm --purge
            xfce4-panel --plugin-event=genmon-7:refresh:bool:true
        else
            echo "Usage: pm <operation>"
            echo "Operation: -i, --install    install packages using skim"
            echo "           -r, --remove     remove packages using skim"
            echo "           -q, --query      query local package using skim"
            echo "           -p, --purge      remove orphaned packages"
            echo "           -m, --mirror     update mirrorlist"
            echo "           -e, --export     export local and AUR package lists"
            echo "           -c, --clean      clean paru cache"
            echo "           -d, --diff       find and act on pac[diff|new|save] files"
            echo "           -u, --update     check for package updates"
            echo "           -U, --upgrade    update and upgrade packages"
        end
    end
    
    function f --d "edit config.fish"
        argparse "e/edit" "r/reload" -- $argv
        or return
        if set -q _flag_e
            set -f conf $XDG_CONFIG_HOME/fish/config.fish
            set -f csum (mktemp)
            sha1sum $conf > $csum
            e $conf
            sha1sum -c $csum --status
            if test $status -ne 0
                read -f -n 1 -P "Reload changes? [y/n]: " choice
                if test (string lower $choice) = "y"
                    exec fish
                end
            end
            rm $csum
            cl
        else if set -q _flag_r
            exec fish
        end
    end
    
    function fin --d "finance wrapper for hledger"
        argparse -i "j/journal=" "p/price=" "m/main" "g/gui" -- $argv
        or return
        if set -q _flag_j
            e $HOME/data/finance/ledger/$_flag_j.journal
        else if set -q _flag_p
            e $HOME/data/finance/ledger/$_flag_p.prices
        else if set -q _flag_m
            e $HOME/data/finance/ledger/main.journal
        else if set -q _flag_g
            hledger-ui -f $HOME/data/finance/ledger/main.journal
        else
            hledger -f $HOME/data/finance/ledger/main.journal $argv
        end
    end
    
    function sc --d "simple systemctl wrapper"
        argparse -i "u/user" "s/status=" "r/restart=" "j/journal=" "e/edit=" -- $argv
        or return
        if set -q _flag_j
            if set -q _flag_u
                journalctl -f --user-unit $_flag_j
            else
                journalctl -f $_flag_j
            end
        else if set -q _flag_s
            if set -q _flag_u
                systemctl --user status $_flag_s
            else
                systemctl status $_flag_s
            end
        else if set -q _flag_r
            if set -q _flag_u
                systemctl --user restart $_flag_r
            else
                systemctl restart $_flag_r
            end
        else if set -q _flag_e
            sudo -E systemctl edit $_flag_e
        else
            if set -q _flag_u
                systemctl --user $argv
            else
                systemctl $argv
            end
        end
    end
    
    function btr --d "btrfs and btrbk wrapper"
        argparse "u/usage" "b/balance" "s/scrub" "t/target=" "du=" "mu=" \
            "n/dryrun" "l/list" "p/snapshot" "r/run" -- $argv
        or return
        set -f conf "/etc/btrbk/btrbk-backup.conf"
        if test "$_flag_t" = "loc"
            set -f tgt "/"
        else if test "$_flag_t" = "ext"
            set -f tgt "/run/media/spike/ssd"
        else
            set -f tgt $_flag_t
        end
        # btrfs-progs
        if set -q _flag_u; and set -q _flag_t
            sudo btrfs filesystem usage $tgt
        else if set -q _flag_b; and set -q _flag_t \
            ;and set -q _flag_du; and set -q _flag_mu
            sudo btrfs balance start -v -dusage=$_flag_du -musage=$_flag_mu $tgt
        else if set -q _flag_s; and set -q _flag_t
            sudo btrfs scrub start -Bd $tgt
        # btrbk
        else if set -q _flag_n
            sudo btrbk dryrun -c $conf -v
        else if set -q _flag_l
            sudo btrbk list backups -c $conf -v
        else if set -q _flag_p
            sudo btrbk snapshot -v
        else if set -q _flag_r
            sudo btrbk run -c $conf -v
        else
            echo "Usage: btr <operation> [...]"
            echo "Operation: -u, --usage        show btrfs filesystem usage"
            echo "               -t, --target   set target subvolume"
            echo "           -b, --balance      perform a btrfs balance"
            echo "               -du=<value>    set data usage"
            echo "               -mu=<value>    set metadata usage"
            echo "               -t, --target   set target subvolume"
            echo "           -s, --scrub        perform a btrfs scrub"
            echo "               -t, --target   set target subvolume"
            echo "           -n, --dryrun       perform a btrbk dryrun"
            echo "           -l, --list         list btrbk snapshots"
            echo "           -p, --snapshot     take a btrbk snapshot only"
            echo "           -r, --run          take a btrbk snapshot and backup"
        end
    end
    
    # run on start of interactive shell
    ff

end
