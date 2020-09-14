import { SketchContext } from "../utils/sketch-context";
import * as framework from '../framework';
import { createButton, createImage } from './element';

export class MenuController {
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
            this.view = this.nib.getRoot();
            this.view.identifier = this.id;
            this.initInterface();
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

        const button = createButton({
            iconUrl: this.ctx.NSURL('icons/icon-main.png'),
            size: 40,
            rect: NSMakeRect(0, 0, 40, 40),
            callAction: () => console.log('click'),
        })
        // //const button = NSButtonCell.alloc().initWithFrame(NSMakeRect(0, 0, 40, 40));
        // console.log(this.nib.headStack);

        this.nib.headStack.addView_inGravity(button, 1);

        // const btn = framework.MenuBtn();
        // this.nib.getRoot().addSubview(btn.getRoot());
        // this.nib.getRoot().adjustSubviews();
        // this.nib.aaa

        // this.nib.buttonMain.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-main.png`);
        // this.nib.buttonColor.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-bold.png`);
        // this.nib.buttonText.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-text.png`);
        // this.nib.buttonLine.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-line.png`);

        // // this.buttonMainChanged = this.buttonMainChanged.bind(this);
        // // this.nib.buttonMain.setCOSJSTargetFunction(this.buttonMainChanged);
        // this.nib.buttonMain.setCOSJSTargetFunction(function(sender: any){
        //     console.log('XXXXXX!!HAHAHAHA');
        // });
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


