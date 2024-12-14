#!/usr/bin/env fish

set updates "$(checkupdates | cut -d ' ' -f 1)"

set txt "<txt>"

set txt $txt"$(echo \UF487)"

if test $updates != ""
    set tool "<tool>"
    set txtclick "<txtclick>"
    
    set txt $txt"  update"
    set tool $tool$updates
    set txtclick $txtclick"wezterm start -- fish -i -c 'pm -U'"
    
    set txt $txt"</txt>"
    set tool $tool"</tool>"
    set txtclick $txtclick"</txtclick>"

    echo -e "$txt"
    echo -e "$tool"
    echo -e "$txtclick"
else
    set txt $txt"  none"

    set txt $txt"</txt>"

    echo -e "$txt"
end
