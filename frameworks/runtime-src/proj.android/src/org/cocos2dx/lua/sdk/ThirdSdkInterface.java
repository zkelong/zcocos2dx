package org.cocos2dx.lua.sdk;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lua.utils.PayParams;
import org.cocos2dx.lua.utils.ShareParams;
import org.cocos2dx.lua.utils.UserExtraData;

public interface ThirdSdkInterface {
	public Cocos2dxActivity getAppActivity();

	public void doLogin(String aJsonStr);

	public void doLogOut();

	public void doPay(PayParams aParams);

	public void doSubmitExData(UserExtraData aEx);

	public void doShare(ShareParams params);

	public void doOtherAction(String aJsonStr);

	public void onSceneChange(int aSceneID);

	public void getDeviceInfo(String uuid);
}
