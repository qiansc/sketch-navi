import { SketchContext } from './utils/sketch-context';
import { MenuController } from './components/menu.controller';

export function onStart(context: any) {
    if(!SketchContext.hasDocument(context)) {
        return;
    }
    COScript.currentCOScript().setShouldKeepAround(true);

    const ctx = new SketchContext(context);
    const menuController = new MenuController(ctx);

    menuController.initView();
}
