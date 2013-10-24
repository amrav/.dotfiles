function change_proxy() {
    case $1 in
	'tor')
	    unset http_proxy && unset https_proxy && \
		unset HTTP_PROXY && unset HTTPS_PROXY && export socks_proxy='127.0.0.1:49705'
	    ;;
	'apple')
	    unset socks_proxy && export http_proxy='http://10.3.100.211:8080/' && \
		export https_proxy=$http_proxy;;
	'geology')
	    unset socks_proxy && export http_proxy='http://203.110.246.109:8888/' && \
		export https_proxy=$http_proxy;;

	*)
	    unset socks_proxy && unset HTTP_PROXY && unset HTTPS_PROXY && \
		export http_proxy=$1 && export https_proxy=$1;;
    esac
}

# use permissive proxy by default
change_proxy 'apple'

proxies=( \
    "http://10.3.100.209:8080" \
    "http://10.3.100.210:8080" \    
    "http://10.3.100.211:8080" \
    "http://10.3.100.212:8080" \
    "http://144.16.192.213:8080" \
    "http://144.16.192.216:8080" \
    "http://144.16.192.217:8080" \
    "http://144.16.192.218:8080" \
    "http://144.16.192.245:8080" \
    "http://144.16.192.247:8080" \
    "http://203.110.246.109:8888")

# Use Microsoft servers to download large file
large_file_url="http://download.microsoft.com/download/8/A/C/8AC7C482-BC74-492E-B978-7ED04900CEDE/IE10-Windows6.1-x86-en-us.exe"

function _speedtest_proxies() {
    local time=30
    [[ $1 -gt 0 ]] && time=$1
    echo "The test will take ~$time seconds. Downloading Microsoft IE 10 :P\n"
    local pids
    pids=()
    for proxy in $proxies; do
	echo "Testing proxy: $proxy...";
	curl --silent --max-time $time --proxy $proxy -o /dev/null \
	    --write-out "$proxy --> %{speed_download} B/s\n" \
	    $large_file_url >> ~/.speedtest_proxy &
	pids+=$!
    done
    echo "Waiting for results..."
    for pid in $pids; do
    	wait $pid >& /dev/null
    done
    echo "Fastest proxies:"
    sort -k3 -n -r ~/.speedtest_proxy | column -t
    rm ~/.speedtest_proxy
}

function remove_messages() {
    echo $1
}

# wrapper function, to get rid of the shell messages upon process completion
# maybe there is a better way to do this?
function speedtest_proxies() {
    local time=30
    [[ $1 -gt 0 ]] && time=$1
    _speedtest_proxies $time | grep --color=never '.*'
}

function set_fastest_proxy() {
    local time=30
    [[ $1 -gt 0 ]] && time=$1
    local fastest_proxy="$(speedtest_proxies $time | grep '^http' | head -1 | \
	awk -F '[ :/]+' '{print $2, $3}')"
    # weird form with echo required because of fastest_proxy being interpreted
    # as single argument
    sudo networksetup -setsecurewebproxy "Wi-Fi" $(echo -n $fastest_proxy)
    sudo networksetup -setwebproxy "Wi-Fi" $(echo -n $fastest_proxy)
    echo "Fastest proxy set as $fastest_proxy"
}

function auto_fast_proxy() {
    local time=100
    [[ $1 -gt 0 ]] && time=$1
    echo "Interval between proxy updates set to $time seconds."
    echo "Proxy updates will take ~30 seconds."
    while true; do
	set_fastest_proxy
	sleep $time
    done
}

    
