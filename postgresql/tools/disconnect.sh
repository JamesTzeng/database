# just need to connect to one of 5 pg servers
#ssh postgres@10.0.0.1 -p30111
#ssh postgres@10.0.0.2 -p30121
#ssh postgres@10.0.0.3 -p30131
#ssh postgres@10.0.0.4 -p30141
#ssh postgres@10.0.0.9 -p30151
export DB_NAME="test_db"
export CONNECT_NUM_STR="select count(1)-1 from pg_stat_activity;"
export DISCONNECT_STR="SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$DB_NAME' AND pid <> pg_backend_pid();"


declare -a HostList=(
"10.0.0.1,40011"
"10.0.0.2,40021"
"10.0.0.3,40031"
"10.0.0.4,40041"
"10.0.0.9,40051"
)

for conn_str in "${HostList[@]}" 
do 
    IFS=',' read -r -a Array <<< "$conn_str" 
    ip="${Array[0]}"
    port="${Array[1]}"
    
    echo "connect to "$ip:$port
    
    echo "number of current connections"
    psql -p$port -h$ip -c "$CONNECT_NUM_STR"
    
    echo "disconnect all connections"
    psql -p$port -h$ip -c "$DISCONNECT_STR"
    
    echo "number of current connections after disconnect"
    psql -p$port -h$ip -c "$CONNECT_NUM_STR"
done

