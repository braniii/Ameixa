package org.xphnx.ameixa.activities;

import android.graphics.Rect;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.ScrollView;

import org.xphnx.ameixa.R;
import org.xphnx.ameixa.utils.ImageUtils;
import org.xphnx.ameixa.utils.ScreenUtils;

import java.util.ArrayList;

public class IconActivity extends BaseActivity {
    private final IconAdapter mAdapter = new IconAdapter(R.layout.grid_item);
    private String[] mImages;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.icon_grid);

        mImages = getResources().getStringArray(R.array.icon_pack);

        EditText searchBar = findViewById(R.id.searchBar);
        searchBar.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                mAdapter.clearList();
                if (charSequence.length() == 0) {
                    mAdapter.newLoadAsyncList(() -> {
                        ArrayList<String> imageList = new ArrayList<>(mImages.length);
                        Collections.addAll(imageList, mImages);
                        return imageList;
                    }).execute();
                } else {
                    String searchString = charSequence.toString().toLowerCase();
                    mAdapter.newLoadAsyncList(() -> {
                        ArrayList<String> imageList = new ArrayList<>(mImages.length);
                        for (String s : mImages) {
                            if (s.contains(searchString)) {
                                imageList.add(s);
                            }
                        }
                        return imageList;
                    }).execute();
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {
            }

        });

        GridView gridView = findViewById(R.id.iconGrid);
        gridView.setAdapter(mAdapter);

        // call onTextChanged
        searchBar.setText(null);
    }
}
