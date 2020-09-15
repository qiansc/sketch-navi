/** 对context上下文进行一些封装 */
export class SketchContext {
    public document: any;
    public documentID: string;
    public version: string;
    public plugin: Plugin;
    public contentView: any;
    public stageView: any;
    constructor(private context: any) {
        this.document = context.document || (context.actionContext && context.actionContext.document) || (MSDocument as any).currentDocument();
        this.documentID = this.document.documentData().objectID();
        this.version = new String(context.plugin.version()).toString();
        this.plugin = context.plugin;
        this.contentView = this.context.document.documentWindow().contentView();
        this.stageView = this.contentView.subviews().objectAtIndex(0);
    }

    /** 插件目录 */
    public pluginFolderPath() {
        const split = this.context.scriptPath.split('/')
        split.splice(-3, 3)
        return split.join('/')
    }

    /** 资源目录 */
    public resourcesPath() {
        return `${this.pluginFolderPath()}/Contents/Resources`;
    }

    /** NS资源定位符 */
    public NSURL(path?: string) {
        let url = this.context.plugin.url()
        .URLByAppendingPathComponent('Contents')
        .URLByAppendingPathComponent('Resources');
        return path? url.URLByAppendingPathComponent(path) : url;
    }

    /** 从缓存里查找是否有可复用的上下文 */
    // static getOrCreate(context: any){
    //     const document = context.document || context.actionContext.document || (MSDocument as any).currentDocument();
    //     const documentID = document.documentData().objectID();
    //     for(let i = 0; i < sketchContextInstances.length; i++) {
    //         if (sketchContextInstances[i].documentID === documentID) {
    //             return sketchContextInstances[i];
    //         }
    //     }
    //     const sketchContext = new SketchContext(context);
    //     sketchContextInstances.push(sketchContext);
    //     return sketchContext;
    // }

    public insertAfterViewCanvas(view: any) {
        const views = this.stageView.subviews();
        const finalViews = [];
        let pushedWebView = false;
        for (let i = 0; i < views.count(); i++) {
            finalViews.push(views[i]);
            if (!pushedWebView && ''.concat(views[i].identifier()) === 'view_canvas') {
                pushedWebView = true;
                finalViews.push(view);
            }
        }
        // NSUserDefaults.standardUserDefaults().setObject_forKey('true', vid);
        this.stageView.subviews = finalViews;
        this.stageView.adjustSubviews();
    }

    public findView(identifier: string) {
        const views = this.stageView.subviews();
        for (let i = 0; i < views.count(); i++) {
            if (''.concat(views[i].identifier()) === identifier) {
                return i;
            }
        }
        return -1;
    }

    public removeView(identifier: string) {
        const finalViews = [];
        const views = this.stageView.subviews();
        for (let i = 0; i < views.count(); i++) {
            if (''.concat(views[i].identifier()) !== identifier) {
                finalViews.push(views[i]);
            }
        }
        this.stageView.subviews = finalViews;
        this.stageView.adjustSubviews();
    }

    public getView(index: number) {
        return this.stageView.subviews()[index];
    }

    public static hasDocument(context: any){
        if(context.document || (context.actionContext && context.actionContext.document) || (MSDocument as any).currentDocument()) {
            return true;
        }
        return false;
    }

}
