#include "kl_lua_auto.h"
#include <sstream>
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"
#include "LuaBindings.h"


int lua_kl_Thelper_log(lua_State* tolua_S)
{
	int argc = 0;
	bool ok = true;

#if COCOS2D_DEBUG >= 1
	tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
	if (!tolua_isusertable(tolua_S, 1, "THelper", 0, &tolua_err)) goto tolua_lerror;
#endif

	argc = lua_gettop(tolua_S) - 1;
	if (argc == 1)
	{
		std::string arg0;
		ok &= luaval_to_std_string(tolua_S, 2, &arg0, "THelper:log");
		if (!ok)
		{
			tolua_error(tolua_S, "invalid arguments in funciton 'lua_kl_THelper_log'", nullptr);
			return 0;
		}
		THelper::log(arg0);
		lua_settop(tolua_S, 1);
		return 1;
	}
	luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n", "THelper:log", argc, 1);
	return 0;
#if COCOS2D_DEBUG >= 1
tolua_lerror:
	tolua_error(tolua_S, "#feeror in function 'lua_kl_THelper_log'.", &tolua_err);
#endif
	return 0;
}

int lua_register_kl_THelper(lua_State* tolua_S)
{
	tolua_usertype(tolua_S, "THelper");
	tolua_cclass(tolua_S, "THelper", "THelper", "", nullptr);
	tolua_beginmodule(tolua_S, "THelper");

	tolua_function(tolua_S, "log", lua_kl_Thelper_log);

	tolua_endmodule(tolua_S);
	std::string typeName = "THelper";
	g_luaType[typeName] = "THelper";
	g_typeCast["THelper"] = "THelper";
	return 1;
}

TOLUA_API int register_all_kl(lua_State* tolua_S)
{
	tolua_open(tolua_S);

	tolua_module(tolua_S, "kl", 0);
	tolua_beginmodule(tolua_S, "kl");

	lua_register_kl_THelper(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}
