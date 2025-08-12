#
# ~/.config/fish/config.fish by chluna
#

set -g _git ~/git
set -g _sync ~/sync

# environment variables
fenv "source ~/.profile"

if status is-interactive

    # kitty completions
    type -q kitty; and kitty + complete setup fish | source

    # fzf
    if command -q fzf
        fzf --fish | source
        set -l night_mode night
        if not fish_is_root_user
            set night_mode (xfconf-query -c night-mode -p /active)
        end
        if test $night_mode = day
            set -gx FZF_DEFAULT_OPTS "--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 --color=selected-bg:#BCC0CC --color=border:#9CA0B0,label:#4C4F69"
        else
            set -gx FZF_DEFAULT_OPTS "--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 --color=selected-bg:#45475A --color=border:#6C7086,label:#CDD6F4"
        end
    end

    # aliases
    if not fish_is_root_user
        abbr se sudoedit
        alias sudo "sudo "
    end

    alias free "free -m" # show sizes in MB
    alias cp "cp -i --reflink=always" # confirm before overwriting something
    alias df "df -h" # human-readable sizes
    abbr c clear
    abbr jc "journalctl -rb"
    command -q bat; and alias cat bat
    if command -q kitty
        abbr kt "kitten themes"
        if test $TERM = xterm-kitty
            alias ssh "kitten ssh"
        end
    end
    command -q btop; and abbr t btop
    command -q nvtop; and abbr gt nvtop
    command -q powertop; and abbr pt "sudo powertop"
    command -q codium; and abbr code codium
    command -q fd; and abbr find fd
    command -q hledger; and alias run "hledger -f $_sync/health/running/running.journal"
    if command -q fastfetch
        set -g _s fastfetch
        abbr s fastfetch
    end
    if command -q nvim
        set -g _e nvim
        abbr vi nvim
        abbr vim nvim
        abbr vimdiff "nvim -d"
        abbr xxd "nvim -b"
    else if command -q helix
        set -g _e helix
    end
    abbr e $_e
    if command -q eza
        alias ls "eza -a --color=always --icons=always --group-directories-first"
        alias ll "eza -albg --color=always --icons=always --group-directories-first --time-style long-iso"
    end
    if command -q rg
        set -g _grep rg
        abbr grep $_grep
    else
        set -g _grep "grep --color=auto"
        alias grep $_grep
    end
    if command -q chezmoi
        abbr cz chezmoi
        abbr dot "chezmoi cd"
    end

    # functions
    function pm -d "wrapper for paru/pacman"
        argparse -i i/install r/remove q/query p/purge m/mirror \
            e/export c/clean d/diff u/update U/upgrade -- $argv
        or return
        if command -q paru
            set -f pkg paru
            set -f supkg paru
        else
            set -f pkg pacman
            set -f supkg "sudo pacman"
        end
        if set -q _flag_i
            $pkg -Slq | fzf --multi --preview "$pkg -Si {}" | xargs -ro $supkg -S
        else if set -q _flag_r
            $pkg -Qq | fzf --multi --preview "$pkg -Qi {}" | xargs -ro $supkg -Rsn
        else if set -q _flag_q
            $pkg -Slq | fzf --preview "$pkg -Si {}"
        else if set -q _flag_p
            set -f orphans ($pkg -Qtdq)
            and string join \n $orphans | $supkg -Rsn -
        else if set -q _flag_m
            mirro-rs --ipv4 --ipv6 --sort score --rate -c Australia -c "Hong Kong" -c Indonesia -c Japan -c "New Zealand" -c Singapore -c Korea -c Taiwan -o /etc/pacman.d/mirrorlist --direct
        else if set -q _flag_e
            set -f exp ~/.config/pacman
            if not test -d $exp
                mkdir -p $exp
            end
            $pkg -Qqen >$exp/arch_packages.txt
            $pkg -Qqem >$exp/aur_packages.txt
        else if set -q _flag_c
            $supkg -Sc
        else if set -q _flag_d
            DIFFPROG=delta sudo -E pacdiff
        else if set -q _flag_u
            checkupdates
        else if set -q _flag_U
            set -f log (mktemp)
            script -q $log -c "$supkg -Syu"
            $_grep -q '.+\.pac(new|orig|save)' $log
            if test $status -eq 0
                pm --diff
            end
            rm $log
            pm --purge
            xfce4-panel --plugin-event=genmon-1:refresh:bool:true
        else
            echo "Usage: pm <operation>"
            echo "Operation: -i, --install    install packages using fzf"
            echo "           -r, --remove     remove packages using fzf"
            echo "           -q, --query      query local package using fzf"
            echo "           -p, --purge      remove orphaned packages"
            echo "           -m, --mirror     update mirrorlist"
            echo "           -e, --export     export local and AUR package lists"
            echo "           -c, --clean      clean paru cache"
            echo "           -d, --diff       find and act on pac[diff|new|save] files"
            echo "           -u, --update     check for package updates"
            echo "           -U, --upgrade    update and upgrade packages"
        end
    end

    function fsh --d "edit config.fish"
        argparse e/edit r/reload -- $argv
        or return
        if set -q _flag_e
            set -f conf $XDG_CONFIG_HOME/fish/config.fish
            set -f csum (mktemp)
            sha1sum $conf >$csum
            $_e $conf
            sha1sum -c $csum --status
            if test $status -ne 0
                read -f -n 1 -P "Reload changes? [y/n]: " choice
                if test (string lower $choice) = y
                    exec fish
                end
            end
            rm $csum
            clear
        else if set -q _flag_r
            exec fish
            clear
        end
    end

    function fin --d "finance wrapper for hledger"
        argparse -i "j/journal=" l/latest e/edit m/main g/gui c/check -- $argv
        or return
        if set -q _flag_j
            $_e $_git/ledger/$_flag_j.journal
        else if set -q _flag_l
            $_e (command ls $_git/ledger/ | rg -e '\d{4}.journal' | tail -n 1)
        else if set -q _flag_e
            $_e $_git/ledger
        else if set -q _flag_m
            $_e $_git/ledger/main.journal
        else if set -q _flag_g
            hledger-ui -w -f $_git/ledger/main.journal --theme=terminal --pretty=yes
        else if set -q _flag_c
            hledger -f $_git/ledger/main.journal check -s ordereddates
        else
            hledger -f $_git/ledger/main.journal $argv
        end
    end

    function sc --d "simple systemctl wrapper"
        argparse -i u/user "s/status=" "r/restart=" "j/journal=" "e/edit=" -- $argv
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
        argparse u/usage b/balance s/scrub "t/target=" "du=" "mu=" \
            n/dryrun l/list p/snapshot r/run -- $argv
        or return
        set -f conf "/etc/btrbk/btrbk-backup.conf"
        if test "$_flag_t" = loc
            set -f tgt /
        else if test "$_flag_t" = ext
            set -f tgt /run/media/spike/ssd
        else
            set -f tgt $_flag_t
        end
        # btrfs-progs
        if set -q _flag_u; and set -q _flag_t
            sudo btrfs filesystem usage $tgt
        else if set -q _flag_b; and set -q _flag_t; and set -q _flag_du; and set -q _flag_mu
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

end

# function overrides
function fish_greeting
    if set -q _s
        $_s
    else
        echo
    end
end
