package org.cocos2dx.lua;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lua.sdk.ThirdSdkInterface;
import org.cocos2dx.lua.utils.PayParams;
import org.cocos2dx.lua.utils.ShareParams;
import org.cocos2dx.lua.utils.UserExtraData;

import android.util.Log;

public class TestSdk implements ThirdSdkInterface {

	private Cocos2dxActivity appActivity;

	static String Tag = "kl";

	public TestSdk(Cocos2dxActivity context) {
		appActivity = context;
	}

	@Override
	public Cocos2dxActivity getAppActivity() {
		return appActivity;
	}

	@Override
	public void doLogin(String aJsonStr) {// 登录成功
		Log.d(Tag, "TestSdk login");
		final String dataStr = "{\"token\":\"" + "123" + "\",\"userid\":\""
				+ "123" + "\"}";
		ThirdSdk.sendCallbackFunc(ThirdSdk.s_loginHandler, dataStr);
	}

	@Override
	public void doLogOut() {
		Log.d(Tag, "TestSdk logout");
		ThirdSdk.sendCallbackFunc(ThirdSdk.s_logoutHandler, "");
	}

	@Override
	public void doPay(PayParams aParams) {
		// int code = Cocos2dxLuaJavaBridge.callLuaGlobalFunctionWithString(
		// "g_payCallBack", result); //result-json
	}

	@Override
	public void doSubmitExData(UserExtraData aEx) {
		// TODO Auto-generated method stub

	}

	@Override
	public void doShare(ShareParams params) {
		// TODO Auto-generated method stub

	}

	@Override
	public void doOtherAction(String aJsonStr) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onSceneChange(int aSceneID) {
		// TODO Auto-generated method stub

	}

	@Override
	public void getDeviceInfo(String uuid) {
		// TODO Auto-generated method stub

	}

}
