#include "THelper.h"


void THelper::log(const string &str)
{
	cocos2d::log("lua-log : %s", str.c_str());
}
