import { SketchContext } from './utils/sketch-context';
import { MenuController, MENU_EVENT, MenuOption } from './components/menu.controller';
import { PanelController, PANEL_EVENT } from './components/panel.controller';
import { framework } from './framework';
import { getSpecs } from './spec-data';
const MochaJSDelegate = require('mocha-js-delegate');
const NVSWITCH = true;
const NVApp = framework.getClass('NVApp');

export function onStart(context: any) {
    COScript.currentCOScript().setShouldKeepAround(true);
    if (NVSWITCH) {
        NVApp.currentApp().toggle();
        return;
    }

    if(!SketchContext.hasDocument(context)) {
        return;
    }


    const ctx = new SketchContext(context);
    const threadDictionary = NSThread.mainThread().threadDictionary();

    // 从内存中恢复 因为每次插件调用onStart都是重新执行
    let runtime: Runtime = threadDictionary[`${ctx.documentId}-navi-runtime`];

    if (!runtime) {
        // 创建并写入内存
        runtime = threadDictionary[`${ctx.documentId}-navi-runtime`] = getRuntime(ctx);
    }

    runtime.menuController.toogle();

}
export function onOpenDocument(){
    COScript.currentCOScript().setShouldKeepAround(true);
    if (NVSWITCH) {
        const app = NVApp.prepareInit();
        app.dataSource = new MochaJSDelegate({
            'updateSpec': () => {
                const path =  app.bundlePath();
                app.specs = getSpecs(path.substring(0, path.indexOf('/_webpack_resources')));
            },
        }).getClassInstance();
    }
}

interface Runtime {
    menuController: MenuController;
    panelController: PanelController;
}

function getRuntime(ctx: SketchContext) {
    const menuController = new MenuController(ctx);
    const panelController = new PanelController(ctx);

    // 下面开始把不同controller的事件和处理过程串联起来

    menuController.on(MENU_EVENT.CLOSE_MAIN, (option: MenuOption, target: any) => {
        panelController.hide();
    });

    menuController.on(MENU_EVENT.OPEN_MAIN, (option: MenuOption, target: any) => {
        target.state() ? panelController.show() : panelController.hide();
    });

    menuController.on(MENU_EVENT.OPEN_PANEL, (option: MenuOption, target: any) => {
        // 全部按钮点击时展开面板
        // target.state() ? panelController.show() : panelController.hide();
    });

    menuController.on(MENU_EVENT.WIIL_LAYOUT, (option: MenuOption, target: any) => {
        // 避免Menu rezise导致panel大小auto resize
        panelController.lockSize();
    });

    panelController.on(PANEL_EVENT.CLOSE_WINDOW, () => menuController.setMainButtonState(0));
    panelController.on(PANEL_EVENT.SHOW_PANEL, () => menuController.setMainButtonState(1));

    // panelController.on(PANEL_EVENT.COLOR_CHANGE, (colorCode: string) => changeColor(colorCode));


    return {
        menuController,
        panelController,
    };
}

export function onSelectionChanged(context: any) {

    // COScript.currentCOScript().setShouldKeepAround(true);
    if (NVSWITCH) {
        NVApp.currentApp().selectionChange();
        return;
    }
    // var documentId = context.actionContext.document.hash().toString();
    // const threadDictionary = NSThread.mainThread().threadDictionary();
}

