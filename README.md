# Zorin-extra-Layouts
A script which allows anyone to easily switch between some of Zorin's Pro/Ultimate Layouts on Core editions (GNOME, not Lite/XFCE)

This script currently covers **all official Zorin 16 Pro Layouts**

> *This includes some extra layouts and tweaks, such as pop-shell for window Tiling*

> ### **NOTE:** I WILL take this down if the Zorin developers should contact me on that, so don't expect this to stay forever

## How To Use
Basic use:
```
bash -c "$(wget https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/morelayoutsinstall.sh -O -)"
```

CLI:
```
git clone --depth=1 https://github.com/TGRush/Zorin-extra-Layouts.git && cd Zorin-extra-layouts

./morelayoutsinstall.sh -h
```

## Contributing:
When contributing (or trying to), make sure that you've tested your changes before you make a pull request, and that you relatively know how to use bash and some command line tools (wget for example, unzip, the gnome-extensions cli tool, etc) and that the change you're trying to pull request actually fits the project 

#### Changes which are considered NOT fitting the project:
- untested extensions
- outdated extensions
- changing dconf where unnecessary
- custom extension downloading (already available through extensions.gnome.org on Firefox/Chromium and alike)
- unrevertible changes

## License:
```
Copyright (c) 2022 Simon "TGRush" Müller

This software is provided 'as-is', without any express or implied warranty. 
In no event will the authors be held liable for any damages arising from the
use of this software.

Permission is granted to anyone to use this software for any purpose, 
including commercial applications, and to alter it and redistribute it freely, 
subject to the following restrictions:

  1. The origin of this software must not be misrepresented; 
  you must not claim that you wrote the original software. 
  If you use this software in a product, an acknowledgment 
  in the product documentation would be appreciated but is not required.

  2. Altered source versions must be plainly marked as such, 
  and must not be misrepresented as being the original software.

  3. This notice may not be removed or altered from any source distribution.
```
