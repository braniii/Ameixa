package org.xphnx.ameixa;

import android.content.Context;

class IceScreenUtils {

    static float densityScale(Context context) {

        return (context.getResources().getDisplayMetrics().density);
    }
}