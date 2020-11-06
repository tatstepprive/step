#!/bin/bash

 gsettings set com.canonical.Unity.Launcher favorites
  "$(gsettings get com.canonical.Unity.Launcher favorites |
     sed "s|]|,'application://sublime_text.desktop'&|")"
