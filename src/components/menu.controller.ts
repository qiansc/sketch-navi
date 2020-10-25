import { SketchContext } from "../utils/sketch-context";
import * as framework from '../framework';
import { splitViewItemDisableRezise } from "../utils/resize-delegate";
const MochaJSDelegate = require('mocha-js-delegate');

const EventEmitter = require('events');
/** XXXXX */
export class MenuController {
    private NSController: any; //NSController 实例指针
    public view: any; // view实例指针
    private delegate: any;
    private emitter = new EventEmitter();
    constructor(private ctx: SketchContext) {
        const NSMenu = framework.framework.getClass('Menu');
        this.NSController = NSMenu.generateWithDocumentId(ctx.documentId);
        this.NSController.updateLimitWidth();
        this.view = this.NSController.view();
        this.delegate = new MochaJSDelegate({
            "viewWillLayoutSize:": (option: any) => {
                this.emitter.emit(MENU_EVENT.WIIL_LAYOUT);
                splitViewItemDisableRezise(this.ctx.stageView, this.view, option.limitWidth);
            },
            "onButtonClick:": ({view, option}: any) => {
                try {
                    this.emitter.emit(MENU_EVENT[`OPEN_${option.type}` as any], option, view);
                }
                catch(e) {
                    console.log(e);
                }
            },
        }).getClassInstance();
    }
    // 切换是否显示
    toogle() {
        const index = this.ctx.findView(this.view.identifier());
        index === -1 ? this.show() : this.hide();
    }
    show() {
        this.ctx.insertViewAfter(this.view);
        this.NSController.updateLimitWidth();
        this.NSController.delegate = this.delegate;
    }
    hide() {

        this.setMainButtonState(0);
        this.ctx.removeView(this.view.identifier());
        // 取消delegate
        this.NSController.delegate = null;
        this.emitter.emit(MENU_EVENT.CLOSE_MAIN);
    }

    on(event: MENU_EVENT, cb: any){
        this.emitter.on(event, cb);
    }

    public setMainButtonState(state: number) {
        this.NSController.mainButton().setState(state);
    }
}

export enum MENU_EVENT {
    'CLOSE_MAIN' = 0,
    'WIIL_LAYOUT' = 10,
    'OPEN_MAIN' = 'OPEN_MAIN',
    'OPEN_PANEL' = 'OPEN_PANEL',
    'OPEN_WINDOW' = 'OPEN_WINDOW',

}
export interface MenuOption {
    name: string;
    id: string;
    gravity: 1 | 2 | 3;
    type: 'MAIN' | 'PANEL' | 'WINDOW';
}

// this.nib.buttonMain.image = NSImage.alloc().initByReferencingFile(`${this.ctx.resourcesPath()}/icons/icon-main.png`);
