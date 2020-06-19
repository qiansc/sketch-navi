export class Panel {
    public view: any;
    constructor(
        /** view唯一标识 */
        public id: string,
        /** 其他view前缀 */
        public prefix: string) {}
    /** 创建view */
    public createView() {
        this.view = NSStackView.alloc().initWithFrame(NSMakeRect(0, 0, 40, 400));

        // threadDictionary[SidePanelIdentifier] = toolbar;
        this.view.identifier = this.id;
        this.view.setSpacing(8);
        this.view.setFlipped(true);
        this.view.setBackgroundColor(NSColor.windowBackgroundColor());
        this.view.orientation = 1
        const threadDictionary = NSThread.mainThread().threadDictionary();
        threadDictionary[this.id] = this.view;
        COScript.currentCOScript().setShouldKeepAround(true);
    }

    /** 设置已经存在的view */
    public setView(view: any) {
        this.view = view;
    }

    /** 插入view到指定位置 */
    public insertTo(stageView: any) {
        const views = stageView.subviews();
        const finalViews = [];
        let pushedWebView = false;
        for (let i = 0; i < views.count(); i++) {
            const view = views[i];
            finalViews.push(view);
            if (!pushedWebView && ''.concat(view.identifier()) === 'view_canvas') {
                finalViews.push(this.view);
                pushedWebView = true;
            }
        }
        NSUserDefaults.standardUserDefaults().setObject_forKey('true', this.id);
        stageView.subviews = finalViews;
        stageView.adjustSubviews();
    }
}

function removeThreadDictForKey(key: any) {
    if (NSThread.mainThread().threadDictionary()[key]) NSThread.mainThread().threadDictionary().removeObjectForKey(key)
}
