import { SketchContext } from "../utils/sketch-context";
import * as framework from '../framework';
import { createButton, createImageView, createBoxSeparator } from './element';
import { PanelController } from "./panel.controller";

const EventEmitter = require('events');

export class MenuController {
    public id: string;
    public view: any;
    private nib: any;
    private emitter = new EventEmitter();
    constructor(private ctx: SketchContext) {
        this.id = `${ctx.documentID}-navi-menu-panel`;
        this.nib = framework.MenuNib();
        this.view = this.nib.getRoot();
        this.view.identifier = this.id;
        this.generateInterface();
    }
    toogle() {
        const index = this.ctx.findView(this.id);
        index === -1 ? this.show() : this.hide();
    }
    show() {
        this.ctx.insertViewAfter(this.view);
    }
    hide() {
        this.ctx.removeView(this.id);
    }
    private generateInterface() {
        const parent = this.nib.headStack;
        const options = [{
            tooltip: '全部',
            id: 'main',
            gravity: 1
        }, {
            tooltip: '颜色',
            id: 'color',
            gravity: 1
        }, {
            tooltip: '文本',
            id: 'text',
            gravity: 1
        }, {
            tooltip: '设置',
            id: 'mask',
            gravity: 3
        }, {
            tooltip: '用户',
            id: 'border',
            gravity: 3
        }];

        parent.addView_inGravity(createBoxSeparator(), 3);
        options.forEach((option, index) => {
            const button = createButton({
                rect: NSMakeRect(0, 0, 40, 40),
                size: NSMakeSize(40, 40),
                tooltip: option.tooltip,
                type: 2,
                iconUrl: this.ctx.NSURL(`icons/${option.id}.png`),
                activeIconUrl: this.ctx.NSURL(`icons/${option.id}-active.png`),
                callAction: () => {
                    this.onClick(option.id, button);
                },
            });
            parent.addView_inGravity(button, option.gravity || 1);
            parent.addView_inGravity(createBoxSeparator(), option.gravity || 1);
        });

    }

    private onClick(id: string, view: any) {
        // console.log(id, view);
        if (id === 'main') {
            this.emitter.emit(MENU_EVENT.MAIN_CLICK, id, view);
        }
    }
    on(event: MENU_EVENT, cb: any){
        this.emitter.on(event, cb);
    }
}

export enum MENU_EVENT {
    'MAIN_CLICK' = 1,
}
// main.click
// tools.click
//

        // toolbar.addView_inGravity(createImageView(NSMakeRect(0, 0, 40, 8), this.ctx.NSURL('icons/transparent.png')), 3);

        // this.nib.buttonMain.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-main.png`);

        // // this.buttonMainChanged = this.buttonMainChanged.bind(this);
        // // this.nib.buttonMain.setCOSJSTargetFunction(this.buttonMainChanged);
        // this.nib.buttonMain.setCOSJSTargetFunction(function(sender: any){
        //     console.log('XXXXXX!!HAHAHAHA');
        // });
