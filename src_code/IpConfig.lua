tsixi = tsixi or { }
tsixi.config = tsixi.config or { }
--我们自己服务器的url 李欣那边的
tsixi.config.game_server_url = "http://192.168.2.137/qx/center/game.net?type=" 
tsixi.config.game_login_url = tsixi.config.game_server_url .. "1001"
tsixi.config.enter_game_url = tsixi.config.game_server_url .. "1004"
tsixi.config.create_role_url = tsixi.config.game_server_url .. "1003"
tsixi.config.get_servers_url = tsixi.config.game_server_url .. "1005"
tsixi.config.get_nick_url = tsixi.config.game_server_url .. "1006"
tsixi.config.get_notice_url = tsixi.config.game_server_url .. "1007"
tsixi.config.get_serverstate_url = tsixi.config.game_server_url .. "1008"


tsixi.config.get_need_upload_recharge_log = string.format("%s%d",tsixi.config.game_server_url,1018)
tsixi.config.upload_recharge_log = string.format("%s%d",tsixi.config.game_server_url,1019)
tsixi.config.get_need_finish_all_order = string.format("%s%d",tsixi.config.game_server_url,1022)

-- 周0冬那边的url
tsixi.config.center_server_url = "http://192.168.2.200:8080/TSDK/"
tsixi.config.regist_url = tsixi.config.center_server_url .. "account/register"
tsixi.config.fast_regist_url = tsixi.config.center_server_url .. "account/guest"
tsixi.config.login_url = tsixi.config.center_server_url .. "account/login"
tsixi.config.verify_url = tsixi.config.center_server_url .. "user/getToken"
tsixi.config.get_orderID_url = tsixi.config.center_server_url .. "pay/getOrderID"
tsixi.config.pay_check_url = tsixi.config.center_server_url .. "pay/apple/verify"
tsixi.config.google_pay_check_url = tsixi.config.center_server_url .. "pay/google/verify"
tsixi.config.ysdk_pay_check_url = tsixi.config.center_server_url .. "pay/ysdk/payCallback"
tsixi.config.ysdk_token_fresh_url = tsixi.config.center_server_url .. "pay/ysdk/refreshToken"
tsixi.config.test_paycallback_url = tsixi.config.center_server_url .. "pay/TSDK/payCallback"
tsixi.config.sdk_sign_url = tsixi.config.center_server_url .. "user/sign"
tsixi.config.bind_email_url = tsixi.config.center_server_url .. "account/bindEmail"
tsixi.config.find_pwd_url = tsixi.config.center_server_url .. "account/sendResetMailCaptcha"
tsixi.config.modify_pwd_url = tsixi.config.center_server_url .. "account/modifyPsw"

tsixi.config.faq = "http://acdn.tsixi.com/clientconfig/fqa/service.html"

tsixi.config.get_config_url = "http://config.ddt2.tsixi.com/portal/config/get"
tsixi.config.get_version_url = "http://192.168.2.137:8080/game_login/assets/version.txt"
--Log.setUrl("http://192.168.2.140/logs/log.php")

function G_resetCenterServer(url)
    tsixi.config.game_login_url = url .. "1001"
    tsixi.config.enter_game_url = url .. "1004"
    tsixi.config.create_role_url = url .. "1003"
    tsixi.config.get_servers_url = url .. "1005"
    tsixi.config.get_nick_url = url .. "1006"
    tsixi.config.get_notice_url = url .. "1007"
    tsixi.config.get_serverstate_url = url .. "1008"
end
function G_resetSDKServer(url)
    tsixi.config.regist_url = url .. "account/register"
    tsixi.config.fast_regist_url = url .. "account/guest"
    tsixi.config.login_url = url .. "account/login"
    tsixi.config.verify_url = url .. "user/getToken"
    tsixi.config.get_orderID_url = url .. "pay/getOrderID"
    tsixi.config.pay_check_url = url .. "pay/apple/verify"
    tsixi.config.google_pay_check_url = url .. "pay/google/verify"
    tsixi.config.ysdk_pay_check_url = url .. "pay/ysdk/payCallback"
    tsixi.config.ysdk_token_fresh_url = url .. "pay/ysdk/refreshToken"
    tsixi.config.test_paycallback_url = url .. "pay/TSDK/payCallback"
    tsixi.config.sdk_sign_url = url .. "user/sign"
    tsixi.config.bind_email_url = url .. "account/bindEmail"
    tsixi.config.find_pwd_url = url .. "account/sendResetMailCaptcha"
    tsixi.config.modify_pwd_url = url .. "account/modifyPsw"
end