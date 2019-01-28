package org.onesmart.jrchattestandroid;

import android.app.Application;
import com.sobot.chat.SobotApi;


public class MyApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        SobotApi.initSobotSDK(this, "d7ab4728ed784260b5655fce924a75e0", "UserId");
    }
}
