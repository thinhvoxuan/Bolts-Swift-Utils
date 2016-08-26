# Bolts-Swift-Utils
Bolts-Swift-Utils

Use Facebook with App. <img src="http://www.doit.ba/img/facebook.jpg" width="200">
- Visit <a href="https://developers.facebook.com/" target="_blank">Facebook Developers</a>
- Click **My Apps**, then select **Add a New App* from the dropdown menu
- Select **iOS** platform and enter a new name for your app
- Follow *Configure your info.plist* to update your App


## Task With FacebookUtils
loginAndFetchProfile is function that could chainning 2 step with open facebook login page and fetch userInformation after that. The result including `accessToken` and `meInfor` (including id, username, ... )
```swift
FacebookUtils.sharedInstance.loginAndFetchProfile(self).continueWith {
            task in
            if task.error != nil {
                if let error = task.error as NSError? {
                    print(error.localizedDescription)
                    return
                }
            } else {
                print("\(task.result?.accessToken)")
                print("\(task.result?.meInfor)")
            }
        }
```
