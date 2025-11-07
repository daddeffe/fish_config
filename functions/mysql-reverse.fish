
function mysql-reverse --description "Crea un tunnel SSH reverse per connettersi a MySQL" --argument-names ssh_host mysql_host password local_port
    # Verifica che tutti gli argomenti siano forniti
    if test (count $argv) -lt 3
        echo "Uso: mysql-reverse <ssh_host> <mysql_host> <password> [local_port]"
        echo ""
        echo "Argomenti:"
        echo "  ssh_host   - Host SSH per il tunnel (es: user@ssh.example.com)"
        echo "  mysql_host - Host MySQL di destinazione (es: mysql1.example.com)"
        echo "  password   - Password per MySQL"
        echo "  local_port - Porta locale per il tunnel (default: 3307)"
        return 1
    end

    # Imposta la porta locale di default se non specificata
    set -l local_port $argv[4]
    if test -z "$local_port"
        set local_port 3307
    end

    # Cerca una porta libera nel range di 10 porte
    set -l max_attempts 10
    set -l port_found 0
    set -l attempted_port $local_port

    for i in (seq 0 (math $max_attempts - 1))
        set attempted_port (math $local_port + $i)

        # Verifica se la porta è occupata usando netstat o ss
        if command -v ss >/dev/null
            ss -tuln | grep -q ":$attempted_port "
            set port_in_use $status
        else if command -v netstat >/dev/null
            netstat -tuln | grep -q ":$attempted_port "
            set port_in_use $status
        else
            # Se non ci sono strumenti disponibili, prova direttamente
            set port_in_use 1
        end

        if test $port_in_use -ne 0
            # Porta libera trovata
            set port_found 1
            set local_port $attempted_port
            break
        end
    end

    if test $port_found -eq 0
        echo "Errore: nessuna porta libera trovata"
        return 1
    end

    echo "Usando porta locale: $local_port"

    # Crea il tunnel SSH in background
    ssh -f $ssh_host -L $local_port:$mysql_host:3306 -N

    # Connetti a MySQL attraverso il tunnel
    mysql -h 127.0.0.1 -P $local_port -p$password
    echo "Mysql reverse proxy on port $local_port"
end
