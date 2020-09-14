import { SketchContext } from "../utils/sketch-context";
import * as framework from '../framework';

export class Menu {
    public id: string;
    public view: any;
    private nib: any;
    constructor(private ctx: SketchContext) {
        this.id = `${ctx.documentID}-navi-menu-panel`;
    }
    initView() {
        const index = this.ctx.findView(this.id);
        if (index === -1) {
            this.nib = framework.MenuNib();
            this.initInterface();
            this.view = this.nib.getRoot();
            this.view.identifier = this.id;
            this.ctx.insertAfterViewCanvas(this.view);
            this.view.inLiveResize = false;
            return true;
        } else {
            this.view = this.ctx.getView(index);
            return false;
        }
    }
    toogle() {
        this.view.hidden = !this.view.hidden;
        this.ctx.stageView.adjustSubviews();
    }
    private initInterface() {

        COScript.currentCOScript().setShouldKeepAround(true);
        this.nib.buttonMain.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-main.png`);
        this.nib.buttonColor.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-bold.png`);
        this.nib.buttonText.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-text.png`);
        this.nib.buttonLine.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-line.png`);

        // this.buttonMainChanged = this.buttonMainChanged.bind(this);
        // this.nib.buttonMain.setCOSJSTargetFunction(this.buttonMainChanged);
        this.nib.buttonMain.setCOSJSTargetFunction(function(sender: any){
            console.log('XXXXXX!!HAHAHAHA');
        });
        // this.nib.buttonIcon.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-main.png`);
    }


    // buttonMainChanged() {
    //     console.log('click!!!');
    //     const enabled = this.buttonMainStatus === 1;
    //     this.nib.buttonMain.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-bold.png`);
    //     // this.nib.showPrototypingLinks.enabled = enabled
    //     // this.nib.showArtboardShadow.enabled = enabled
    //     // this.nib.showArtboardName.enabled = enabled
    // }
}
