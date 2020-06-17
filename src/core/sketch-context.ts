
const sketchContextInstances: SketchContext[] = [];

/** 对context上下文进行一些封装 */
export class SketchContext {
    public document: any;
    public documentID: string;
    public version: string;
    constructor(private context: any) {
        this.document = context.document || context.actionContext.document || (MSDocument as any).currentDocument();
        this.documentID = this.document.documentData().objectID();
        this.version = new String(context.plugin.version()).toString();
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

    /** 从缓存里查找是否有可复用的上下文 */
    static getOrCreate(context: any){
        const document = context.document || context.actionContext.document || (MSDocument as any).currentDocument();
        const documentID = document.documentData().objectID();
        for(let i = 0; i < sketchContextInstances.length; i++) {
            if (sketchContextInstances[i].documentID === documentID) {
                return sketchContextInstances[i];
            }
        }
        const sketchContext = new SketchContext(context);
        sketchContextInstances.push(sketchContext);
        return sketchContext;
    }
}
