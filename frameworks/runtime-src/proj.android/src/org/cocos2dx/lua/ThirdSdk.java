package org.cocos2dx.lua;

import java.security.MessageDigest;

import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import org.cocos2dx.lua.sdk.ThirdSdkInterface;
import org.cocos2dx.lua.utils.PayParams;
import org.cocos2dx.lua.utils.ShareParams;
import org.cocos2dx.lua.utils.UserExtraData;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

public class ThirdSdk {
	public static int s_loginHandler = 0;
	public static int s_logoutHandler = 0;
	public static int s_payHandler = 0;
	public static int s_shareHandler = 0;

	public static ThirdSdkInterface THIRDSDK;
	static String Tag = "kl";

	public static void init(ThirdSdkInterface thirdsdk) {
		THIRDSDK = thirdsdk;
		Log.d(Tag, "ThirdSdk init");
	}

	public static boolean doLogin(int callbackFunc) {
		return doLogin(callbackFunc, null);
	}

	public static boolean doLogin(int callbackFunc, String aJsonStr) {
		Log.d(Tag, "ThirdSdk login");
		if (s_loginHandler != 0) {
			Cocos2dxLuaJavaBridge.releaseLuaFunction(s_loginHandler);
			s_loginHandler = 0;
		}
		Cocos2dxLuaJavaBridge.retainLuaFunction(s_loginHandler);
		s_loginHandler = callbackFunc;
		String post = aJsonStr != null ? aJsonStr : "";
		if (THIRDSDK != null) {
			THIRDSDK.doLogin(post);
		}
		return true;
	}

	public static boolean doLogout(int callbackFunc) {
		Log.d(Tag, "ThirdSdk logout");
		if (s_logoutHandler != 0) {
			Cocos2dxLuaJavaBridge.releaseLuaFunction(s_logoutHandler);
			s_logoutHandler = 0;
		}
		Cocos2dxLuaJavaBridge.retainLuaFunction(s_logoutHandler);
		s_logoutHandler = callbackFunc;
		if (THIRDSDK != null) {
			THIRDSDK.doLogOut();
		}
		return true;
	}

	public static boolean doPay(String jsonStr, int callbackFunc) {
		if (s_payHandler != 0) {
			Cocos2dxLuaJavaBridge.releaseLuaFunction(s_payHandler);
			s_payHandler = 0;
		}
		Cocos2dxLuaJavaBridge.retainLuaFunction(s_payHandler);
		s_payHandler = callbackFunc;

		try {
			JSONObject js = new JSONObject(jsonStr);
			PayParams params = parsePayParams(js);

			THIRDSDK.doPay(params);
		} catch (JSONException e) {
			e.printStackTrace();
			THIRDSDK.doPay(null);
		}
		return true;
	}

	public static boolean doShare(String jsonStr, int callbackFunc) {
		if (s_shareHandler != 0) {
			Cocos2dxLuaJavaBridge.releaseLuaFunction(s_shareHandler);
			s_shareHandler = 0;
		}
		Cocos2dxLuaJavaBridge.retainLuaFunction(s_shareHandler);
		s_shareHandler = callbackFunc;

		try {
			JSONObject js = new JSONObject(jsonStr);
			ShareParams params = parseShareParams(js);

			THIRDSDK.doShare(params);
		} catch (JSONException e) {
			e.printStackTrace();
		}

		return true;
	}

	public static boolean doExit() {
		return false;
	}

	public static void doSubmitExtraData(String jsonStr) {
		try {
			JSONObject js = new JSONObject(jsonStr);
			final UserExtraData extraData = new UserExtraData();
			extraData.setDataType(js.optInt("dataType"));
			extraData.setRoleID(js.optString("roleID"));
			extraData.setRoleName(js.optString("roleName"));
			extraData.setRoleLevel(js.optString("roleLevel"));
			extraData.setServerID(js.optInt("serverID"));
			extraData.setServerName(js.optString("serverName"));
			extraData.setMoneyNum(js.optInt("moneyNum"));
			extraData.setRoleCTime(js.optLong("roleCTime"));
			extraData.setExtraData(js.optString("exData"));

			THIRDSDK.doSubmitExData(extraData);

		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

	public static void sendCallbackFunc(final int func, final String data) {
		THIRDSDK.getAppActivity().runOnGLThread(new Runnable() {
			public void run() {
				try {
					Cocos2dxLuaJavaBridge.callLuaFunctionWithString(func, data);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});

	}

	/*
	 * 本地(lua)传过来的参数转换成U8SDK的PayParams结构
	 */
	private static PayParams parsePayParams(JSONObject json) {
		PayParams params = new PayParams();

		try {
			params.setProductId(json.getString("productID"));
			params.setProductName(json.getString("productName"));
			params.setProductDesc("");
			params.setPrice(json.getInt("price"));
			params.setRatio(0);// 已经废弃
			params.setBuyNum(1);
			params.setCoinNum(1);
			params.setServerId(json.getString("serverID"));
			params.setServerName(json.getString("serverName"));
			params.setRoleId(json.getString("roleID"));
			params.setRoleName(json.getString("roleName"));
			params.setRoleLevel(1);
			params.setPayNotifyUrl("");// 已经废弃
			params.setVip("");
			params.setOrderID(json.getString("orderID"));
			params.setExtension(json.getString("extension"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return params;
	}

	/*
	 * 本地(lua)传过来的参数转换成U8SDK的PayParams结构
	 */
	private static ShareParams parseShareParams(JSONObject json) {
		ShareParams params = new ShareParams();

		try {
			params.setDesc(json.getString("desc"));
			params.setJumpUrl(json.getString("jumpUrl"));
			params.setTitle(json.getString("title"));
			params.setThumbUrl(json.getString("thumbUrl"));
			params.setImageUrl(json.getString("imageUrl"));

		} catch (Exception e) {
			e.printStackTrace();
		}

		return params;
	}

	public static boolean isThirdSDKIntegral() {
		return THIRDSDK != null;
	}

	public static void onSceneChange(int aSceneID) {
		if (isThirdSDKIntegral()) {
			THIRDSDK.onSceneChange(aSceneID);
		}
	}

	public static String doMd5(String aStr) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F' };
		try {
			byte[] btInput = aStr.getBytes();
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			mdInst.update(btInput);
			byte[] md = mdInst.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			String s = new String(str);
			return s;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "";
	}

	/**
	 * 获取推送需要的信息
	 * 
	 * @param uuid
	 *            玩家的角色id
	 */
	public static void getDeviceInfo(String uuid) {
		THIRDSDK.getDeviceInfo(uuid);
	}
}