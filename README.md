![CI badge](https://gitlab.com/xphnx/ameixa/badges/master/build.svg)

Icon pack compatible with Trebuchet, Kiss Launcher, Lawnchair Launcher, OpenLauncher, Adw, and many more launchers. A Material Design inspired theme aiming to provide a consistent and minimalistic look to your device. Code forked from [Icecons icon pack](https://github.com/1C3/ICEcons). Only [F-Droid](https://f-droid.org/) hosted apps are supported.

# Contributions are welcome 

For requesting icons or contributing, please use the [Issue Tracker](https://gitlab.com/xphnx/ameixa/issues) or [Merge Requests](https://gitlab.com/xphnx/ameixa/merge_requests)

#### What happens?
  
* [ ] The activityname line is in [appfilter](https://gitlab.com/xphnx/ameixa/blob/master/app/src/main/res/xml/appfilter.xml)
* [ ] The activityname has changed or is not in [appfilter](https://gitlab.com/xphnx/ameixa/blob/master/app/src/main/res/xml/appfilter.xml) --> Use [Turtl](https://f-droid.org/packages/org.xphnx.iconsubmit/) to find out the Activityname line to be included in appfilter.xml

</br>
* [ ] The icon is in the [icons folder](https://gitlab.com/xphnx/ameixa/tree/master/icons)
* [ ] The icon is in the [todo/wip folder](https://gitlab.com/xphnx/ameixa/tree/master/todo/wip)
* [ ] There is no proper icon in todo/wip or icons --> Grab a [template](https://gitlab.com/xphnx/ameixa/tree/master/templates) and draw a new icon. (More [info](https://gitlab.com/xphnx/twelf_cm12_theme/wikis/home))

</br>
* [ ] The icon file name and the drawable string in the activityname line doesn't match --> Fix activityname


#### What to do?  (You have 4 options:)

1. Write a new activityname in [Issue Tracker](https://gitlab.com/xphnx/ameixa/issues)
2. Attach the new icon (.svg) in [Issue Tracker](https://gitlab.com/xphnx/ameixa/issues)
3. [MR](https://gitlab.com/xphnx/ameixa/merge_requests) activityname lines into appfilter.xml and/or icon files (.svg) into todo/wip
4. [MR](https://gitlab.com/xphnx/ameixa/merge_requests) activityname and/or icon data (.pngs and xml) after running the script [process_wipsvg.sh](https://gitlab.com/xphnx/ameixa/blob/master/process_wipsvg.sh)

# Screenshots

![screenshot1-thumb](/uploads/c1b689614b683cff658c3d8245ef6cea/screenshot1-thumb.jpg)
![screenshot2-thumb](/uploads/833855214502447743662f1e010db19e/screenshot2-thumb.jpg)


<!--<img src="https://gitlab.com/xphnx/twelf_cm12_theme/uploads/97c6faf3cad4619e8079327a5e3d3ac4/Screenshot_2015-05-23-07-53-03.png" alt="with a dark background" width="300" />
<img src="https://gitlab.com/xphnx/ameixa/uploads/6a11ca228921b18225e700f6d37fcbe8/photo5463050469409663049.jpg" alt="with a dark background" width="300" />

 <img src="https://gitlab.com/xphnx/twelf_cm12_theme/uploads/b0ef81d60e8f4470e41cfec54c4a85b0/Screenshot_2015-05-23-21-03-30.png" alt="into apex launcher" width="300" />

<img src="https://gitlab.com/xphnx/twelf_cm12_theme/uploads/081953c26fe1f8d30276f1d16bb0f672/Screenshot_2015-05-22-10-51-04.png" alt="light background" width="300" />
<img src="https://gitlab.com/xphnx/twelf_cm12_theme/uploads/cec2077cb5bb09008b98d7c8681af67c/Screenshot_2015-05-22-23-47-06.png" alt="apps settings" width="300" />

<img src="https://gitlab.com/xphnx/twelf_cm12_theme/uploads/27787db387074995a36f18c262f4abba/Screenshot_2015-06-09-22-21-20.png" alt="share feneec" width="300" />
<img src="https://gitlab.com/xphnx/twelf_cm12_theme/uploads/a49b1be4708a70c2e3c554342ba21edb/Screenshot_2015-05-22-23-55-18.png" alt="inside afw++" width="300" />
-->

# Installation
<a href="https://f-droid.org/app/org.xphnx.ameixa">
    <img src="https://f-droid.org/badge/get-it-on.png"
    alt="Get it on F-Droid" height="80">
</a>
<a href="https://gitlab.com/xphnx/ameixa/-/jobs/86232495/artifacts/file/app/build/outputs/apk/debug/app-debug.apk">
    <img src="https://gitlab.com/xphnx/ameixa/uploads/6d80e2e22d2fcbfd8ed320e58f4705e1/apk.png"
    alt="Download debug apk" height="80">
</a>

# License

<img src="https://gnu.org/graphics/gplv3-127x51.png" />

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.html) and other libre or open licenses for the artwork (see [CREDITS](https://gitlab.com/xphnx/ameixa/blob/master/CREDITS.md) for more details)
