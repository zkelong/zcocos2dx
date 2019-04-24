rd .\src /q /s
goto start
cocos luacompile 参数：
	-h, --help：show this help message and exit
	-v, --verbose：更多输出信息
	-s SRC_DIR_ARR, --src SRC_DIR_ARR：指定需要编译的 lua 文件路径，支持多个路径
	-d DST_DIR, --dst DST_DIR：指定输出文件路径
	-e, --encrypt：开启 XXTEA 加密功能
	-k KNCRYPTKEY, --encryptkey ENCRYPTKEY 指定 XXTEA 加密的 key 字段。
	-b ENCRYPTSIGN, --encryptsign ENCRYPTSIGN 指定 XXTEA 加密功能的 sign 字段
	--disable-compile 关闭编译为字节码的功能。
主要用到-s,-d,-e,-k,-b以及--disable-compile这几个参数。
--disable-compile关闭字节码编译，使用是因为现有的 cocos 引擎用的是 luajit 来编译字节码，仅支持32位，不支持64位的机子。
下面的 KeLong zcocos2dx 对应 Class/AppDelegate.cpp 的 stack->setXXTEAKeyAndSign的值
:start
cocos luacompile -s .\src_code -d .\src -e -k KeLong -b zcocos2dx --disable-compile
