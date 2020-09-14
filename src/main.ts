import { SketchContext } from './utils/sketch-context';
import { MenuController } from './components/menu.controller';

export function onStart(context: any) {
    COScript.currentCOScript().setShouldKeepAround(true);
    if (context.document || (context.actionContext && context.actionContext.document) || (MSDocument as any).currentDocument()) {

    } else {
        return;
    }
    const ctx = new SketchContext(context);

    const mc = new MenuController(ctx);

    if (!mc.initView()) {
        mc.toogle();
    }
    console.log(mc.view);
}
