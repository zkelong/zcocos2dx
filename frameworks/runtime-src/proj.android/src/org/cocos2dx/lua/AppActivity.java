/****************************************************************************
Copyright (c) 2008-2010 Ricardo Quesada
Copyright (c) 2010-2016 cocos2d-x.org
Copyright (c) 2013-2016 Chukong Technologies Inc.
 
http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 ****************************************************************************/
package org.cocos2dx.lua;

import java.lang.reflect.Constructor;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lua.sdk.ThirdSdkInterface;

import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

public class AppActivity extends Cocos2dxActivity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);

		ApplicationInfo ai;
		try {
			ai = getPackageManager().getApplicationInfo(getPackageName(),
					PackageManager.GET_META_DATA);
			Bundle bundle = ai.metaData;
			String sdkCassNameKey = "android.app.sdkName";
			if (bundle.containsKey(sdkCassNameKey)) {
				String className = bundle.getString(sdkCassNameKey);
				Class<?> sdkClass = Class.forName(className);
				Constructor<?> cs = sdkClass
						.getConstructor(Cocos2dxActivity.class);
				ThirdSdk.init((ThirdSdkInterface) cs.newInstance(this));
			}

			// } catch (NameNotFoundException | InstantiationException |
			// IllegalAccessException | IllegalArgumentException
			// | InvocationTargetException | NoSuchMethodException |
			// SecurityException | ClassNotFoundException e) {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		super.onPause();
		Log.d("KL", "Pause..................");
	}

	@Override
	protected void onDestroy() {
		// TODO Auto-generated method stub
		super.onDestroy();
		Log.d("KL", "pause...............");
	}
}
