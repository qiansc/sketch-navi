import { SketchContext } from './utils/sketch-context';
import { Menu } from './components/menu';

export function onStart(context: any) {
    COScript.currentCOScript().setShouldKeepAround(true);
    if (context.document || (context.actionContext && context.actionContext.document) || (MSDocument as any).currentDocument()) {

    } else {
        return;
    }
    const ctx = new SketchContext(context);

    const menu = new Menu(ctx);

    if (!menu.initView()) {
        menu.toogle();
    }
    console.log(menu.view);

}
