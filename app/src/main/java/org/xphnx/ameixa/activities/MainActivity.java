package org.xphnx.ameixa.activities;

import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.TextView;

import org.xphnx.ameixa.R;
import org.xphnx.ameixa.utils.ImageUtils;
import org.xphnx.ameixa.utils.ScreenUtils;

import androidx.core.content.ContextCompat;

public class MainActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        createLayout();
    }

    private void createLayout() {
        LayoutParams smallLayoutParams = new LayoutParams(LayoutParams.MATCH_PARENT,
                LayoutParams.WRAP_CONTENT, 1f);
        float scale = ScreenUtils.densityScale(getApplicationContext());
        ViewGroup.LayoutParams buttonParams = new ViewGroup.LayoutParams(Math.round(48 * scale), Math.round(48 * scale));

        LinearLayout frameLayout = new LinearLayout(this);
        frameLayout.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT,
                LayoutParams.MATCH_PARENT));
        frameLayout.setBackgroundColor(getResources().getColor(R.color.colorLight));
        frameLayout.setGravity(Gravity.CENTER);
        setContentView(frameLayout);

        LinearLayout baseLayout = new LinearLayout(this);
        baseLayout.setOrientation(LinearLayout.VERTICAL);
        baseLayout.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT,
                LayoutParams.MATCH_PARENT));
        baseLayout.setGravity(Gravity.START);
        frameLayout.addView(baseLayout);

        // icons
        LinearLayout iconLayout = new LinearLayout(this);
        iconLayout.setOrientation(LinearLayout.HORIZONTAL);
        iconLayout.setLayoutParams(smallLayoutParams);
        iconLayout.setGravity(Gravity.CENTER_VERTICAL);
        baseLayout.addView(iconLayout);

        LinearLayout iconClickLayout = new LinearLayout(this);
        iconClickLayout.setOrientation(LinearLayout.HORIZONTAL);
        iconClickLayout.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT,
                LayoutParams.WRAP_CONTENT));
        iconClickLayout.setGravity(Gravity.CENTER);
        iconLayout.addView(iconClickLayout);
        iconClickLayout.setOnClickListener(this::iconActivity);

        Button iconButton = new Button(this);
        iconButton.setLayoutParams(buttonParams);
        iconButton.setBackground(ImageUtils.tint(new BitmapDrawable(getResources(),
                ImageUtils.bitmapLoad(getApplicationContext().getResources(), R.drawable.ic_icon_button,
                        Math.round(48 * scale), Math.round(48 * scale))), getResources().getColor(R.color.colorDark)));
        iconButton.setClickable(false);
        iconClickLayout.addView(iconButton);

        TextView iconText = new TextView(this);
        iconText.setText(R.string.icons);
        iconText.setTextSize(24);
        iconText.setTextColor(ContextCompat.getColor(getApplicationContext(), R.color.colorDark));
        iconText.setPadding(64, 64, 64, 64);
        iconClickLayout.addView(iconText);

        // source
        LinearLayout sourceLayout = new LinearLayout(this);
        sourceLayout.setOrientation(LinearLayout.HORIZONTAL);
        sourceLayout.setLayoutParams(smallLayoutParams);
        sourceLayout.setGravity(Gravity.CENTER_VERTICAL);
        baseLayout.addView(sourceLayout);

        LinearLayout sourceClickLayout = new LinearLayout(this);
        sourceClickLayout.setOrientation(LinearLayout.HORIZONTAL);
        sourceClickLayout.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT,
                LayoutParams.WRAP_CONTENT));
        sourceClickLayout.setGravity(Gravity.CENTER);
        sourceLayout.addView(sourceClickLayout);
        sourceClickLayout.setOnClickListener(this::gitLink);

        Button sourceButton = new Button(this);
        sourceButton.setLayoutParams(buttonParams);
        sourceButton.setBackground(ImageUtils.tint(new BitmapDrawable(getResources(),
                ImageUtils.bitmapLoad(getApplicationContext().getResources(), R.drawable.ic_source_button,
                        Math.round(48 * scale), Math.round(48 * scale))), getResources().getColor(R.color.colorDark)));
        sourceButton.setClickable(false);
        sourceClickLayout.addView(sourceButton);

        TextView sourceText = new TextView(this);
        sourceText.setText(R.string.sourcecodetext);
        sourceText.setTextSize(24);
        sourceText.setTextColor(ContextCompat.getColor(getApplicationContext(), R.color.colorDark));
        sourceText.setPadding(64, 64, 64, 64);
        sourceClickLayout.addView(sourceText);

        // license button
        LinearLayout aboutLayout = new LinearLayout(this);
        aboutLayout.setOrientation(LinearLayout.HORIZONTAL);
        aboutLayout.setLayoutParams(smallLayoutParams);
        aboutLayout.setGravity(Gravity.CENTER_VERTICAL);
        baseLayout.addView(aboutLayout);

        LinearLayout aboutClickLayout = new LinearLayout(this);
        aboutClickLayout.setOrientation(LinearLayout.HORIZONTAL);
        aboutClickLayout.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT,
                LayoutParams.WRAP_CONTENT));
        aboutClickLayout.setGravity(Gravity.CENTER);
        aboutLayout.addView(aboutClickLayout);
        aboutClickLayout.setOnClickListener(this::licenseActivity);

        Button aboutButton = new Button(this);
        aboutButton.setLayoutParams(buttonParams);
        aboutButton.setBackground(ImageUtils.tint(new BitmapDrawable(getResources(),
                ImageUtils.bitmapLoad(getApplicationContext().getResources(), R.drawable.ic_license_button,
                        Math.round(48 * scale), Math.round(48 * scale))), getResources().getColor(R.color.colorDark)));
        aboutButton.setClickable(false);
        aboutClickLayout.addView(aboutButton);

        TextView aboutText = new TextView(this);
        aboutText.setText(R.string.licensetext);
        aboutText.setTextSize(24);
        aboutText.setTextColor(ContextCompat.getColor(getApplicationContext(), R.color.colorDark));
        aboutText.setPadding(64, 64, 64, 64);
        aboutClickLayout.addView(aboutText);
    }

    public void gitLink(View v) {
        Uri uri = Uri.parse(getString(R.string.sourcecodelink));
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }

    public void iconActivity(View v) {
        Intent intent = new Intent(this, IconActivity.class);
        startActivity(intent);
    }

    public void licenseActivity(View v) {
        Intent intent = new Intent(this, LicenseActivity.class);
        startActivity(intent);
    }
}
