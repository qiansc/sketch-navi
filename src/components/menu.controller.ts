import { SketchContext } from "../utils/sketch-context";
import * as framework from '../framework';
import { createButton, createBoxSeparator } from './element';
import { getSubviewById } from "../utils/view-utils";
import { splitViewItemDisableRezise } from "../utils/resize-delegate";
import { NSStackViewGravityBottom } from "sketch";
const MochaJSDelegate = require('mocha-js-delegate');

const EventEmitter = require('events');

export class MenuController {
    public id: string;
    public view: any;
    private emitter = new EventEmitter();
    private buttons: {[index: string]: any} = {};
    private NSController: any;
    private limitWidth: number;
    private delegate: any;
    constructor(private ctx: SketchContext) {
        this.id = `${ctx.documentID}-navi-menu-panel`;
        const NSMenu = framework.framework.getClass('Menu');
        this.NSController = NSMenu.viewControllerFromNIB();
        this.view = this.NSController.view();
        this.view.identifier = this.id ;
        this.limitWidth = this.view.frame().size.width;
        this.delegate = new MochaJSDelegate({
            "viewWillLayoutSize:": (newSize: string) => {
                this.emitter.emit(MENU_EVENT.WIIL_LAYOUT);
                splitViewItemDisableRezise(this.ctx.stageView, this.view, this.limitWidth);
            },
            "onButtonClick:": (button: any) => {
                this.onClick(button);
            },
        }).getClassInstance();
    }
    // 切换是否显示
    toogle() {
        const index = this.ctx.findView(this.id);
        index === -1 ? this.show() : this.hide();
    }
    show() {
        this.ctx.insertViewAfter(this.view);
        this.limitWidth = this.view.frame().size.width;
        this.NSController.delegate = this.delegate;
    }
    hide() {

        this.setMainButtonState(0);

        this.ctx.removeView(this.id);
        // 取消delegate
        this.NSController.delegate = null;
        this.emitter.emit(MENU_EVENT.MAIN_CLOSE);
    }

    private onClick(button: any) {
        try {
            options.forEach(option => {
                if (option.id == button.identifier().toString()) {
                    if (option.event === MENU_EVENT.MAIN_CLICK) {

                    } else if (option.event === MENU_EVENT.BUTTON_CLICK){

                    } else if (option.event === MENU_EVENT.PANEL_CLICK){
                        // 点击普通按钮时 如果总控Main未激活 则模拟激活 打开主面板
                        if (button.state() === 1 && this.NSController.mainButton().state() !== 1) {
                            this.NSController.mainButton().performClick('callAction:');
                        }
                    }
                    this.emitter.emit(option.event, option, button);
                }
            });
        } catch(e) {
            console.log(e);
        }
    }

    on(event: MENU_EVENT, cb: any){
        this.emitter.on(event, cb);
    }

    public setMainButtonState(state: number) {
        this.NSController.mainButton().setState(state);
    }
}

export enum MENU_EVENT {
    'MAIN_CLOSE' = 0,
    'WIIL_LAYOUT' = 10,
    'MAIN_CLICK' = 20,
    'PANEL_CLICK' = 21,
    'BUTTON_CLICK' = 23,

}

export interface MenuOption {
    tooltip: string,
    id: string,
    gravity: 1 | 2 | 3,
    event?: MENU_EVENT
}


const options : MenuOption[] = [{
    tooltip: '全部',
    id: 'main',
    gravity: NSStackViewGravityTop,
    event: MENU_EVENT.MAIN_CLICK
}, {
    tooltip: '颜色',
    id: 'color',
    gravity: NSStackViewGravityTop,
    event: MENU_EVENT.PANEL_CLICK
}, {
    tooltip: '文本',
    id: 'text',
    gravity: NSStackViewGravityTop,
    event: MENU_EVENT.PANEL_CLICK
}, {
    tooltip: '设置',
    id: 'mask',
    gravity: 3,
    event: MENU_EVENT.BUTTON_CLICK
}, {
    tooltip: '用户',
    id: 'border',
    gravity: 3,
    event: MENU_EVENT.BUTTON_CLICK
}];


        // toolbar.addView_inGravity(createImageView(NSMakeRect(0, 0, 40, 8), this.ctx.NSURL('icons/transparent.png')), 3);

        // this.nib.buttonMain.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-main.png`);

        // // this.buttonMainChanged = this.buttonMainChanged.bind(this);
        // // this.nib.buttonMain.setCOSJSTargetFunction(this.buttonMainChanged);
        // this.nib.buttonMain.setCOSJSTargetFunction(function(sender: any){
        //     console.log('XXXXXX!!HAHAHAHA');
        // });
