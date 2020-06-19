import { Panel } from "./panel";

export class StageView {
    constructor(private documentID: string, private stageView: any) {

    }
    /** 插入view到指定位置 */
    public insertPanel(panel: Panel) {
        const views = this.stageView.subviews();
        const finalViews = [];
        let pushedWebView = false;
        for (let i = 0; i < views.count(); i++) {
            const view = views[i];
            finalViews.push(view);
            if (!pushedWebView && ''.concat(view.identifier()) === 'view_canvas') {
                finalViews.push(panel.view);
                pushedWebView = true;
            }
        }
        NSUserDefaults.standardUserDefaults().setObject_forKey('true', panel.id);
        this.stageView.subviews = finalViews;
        this.stageView.adjustSubviews();
    }

    removePanel(panel: Panel) {
        const views = this.stageView.subviews();
        const finalViews = [];
        for (let i = 0; i < views.count(); i++) {
            const view = views[i];
            if (''.concat(view.identifier()) !== panel.id) {
                finalViews.push(view);
            }
        }
        NSUserDefaults.standardUserDefaults().setObject_forKey(nil, panel.id);
        this.stageView.subviews = finalViews;
        this.stageView.adjustSubviews();
    }

    public shutdownPanel(panel: Panel){
        const threadDictionary = NSThread.mainThread().threadDictionary();
        //  BrowserManage.empty()
        const prefixRegExp = new RegExp(`${panel.prefix}*`)
        const webViewPrefixRegExp = new RegExp(`${panel.prefix}-webview*`)

        for (const key in threadDictionary) {
          if (prefixRegExp.test(key)) {
            if (webViewPrefixRegExp.test(key)) {
              threadDictionary[key].close()
            }
            threadDictionary.removeObjectForKey(key)
          }
        }

        // clear WindowResizeNotification
        this.removeObserverWindowResizeNotification();
        COScript.currentCOScript().setShouldKeepAround(false);
    }
    private removeObserverWindowResizeNotification() {
        const delegateInstance = NSThread.mainThread().threadDictionary()(`window-move-instance-${this.documentID}`)
        if (delegateInstance) {
          NSNotificationCenter.defaultCenter().removeObserver_name_object(delegateInstance, NSWindowDidResizeNotification, nil)
          removeThreadDictForKey(`window-move-instance-${this.documentID}`)
          removeThreadDictForKey(`window-move-selector-${this.documentID}`)
        }
    }
}

function removeThreadDictForKey(key: any) {
    if (NSThread.mainThread().threadDictionary()[key]) NSThread.mainThread().threadDictionary().removeObjectForKey(key)
}
