package org.xphnx.ameixa.activities;

import android.os.Bundle;
import android.view.Gravity;
import android.widget.LinearLayout;

import org.xphnx.ameixa.R;
import org.xphnx.ameixa.utils.IntentUtils;
import org.xphnx.ameixa.views.CenterButton;

public class MainActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        createLayout();
    }

    private void createLayout() {
        LinearLayout frameLayout = new LinearLayout(this);
        frameLayout.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));
        frameLayout.setBackgroundColor(getResources().getColor(R.color.colorLight));
        frameLayout.setGravity(Gravity.CENTER);
        setContentView(frameLayout);

        LinearLayout baseLayout = new LinearLayout(this);
        baseLayout.setOrientation(LinearLayout.VERTICAL);
        baseLayout.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.MATCH_PARENT));
        baseLayout.setGravity(Gravity.START);
        frameLayout.addView(baseLayout);

        CenterButton icons = new CenterButton(this);
        icons.setText(R.string.icons);
        icons.setIcon(R.drawable.ic_icons);
        icons.setOnClickListener(v -> IntentUtils.openActivity(this, IconActivity.class));
        baseLayout.addView(icons);

        CenterButton source = new CenterButton(this);
        source.setText(R.string.source);
        source.setIcon(R.drawable.ic_code);
        source.setOnClickListener(v -> IntentUtils.openUrl(this, R.string.url_repository));
        baseLayout.addView(source);

        CenterButton code = new CenterButton(this);
        code.setText(R.string.license);
        code.setIcon(R.drawable.ic_copyright);
        code.setOnClickListener(v -> IntentUtils.openActivity(this, LicenseActivity.class));
        baseLayout.addView(code);
    }
}
