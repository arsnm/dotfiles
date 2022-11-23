check_network () {
    host="www.google.com"
    ping -c1 "$host" &> /dev/null
    if [ $? -eq 0 ]; then
        return 1
    else
        return 0
    fi  
}

mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}


school() {
    cd $HOME/Documents/cpge/mp/
    source $HOME/.venv/cs_venv/bin/activate
    if [ ! -z "$1" ]; then
        if [ $1 = "tipe" ]; then
            echo "ouverture TIPE..."
            cd $HOME/Documents/cpge/mp/tipe_mp
            check_network
            if [ $? = 1 ]; then
                git push
            fi
        elif [ $1 = "info" ]; then
            echo "ouverture INFO..."
            cd $HOME/Documents/cpge/mp/info_mp
            check_network
            if [ $? = 1 ]; then
                git push
            else
                echo "No network, git push aborted"
            fi
            if [ $# -ge 2 ]; then
                echo 
                if [ $2 = "opt" ]; then
                    cd $HOME/Documents/cpge/mp/info_mp/infoOpt
                elif [ $2 = "tc" ]; then
                    cd $HOME/Documents/cpge/mp/info_mp/infoTC
                fi
            fi
        fi
        if [[ "$@" == *"-vsc"* ]]; then
            code .
        fi
    fi
}
