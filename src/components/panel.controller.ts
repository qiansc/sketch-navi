import { SketchContext } from "../utils/sketch-context";
import * as framework from '../framework';
import { createWindow } from './element';
import { getSubviewById } from "../utils/view-utils";
import { splitViewItemLimitRezise } from "../utils/resize-delegate";
import { SpecData } from '../spec-data';
const MochaJSDelegate = require('mocha-js-delegate');
const EventEmitter = require('events');

/** 插件面板区 */
export class PanelController {
    public view: any;
    private window: any;
    private emitter = new EventEmitter();
    private NSController: any;
    private floatButton: any;
    private minWidth: number;
    public colorController: any; // 临时对象
    public sectionInfo: any;
    constructor(private ctx: SketchContext) {
        const NSPanel = framework.framework.getClass('Panel');
        this.NSController = NSPanel.generateWithDocumentId(ctx.documentId);
        this.view = this.NSController.view();
        this.floatButton = getSubviewById(this.view, 'floatButton');
        this.floatButton.setCOSJSTargetFunction(() => {
            this.hide();
            this.show();
        });
        this.updateSpecs();
        this.minWidth = this.view.frame().size.width;
        // 以下是颜色测试代码
        // const section = getSubviewById(this.view, 'section');
        // this.sectionInfo = getSubviewById(this.view, 'sectionInfo');
        // const colorp = getSubviewById(section, 'colorp');
        // this.colorController = colorp.colorPanelController();
        // this.colorController.delegate = new MochaJSDelegate({
        //     'colorChange:': (colorCode: string) => {
        //         this.sectionInfo.setTitle(colorCode);
        //         this.emitter.emit(PANEL_EVENT.COLOR_CHANGE, colorCode);
        //     }
        // }).getClassInstance();
        // 颜色测试代码结束
    }
    show() {
        // this.NSController.layoutSection();
        this.floatButton.state() === 0 ? this.showWindow() : this.showSlider();
        this.emitter.emit(PANEL_EVENT.SHOW_PANEL);
    }
    hide() {
        if (this.window) {
            this.NSController.delegate = null;
            this.window.setContentView(null);
            this.window.close();
        }
        this.ctx.removeView(this.view.identifier());
    }
    public selectionChange() {
        this.NSController.selectionChange();
    }
    private showSlider() {
        if (this.ctx.findView(this.view.identifier()) === -1) {
            // 插入到目录左侧
            this.ctx.insertViewBefore(this.view, `${this.ctx.documentId}-navi-menu-panel`);
            this.floatButton.setState(1);
            // 下面这个代理方法主要实现限制menu宽度，策略1限制最小宽度，策略2限制在lockSize时间段内，不发生size变化
            this.NSController.delegate = new MochaJSDelegate({
                'viewWillLayoutSize:': (newSize: string) => {
                    if (new Date().getTime() - this.lastLockTime > 0) {
                        this.emitter.emit(PANEL_EVENT.WIIL_LAYOUT);
                        splitViewItemLimitRezise(this.ctx.stageView, this.view, this.minWidth);
                        this.lockWidth = this.view.frame().size.width;
                    } else if(this.lockWidth) {
                        splitViewItemLimitRezise(this.ctx.stageView, this.view, this.lockWidth, this.lockWidth);
                    }
                }
            }).getClassInstance();

        }
    }
    private showWindow() {
        const size = this.view.frame().size;
        this.NSController.delegate = null;
        const window = createWindow({
            title: "无极设计工具",
            frame: NSMakeRect(0, 0, size.width, size.height)
        });
        window.setDelegate(new MochaJSDelegate({
            'windowWillClose:': () => {
                this.emitter.emit(PANEL_EVENT.CLOSE_WINDOW);
                return NSApp.stopModal();
            }
        }).getClassInstance());
        window.setContentView(this.view);
        window.setAutorecalculatesKeyViewLoop(true);
        this.window = window;
    }

    private lastLockTime: number = 0; // 锁定时间
    private lockWidth: number = 0; // 锁定宽度
        // 锁定大小以避免重绘
    public lockSize() {
        this.lastLockTime = new Date().getTime() + 1000; // 锁定1000ms
    }
    on(event: PANEL_EVENT, cb: any){
        this.emitter.on(event, cb);
    }
    private updateSpecs() {
        const specData = new SpecData(this.ctx.resourcesPath());
        const textSpec = specData.getTextSpec();
        console.log(textSpec);

        this.NSController.updateSpec({
            Color: specData.getColorSpec(),
            Line: [{
                weight: '1', text: '1', specCode: 'F_L_X01', desc: '粗分割线高度', dim: ['通栏模版'],
            }, {
                weight: '2', text: '2', specCode: 'F_L_X02', desc: '细分割线高度', dim: ['非通栏分割线'],
            }, {
                weight: '6', text: '6', specCode: 'F_L_X03', desc: '细分割线高度', dim: ['通栏分割线'],
            }]
        });
    }
}

export enum PANEL_EVENT {
    'CLOSE_WINDOW' = 1,
    'WIIL_LAYOUT' = 10,
    'SHOW_PANEL' = 11,
    'COLOR_CHANGE' = 21,
}
