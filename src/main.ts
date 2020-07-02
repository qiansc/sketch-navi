import { SketchContext } from './core/sketch-context';
import { id, create as createSliderView } from './core/slider-view';
import { StackView } from './core/element/stack-view';

export function onToggle(context: any) {

    const sketchContext = SketchContext.getOrCreate(context);
    const stageView = sketchContext.stageView;

    let view = stageView.getView<StackView>(id);

    if (view) {
        stageView.removeView(id, view);
        stageView.shutdownView(id);
        return;
    }

    view = createSliderView();
    stageView.insertView(id, view);

}
