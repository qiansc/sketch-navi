import { create as createStackView } from "./element/stack-view";
import { createTextButton, createTextField } from "./element";

const key = 'navi-slider';
export const id = `sketch-plugin-${key}`;

export function create() {
    const sliderView = createStackView({
        orientation: 1
    });

    const textFiled = createTextField('规范', NSMakeRect(0, 0, 10, 40)) as any;
    console.log(textFiled);
    const textButton = createTextButton({
        rect: NSMakeRect(0, 0, 18, 20),
        textFiled,
        callAction: () => console.log('click'),
    });
    textButton.orientation = 1;

    sliderView.addView_inGravity(textButton, 1);

    return sliderView;
}
