import { NSView } from "./element/ns-view";

export class StageView {
    constructor(private documentID: string, private stageView: any) {

    }
    /** 插入view到指定位置 */
    public insertView(id: string, view: NSView) {
        const vid = this.documentID ? id + '-' + this.documentID + '-nsview' : id + '-nsview';
        /** 这个identifier赋值是这样的，可是其实际是方法，使用时候identifier() */
        view.identifier = vid;
        const views = this.stageView.subviews();
        const finalViews = [];
        let pushedWebView = false;
        for (let i = 0; i < views.count(); i++) {
            finalViews.push(views[i]);
            if (!pushedWebView && ''.concat(views[i].identifier()) === 'view_canvas') {
                finalViews.push(view);
                pushedWebView = true;
            }
        }
        NSUserDefaults.standardUserDefaults().setObject_forKey('true', vid);
        this.stageView.subviews = finalViews;
        this.stageView.adjustSubviews();

        const threadDictionary = NSThread.mainThread().threadDictionary();
        threadDictionary[vid] = view;
        COScript.currentCOScript().setShouldKeepAround(true);

    }

    getView<T extends NSView>(id: string): T | undefined {
        const vid = this.documentID ? id + '-' + this.documentID + '-nsview' : id + '-nsview';
        const threadDictionary = NSThread.mainThread().threadDictionary();
        const view = threadDictionary[vid];
        if (view) {
            return view;
        } else {
            return;
        }
    }

    /** 移除view */
    public removeView(id: string, view: NSView) {
        const vid = this.documentID ? id + '-' + this.documentID + '-nsview' : id + '-nsview';
        const views = this.stageView.subviews();
        const finalViews = [];
        for (let i = 0; i < views.count(); i++) {
            if (''.concat(views[i].identifier()) !== vid) {
                finalViews.push(views[i]);
            }
        }
        NSUserDefaults.standardUserDefaults().setObject_forKey(nil, vid);
        this.stageView.subviews = finalViews;
        this.stageView.adjustSubviews();

    }

    public addView(id: string, view: NSView) {
        const threadDictionary = NSThread.mainThread().threadDictionary();
        threadDictionary[id] = view;
        COScript.currentCOScript().setShouldKeepAround(true);
    }

    /** 移除相关子组件，待优化 */
    public shutdownView(id: string){
        const prefix = this.documentID ? id + '-' + this.documentID : id;
        const threadDictionary = NSThread.mainThread().threadDictionary();
        //  BrowserManage.empty()
        const prefixRegExp = new RegExp(`${prefix}*`);
        const webViewPrefixRegExp = new RegExp(`${prefix}-webview*`);

        for (const key in threadDictionary) {
          if (prefixRegExp.test(key)) {
            if (webViewPrefixRegExp.test(key)) {
              threadDictionary[key].close();
            }
            threadDictionary.removeObjectForKey(key);
          }
        }

        // clear WindowResizeNotification
        this.removeObserverWindowResizeNotification();
        COScript.currentCOScript().setShouldKeepAround(false);
    }

    /** 移除窗口监听 */
    private removeObserverWindowResizeNotification() {
        const delegateInstance = NSThread.mainThread().threadDictionary()[`window-move-instance-${this.documentID}`];
        if (delegateInstance) {
          NSNotificationCenter.defaultCenter().removeObserver_name_object(delegateInstance, NSWindowDidResizeNotification, nil);
          removeThreadDictForKey(`window-move-instance-${this.documentID}`);
          removeThreadDictForKey(`window-move-selector-${this.documentID}`);
        }
    }
}

function removeThreadDictForKey(key: any) {
    if (NSThread.mainThread().threadDictionary()[key]) NSThread.mainThread().threadDictionary().removeObjectForKey(key);
}
