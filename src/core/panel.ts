export class Panel {
    public view: any;
    constructor(public id: string) {

    }
    public createView() {
        this.view = NSStackView.alloc().initWithFrame(NSMakeRect(0, 0, 40, 400));

        // threadDictionary[SidePanelIdentifier] = toolbar;
        this.view.identifier = this.id;
        this.view.setSpacing(8);
        this.view.setFlipped(true);
        this.view.setBackgroundColor(NSColor.windowBackgroundColor());
        this.view.orientation = 1
        // insertSidePanel(context, toolbar, SidePanelIdentifier)
    }
    public setView(view: any) {
        this.view = view;
    }


}

export interface InjectablePanel {
    // static getIDPrefix(documentID?: string) : string;

}
