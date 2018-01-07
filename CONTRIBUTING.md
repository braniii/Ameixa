#FAQ
#### Is there any template for drawing icons?
- Yes, you have one for each color of the palette. You just have to worry about the design of the logo and its proportions. Take a look at the [wiki](https://gitlab.com/xphnx/twelf_cm12_theme/wikis/home)


#### Is there any guidelines to follow drawing the icons?
- It is convenient to visit the [Google Material Design website](http://www.google.com/design/spec/style/icons.html). The templates include most of the items, so you will not have to worry about them, but this site provides  much interesting information you should follow when designing.


#### I had a themed icon, but a recent update of the app reverts it to the original one
- Probably the upstream changes the activity name into androidmanifest.xml. You can compare the activityname using [Turtl](https://f-droid.org/repository/browse/?fdid=org.xphnx.iconsubmit) with the code of [appfilter](). If the activityname have changed in fact, then you can try to do a MR with a [patch](https://gitlab.com/xphnx/twelf_cm12_theme/wikis/home#add-activities-to-appfilterxml), or request for a fix trough [Issue tracker](https://gitlab.com/xphnx/twelf_cm12_theme/issues)


#### I see the icon of an app in [its folders](https://gitlab.com/xphnx/twelf_cm12_theme/tree/master/theme/src/main/assets/icons/res) but it's not working in the theme
- Probably there is an error into the [appfilter.xml](https://gitlab.com/xphnx/twelf_cm12_theme/blob/master/theme/src/main/assets/icons/res/xml/appfilter.xml).
     1. Look if ```drawable="iconname" />``` match the icon name of the png into the folders
     2. Look if the [activity name](https://gitlab.com/xphnx/twelf_cm12_theme/wikis/home#add-activities-to-appfilterxml) is right (You can use Turtl). 
     3. Feel free to open a MR with a patch or [request a fix](https://gitlab.com/xphnx/twelf_cm12_theme/issues)


#### How can I build the app by myself?
-  You have this options:
     1. Gitlab Continous Integration.  The file .gitlab-ci.yml is included yet, enable a shared runner, download the output from Builds. [Gitlab CI Quick Start](http://docs.gitlab.com/ce/ci/quick_start/README.html) (Unsigned apk)
     2. Android Studio (GUI. Builds and signs) [Official download](https://developer.android.com/sdk/index.html) / [PPA by Paolo Rotolo](https://paolorotolo.github.io/android-studio/) (works on Debian/Ubuntu and derivatives). 
     3. Graddle (command line and gui [Official userguide](https://docs.gradle.org/current/userguide/userguide.html)
     4. The Graddle wrapper (scritps, Gradle will be automatically downloaded and used to run the build) [Gradle wrapper userguide](https://docs.gradle.org/current/userguide/gradle_wrapper.html) (Gitlab CI uses this)
     4. Fdroid server [Official manual](https://f-droid.org/manual/fdroid.html)


# How to add an icon
**Steps**: 
1. Draw a white icon on its layer of the [**SVG template**](https://gitlab.com/xphnx/twelf_cm12_theme/tree/master/svgs/svg_templates_twelf), 
2. Put your svg icon into the [**SVG wip folder**](https://gitlab.com/xphnx/twelf_cm12_theme/tree/master/svgs/wip), 
3. Add the activity of the app to [appfilter.xml](https://gitlab.com/xphnx/twelf_cm12_theme/blob/master/theme/src/main/assets/icons/res/xml/appfilter.xml) and add the icon's license to the [LICENSE](https://gitlab.com/xphnx/twelf_cm12_theme/blob/master/LICENSE.md) file.
4. (Optional) Run the script proccess_wipsvg.sh. (It generates the proper pngs and move the svg from wip to depot folder.)

**Breaf instructions**: A template file contains three layers (to see them, select Layer - Layers from the menu; to toggle layer visibility, use the eye-like icons near the layer names). The bottom layer contains the background of the icon. It has proper color, shadow, shade and tint. Do not modify those.

The top layer (hints) shows the keyline shapes, the regions that define the size of your icon. In short, a mostly square icon must fit into a square one (black lines). A horizontal rectangle, in the horizontal rectangle (blue lines). A vertical rectangle icon, into the vertical rectangle (green lines) and the mostly round one should mostly fit in the larger square-without-the-corners that they form. Most part of your icon should fit into one or several of those rectangles. Note that small items can extend beyond this area. For more information on this, please refer to the section ["Proportions"](https://gitlab.com/xphnx/twelf_cm12_theme/wikis/home#proportions) below and to the [Google's guide](http://www.google.com/design/spec/style/icons.html#icons-system-icons).

The icon layer is the most interesting one. This is the layer you should draw your icon on. It already contains an indication, please delete it and draw the desired logo in white (#ffffffff) instead of it.

### Add Activities to appfilter.xml


You can use [Turtle](https://f-droid.org/repository/browse/?fdid=org.xphnx.iconsubmit) to obtain the code. Note Turtl sets the iconname as a string (related to the activityname). You have to change the string inside: ``` drawable="xxxxxxxxxx" />``` and make sure it is identical to the .svg you put into the svgs/wip folder.

### Proportions

![style_logos_product_grid_shapes_vert_rectangle](https://gitlab.com/xphnx/twelf_cm12_theme/uploads/04e86f2f60dd3b29b9c013af40465b8a/style_logos_product_grid_shapes_vert_rectangle.png)![style_logos_product_grid_shapes_hori_rectangle](https://gitlab.com/xphnx/twelf_cm12_theme/uploads/0755668fec705d1446ee30e82b02db36/style_logos_product_grid_shapes_hori_rectangle.png)![style_logos_product_grid_shapes_square](https://gitlab.com/xphnx/twelf_cm12_theme/uploads/8f763839988c14c083d336841ab13d34/style_logos_product_grid_shapes_square.png)![style_logos_product_grid_shapes_circle](https://gitlab.com/xphnx/twelf_cm12_theme/uploads/f4acad231a240b1122684f127c87584f/style_logos_product_grid_shapes_circle.png)

### Resolutions

|RESOLUTION| PX      | DPI |
| :-----: |:-------:| :---:|
| MDPI    | 48x48   | 120 |
| HDPI    | 72x72   | 240 |
| XHDPI   | 96x96   | 320 |
| XXHDPI  | 144x144 | 480 |
| XXXHDPI | 192x192 | 640 |

## More info 
**Please read this carefully for a deeper understanding:**

* [Colors material design](http://www.google.com/design/spec/style/color.html) 

* [Material Design Product Icons](http://www.google.com/design/spec/style/icons.html#icons-product-icons)

* [Material Design System Icons](http://www.google.com/design/spec/style/icons.html#icons-system-icons)

### Add Material Color Palette to Inkscape

[Material Design Color Palette for Inkscape] (https://github.com/MaTriXy/Material-Design-Color-Palette-for-Inkscape)

# Creating a Boot Animation
[See this link](https://github.com/cyngn/android_packages_themes_Template#special-creating-a-boot-animation)