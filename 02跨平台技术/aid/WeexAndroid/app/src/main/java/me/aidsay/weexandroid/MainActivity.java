package me.aidsay.weexandroid;

import android.graphics.Rect;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.Toast;

import com.taobao.weex.IWXRenderListener;
import com.taobao.weex.WXSDKInstance;
import com.taobao.weex.common.WXRenderStrategy;
import com.taobao.weex.utils.WXFileUtils;

import java.util.HashMap;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "MainActivity";

    private FrameLayout flContainer;
    private View mWAView;

    private WXSDKInstance mInstance;

    private HashMap mConfigMap = new HashMap<String, Object>();

    private String path = "HelloWeex.js";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        flContainer = (FrameLayout)findViewById(R.id.flContainer);


        mInstance = new WXSDKInstance(this);

        mInstance.registerRenderListener(new IWXRenderListener() {
            @Override
            public void onViewCreated(WXSDKInstance instance, View view) {
                if (mWAView != null && flContainer != null && mWAView.getParent() == flContainer) {
                    flContainer.removeView(mWAView);
                }

                mWAView = view;
                flContainer.addView(view);
                flContainer.requestLayout();
            }

            @Override
            public void onRenderSuccess(WXSDKInstance instance, int width, int height) {

            }

            @Override
            public void onRefreshSuccess(WXSDKInstance instance, int width, int height) {

            }

            @Override
            public void onException(WXSDKInstance instance, String errCode, String msg) {
                Toast.makeText(MainActivity.this, "errCode: "+errCode+"\nmsg: "+msg, Toast.LENGTH_SHORT).show();
            }
        });

        flContainer.post(new Runnable() {
            @Override
            public void run() {
                Rect outRect = new Rect();
                MainActivity.this.getWindow().getDecorView().getWindowVisibleDisplayFrame(outRect);
                mConfigMap.put("bundleUrl", path);
                mInstance.render(
                        TAG,
                        WXFileUtils.loadAsset(path, MainActivity.this),
                        mConfigMap,
                        null,
                        ScreenUtil.getDisplayWidth(MainActivity.this),
                        ScreenUtil.getDisplayHeight(MainActivity.this),
                        WXRenderStrategy.APPEND_ASYNC
                );
            }
        });

        mInstance.onActivityCreate();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mInstance.onActivityDestroy();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mInstance.onActivityPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        mInstance.onActivityResume();
    }
}
