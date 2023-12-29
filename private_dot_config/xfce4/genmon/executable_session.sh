#!/usr/bin/env fish

set user (whoami)
set kernel (uname -r)
set uptime (uptime -p | cut -d ' ' -f 2-)

set txt "<txt>"
set txt $txt"$(echo \UF303) "
set txt $txt"</txt>"

set tool "<tool>"
set tool $tool"<span weight='Bold'>$user@$hostname\n"
set tool $tool"kernel: $kernel</span>\n"
set tool $tool"uptime: $uptime"
set tool $tool"</tool>"

set txtclick "<txtclick>"
set txtclick $txtclick"xfce4-session-logout"
set txtclick $txtclick"</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
