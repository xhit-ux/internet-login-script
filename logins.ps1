#用户信息
$user_account=""#请在双引号内填写统一认证账号（学号）
$user_password=""#请在引号内填写统一认证密码



# 获取本机的 IP 地址（适用于 WLAN）
$localIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -match "Wi-Fi|WLAN" } | Select-Object -ExpandProperty IPAddress)

# 如果未获取到 Wi-Fi 接口的 IP，则默认使用本机的第一个 IPv4 地址
if (-not $localIP) {
    $localIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notmatch "Loopback" } | Select-Object -ExpandProperty IPAddress | Select-Object -First 1)
}

Write-Host "检测到本机 IP: $localIP"

# 发送第一个 GET 请求
$first_url = "http://192.168.167.42/a79.htm?wlanuserip=$localIP&wlanacname="
$response1 = curl.exe -s -X GET "$first_url" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:135.0) Gecko/20100101 Firefox/135.0" -H "Accept: */*" -H "Referer: http://192.168.167.42/"

# 检查返回内容是否包含 "上网登录页"
if ($response1 -match "上网登录页") {
    Write-Host "检测到上网登录页，发送登录请求..."

    # 发送第二个 GET 请求
    $second_url = "http://192.168.167.42:801/eportal/portal/login?callback=dr1003&login_method=1&user_account=%2C0%2C$user_account&user_password=$user_password&wlan_user_ip=$localIP&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.1.3&terminal_type=1&lang=zh-cn&v=6392&lang=zh"
    
    $response2 = curl.exe -s -X GET "$second_url" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:135.0) Gecko/20100101 Firefox/135.0" -H "Accept: */*" -H "Referer: http://192.168.167.42/"

    # 检查是否认证成功
    if ($response2 -match '"result":0' -or $response2 -match '"result":1') {
        Write-Host "登录成功！"
    } else {
        Write-Host "登录失败！"
    }
} else {
    Write-Host "未检测到上网登录页，无需认证。"
}
pause