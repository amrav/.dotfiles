function change_proxy() {
    case $1 in
	'tor')
	    unset http_proxy && unset https_proxy && \
		unset HTTP_PROXY && unset HTTPS_PROXY && export socks_proxy='127.0.0.1:49705'
	    ;;
	'apple')
	    unset socks_proxy && export http_proxy='http://10.3.100.211:8080/' && \
		export https_proxy=$http_proxy;;
	*)
	    unset socks_proxy && unset HTTP_PROXY && unset HTTPS_PROXY && \
		export http_proxy=$1 && export https_proxy=$1;;
    esac
}

# use permissive proxy by default
change_proxy 'apple'

proxies=( \
    "http://10.3.100.211:8080" \
    "http://10.3.100.212:8080" \
    "http://144.16.192.213:8080" \
    "http://144.16.192.216:8080" \
    "http://144.16.192.217:8080" \
    "http://144.16.192.218:8080" \
    "http://144.16.192.245:8080" \
    "http://144.16.192.247:8080")

# Use Microsoft servers to download large file
large_file_url="http://download.microsoft.com/download/8/A/C/8AC7C482-BC74-492E-B978-7ED04900CEDE/IE10-Windows6.1-x86-en-us.exe"

function speedtest_proxies() {
    time=30
    [[ $1 -gt 0 ]] && time=$1 && echo "Set time to $time"
    echo "The test will take ~$time seconds. Downloading Microsoft IE 10 :P\n"
    for proxy in $proxies;
    do echo "Testing proxy: $proxy...";
	curl --silent --max-time $time --proxy $proxy -o /dev/null \
	    --write-out "$proxy --> %{speed_download} B/s\n" \
	    $large_file_url >> ~/.speedtest_proxy &
    done
    echo "Waiting for results..." && wait && echo "Fastest proxies:" && \
	sort -k3 -n -r ~/.speedtest_proxy | column -t \
	&& rm ~/.speedtest_proxy
}
    
    
