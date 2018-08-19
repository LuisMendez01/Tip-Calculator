# Pre-work - *Tip Calculator*

**Tip Calculator* is a tip calculator application for iOS.

Submitted by: **Luis Mendez**

Time spent: **40** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.

The following **optional** features are implemented:
* [x] Settings page to change the default tip percentage.
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
* [x] App layout works for all iPhones
* [x] If iPhone is not Iphone X does not show the fifth person to divide money by

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<div style="display: inline-block;">
<img float="left" width="293" height="400" src='https://user-images.githubusercontent.com/16315708/44127002-2797cd1c-a009-11e8-8999-2ea8fd25764d.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img float="left" width="293" height="400" src='https://user-images.githubusercontent.com/16315708/44127110-c3fa41f8-a009-11e8-99c6-b2eb2b0f8817.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img float="right" width="293" height="400" src='https://user-images.githubusercontent.com/16315708/44127144-f97a7a1e-a009-11e8-8d06-2436543b59d0.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
</div>

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Some challenges I encountered while building the app:

1) The segmented control, I wanted to change the border color along with the background and font color of the non-active and active ones. So even though I found out how to do it, the functions I applied did not work because in swift 4 some functions were renamed as well as some attributes and that was hard to apply from the new things to the old things in the program. 

2) Also dealing with navigation bar was a challenge because even though the view for the color background was on top of the navigation bar, the navigation bar would not change to the view color. Besides the color issue, there was also a line at the bottom of the navigation bar, I called it the bottom border but online developers called it the hairline. Getting that to be removed was hard to find out how to do. 

## License

    Copyright [2018] [Luis Mendez]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
