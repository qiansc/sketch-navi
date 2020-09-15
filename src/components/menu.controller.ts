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
        const threadDictionary = NSThread.mainThread().threadDictionary();
        if (threadDictionary[this.id]) {
            this.nib = threadDictionary[this.id];
            this.view = this.nib.getRoot();
        } else {
            this.nib = framework.MenuNib();
            threadDictionary[this.id] = this.nib;
            this.view = this.nib.getRoot();
            this.view.identifier = this.id;
            this.initInterface();
        }


        const index = this.ctx.findView(this.id);


        // const index = this.ctx.findView(this.id);
        if (index === -1) {
            // this.nib = framework.MenuNib();
            // console.log(this.nib.getOwner().hidden);
            // this.view = this.nib.getRoot();
            // this.view.identifier = this.id;

            this.ctx.insertAfterViewCanvas(this.view);
        } else {
            this.ctx.removeView(this.id);
        }
    }
    toogle() {
        this.view.hidden = !this.view.hidden;
        this.ctx.stageView.adjustSubviews();
    }
    private initInterface() {
        const toolbar = this.nib.headStack;
        const Logo = createImageView(NSMakeRect(0, 0, 40, 30), this.ctx.NSURL('icons/main.png'), NSMakeSize(40, 40))
        toolbar.addView_inGravity(Logo, 1);

        for(var i = 0; i < 3; i++) {

            const button = createButton({
                rect: NSMakeRect(0, 0, 40, 40),
                size: NSMakeSize(40, 40),
                tooltip: '上传画板' + i,
                type: 2,
                iconUrl: this.ctx.NSURL('icons/color.png'),
                activeIconUrl: this.ctx.NSURL('icons/color-active.png'),
                callAction: () => console.log('click'),
            });
            toolbar.addView_inGravity(createBoxSeparator(), 1)
            toolbar.addView_inGravity(button,  1);
        }
        for(var i = 0; i < 3; i++) {

            const button = createButton({
                rect: NSMakeRect(0, 0, 40, 40),
                size: NSMakeSize(40, 40),
                tooltip: '上传画板' + (i+10),
                type: 2,
                iconUrl: this.ctx.NSURL('icons/text.png'),
                activeIconUrl: this.ctx.NSURL('icons/text-active.png'),
                callAction: () => console.log('click'),
            });
            toolbar.addView_inGravity(createBoxSeparator(), 3)
            toolbar.addView_inGravity(button,  3);
        }

        // toolbar.addView_inGravity(createImageView(NSMakeRect(0, 0, 40, 8), this.ctx.NSURL('icons/transparent.png')), 3);

        // this.nib.buttonMain.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-main.png`);

        // // this.buttonMainChanged = this.buttonMainChanged.bind(this);
        // // this.nib.buttonMain.setCOSJSTargetFunction(this.buttonMainChanged);
        // this.nib.buttonMain.setCOSJSTargetFunction(function(sender: any){
        //     console.log('XXXXXX!!HAHAHAHA');
        // });
    }

}


