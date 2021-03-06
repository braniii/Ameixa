package org.xphnx.ameixa.async;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.os.AsyncTask;

import org.xphnx.ameixa.interfaces.BitmapListener;
import org.xphnx.ameixa.utils.ImageUtils;

public class BitmapLoadTask extends AsyncTask<Integer, Void, Bitmap> {

    private final BitmapListener bitmapListener;
    private final Resources resources;
    private final int resId;
    private final int width;
    private final int height;

    public BitmapLoadTask(Resources resources, int resId, int width, int height, BitmapListener bitmapListener) {
        this.resources = resources;
        this.resId = resId;
        this.width = width;
        this.height = height;
        this.bitmapListener = bitmapListener;
    }

    @Override
    protected Bitmap doInBackground(Integer... parameters) {
        // decode image in background
        return ImageUtils.bitmapLoad(resources, resId, width, height);
    }

    @Override
    protected void onPostExecute(Bitmap bitmap) {
        bitmapListener.onBitmap(bitmap);
    }
}
