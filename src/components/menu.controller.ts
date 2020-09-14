import { SketchContext } from "../utils/sketch-context";
import * as framework from '../framework';
import { createButton, createImageView, createBoxSeparator } from './element';

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
        let NSTOP = 1;
        const toolbar = this.nib.headStack;
        const toolbar0 = NSStackView.alloc().initWithFrame(NSMakeRect(0, 0, 40, 400))
        // toolbar.setSpacing(8)
        // toolbar.setFlipped(true)
        // toolbar.setBackgroundColor(NSColor.windowBackgroundColor())

        // toolbar.orientation = 1
        console.log('toolbar', toolbar.alignment());
        console.log('toolbar0', toolbar0.alignment());
        // toolbar.addView_inGravity(createImageView(NSMakeRect(0, 0, 40, 22), this.ctx.NSURL('icons/transparent.png'), NSMakeSize(40, 22)), 1);
        const Logo = createImageView(NSMakeRect(0, 0, 40, 30), this.ctx.NSURL('icons/icon-bold.png'), NSMakeSize(40, 28))
        toolbar.addView_inGravity(Logo, 1);

        for(var i = 0; i < 3; i++) {

            const button = createButton({
                rect: NSMakeRect(0, 0, 40, 40),
                size: NSMakeSize(24, 24),
                tooltip: '上传画板' + i,
                type: 2,
                iconUrl: this.ctx.NSURL('icons/icon-main.png'),
                activeIconUrl: this.ctx.NSURL('icons/icon-text.png'),
                callAction: () => console.log('click'),
            });
            toolbar.addView_inGravity(createBoxSeparator(), 1)
            toolbar.addView_inGravity(button,  1);
        }
        NSTOP = 3;
        for(var i = 0; i < 3; i++) {

            const button = createButton({
                rect: NSMakeRect(0, 0, 40, 40),
                size: NSMakeSize(24, 24),
                tooltip: '上传画板' + (i+10),
                type: 2,
                iconUrl: this.ctx.NSURL('icons/icon-main.png'),
                activeIconUrl: this.ctx.NSURL('icons/icon-text.png'),
                callAction: () => console.log('click'),
            });
            toolbar.addView_inGravity(createBoxSeparator(), 3)
            toolbar.addView_inGravity(button,  3);
        }

        // toolbar.addView_inGravity(createImageView(NSMakeRect(0, 0, 40, 8), this.ctx.NSURL('icons/transparent.png')), 3);
        // this.view = toolbar;
        // this.ctx.insertAfterViewCanvas(toolbar);
        //toolbar.addView_inGravity(createImageView(NSMakeRect(0, 0, 40, 8), this.ctx.NSURL('icons/transparent.png')), 3);

        // //const button = NSButtonCell.alloc().initWithFrame(NSMakeRect(0, 0, 40, 40));
        // console.log(toolbar);

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


