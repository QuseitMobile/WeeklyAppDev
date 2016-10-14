package me.aidsay.weexandroid;

import android.app.Application;
import android.util.Log;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.taobao.weex.InitConfig;
import com.taobao.weex.WXEnvironment;
import com.taobao.weex.WXSDKEngine;
import com.taobao.weex.adapter.IWXImgLoaderAdapter;
import com.taobao.weex.common.WXException;
import com.taobao.weex.common.WXImageStrategy;
import com.taobao.weex.dom.WXImageQuality;

/**
 * Created by aid on 21/9/16.
 */
public class App extends Application{
    @Override
    public void onCreate() {
        super.onCreate();

//        WXEnvironment.addCustomOptions("appName","TBSample");
        InitConfig initConfig = new InitConfig.Builder()
                .setImgAdapter(new IWXImgLoaderAdapter() {
                    @Override
                    public void setImage(String url, ImageView view, WXImageQuality quality, WXImageStrategy strategy) {
                        Glide.with(App.this).load(url).into(view);
                    }
                })
                .build();

        WXSDKEngine.initialize(this, initConfig);

        try {
            WXSDKEngine.registerModule("event", WXEventModule.class);
        } catch (WXException e) {
            Log.e("WeexAndroid", Log.getStackTraceString(e));
        }
    }
}
