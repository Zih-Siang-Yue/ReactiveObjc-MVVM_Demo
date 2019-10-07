# ReactiveObjc-MVVM_Demo

如果在build code時發生以下error
* error: Unable to resolve build file: XCBCore.BuildFile *

請按照以下步驟處理

Short version:
1. Shut down all but one workspaces
2. exit XCode and reopen XCode
3. XCode > Product > Clean Build Folder


Long version:
1.Shut down all but one workspace
2. XCode > Preferences > Locations > Derived Data > goto directory ~/Library/Developer/Xcode/DerivedData
3. Clear out subdirectories from DerivedData
4. exit XCode and reopen XCode
5. XCode > Product > Clean Build Folder