import { SketchContext } from './utils/sketch-context';
import { MenuController, MENU_EVENT, MenuOption } from './components/menu.controller';
import { PanelController, PANEL_EVENT } from './components/panel.controller';

export function onStart(context: any) {
    if(!SketchContext.hasDocument(context)) {
        return;
    }

    COScript.currentCOScript().setShouldKeepAround(true);

    const ctx = new SketchContext(context);
    const threadDictionary = NSThread.mainThread().threadDictionary();

    // 从内存中恢复 因为每次插件调用onStart都是重新执行
    let runtime: Runtime = threadDictionary[`${ctx.documentID}-navi-runtime`];

    if (!runtime) {
        // 创建并写入内存
        runtime = threadDictionary[`${ctx.documentID}-navi-runtime`] = getRuntime(ctx);
    }

    runtime.menuController.toogle();

}

interface Runtime {
    menuController: MenuController;
}

function getRuntime(ctx: SketchContext) {
    const menuController = new MenuController(ctx);
    const panelController = new PanelController(ctx);

    // 下面开始把不同controller的事件和处理过程串联起来

    menuController.on(MENU_EVENT.MAIN_CLOSE, (option: MenuOption, target: any) => {
        panelController.hide();
    });

    menuController.on(MENU_EVENT.MAIN_CLICK, (option: MenuOption, target: any) => {
        target.state() ? panelController.show() : panelController.hide();
    });

    menuController.on(MENU_EVENT.PANEL_CLICK, (option: MenuOption, target: any) => {
        // 全部按钮点击时展开面板
        // target.state() ? panelController.show() : panelController.hide();
    });

    menuController.on(MENU_EVENT.WIIL_LAYOUT, (option: MenuOption, target: any) => {
        // 避免Menu rezise导致panel大小auto resize
        panelController.lockSize();
    });

    panelController.on(PANEL_EVENT.WINDOW_CLOSE, () => menuController.setMainButtonState(0));
    panelController.on(PANEL_EVENT.PANEL_SHOW, () => menuController.setMainButtonState(1));


    return {
        menuController,
    };
}
