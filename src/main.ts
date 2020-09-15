import { SketchContext } from './utils/sketch-context';
import { MenuController, MENU_EVENT } from './components/menu.controller';
import { PanelController } from './components/panel.controller';

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
    menuController.on(MENU_EVENT.MAIN_CLICK, (id: string, target: any) => {
        console.log(id, target);
    });


    return {
        menuController,
    };
}
