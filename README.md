# Resizer for Sketch App + Skala

I've been using Sketch App for a few months now, I really love it. But since I'm working mostly on mobile the lack of compatibility with Skala Preview annoyed me.

If you don't know about Sketch App, [read about it here in french](http://checkthis.com/sketch) or [check the official website](http://www.bohemiancoding.com/sketch/).

Today, [Thibaut Ninove](https://twitter.com/tbnv) pointed out that he had a script that was exporting the Sketch App art boards to the clipboard. Unfortunately, there is a bug in Sketch App that exports them with a border of a random number of pixels (well, it's probably not random but I couldn't figure out the logic). 

Since I love that app so much (and I'm not the only one out there), I created a complement app that fetches the newly exported artboards from SketchApp and that removes the frame so that it can be tried in Skala Preview.

Since I couldn't find how to measure the margin accurately, the app requires the user to set the margin size himself when he changes to an artboard that has a different size.

## How to set up ?

The set up works occurs in two part.

You'll need to download : [Resize.zip](http://cl.ly/MyKh)

### Set up a shortcut to export from SketchApp to the clipboard

Go to the Sketch App Preferences and enable scripting.

Now on the "Plugins" Menu Bar tab, click on Custom Script >> Settings gear >> Open Plugins Folder.

Drag and drop the script (export.jstalk) that is in the archive you downloaded in that folder.

Now when you hit "control+command+C", it will copy your art board to the clipboard.

### Set up the resizer that fetches the clipboard content from SketchApp and that serves it to Skala.

Just open the Resize.app and you should be ready to go.

## Customization

Everything is open-source (except Skala and Sketch App), feel free to customize it.

To change your keyboard shortcut, take a look at the [Bohemian Coding Scripting Documentation](http://bohemiancoding.com/sketch/scripting/)

## Special thanks

Thanks to [Thibaut Ninove](https://twitter.com/tbnv) for the challenge and Yara for the mental support.
