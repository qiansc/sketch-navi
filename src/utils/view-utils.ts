export function walkViewTree(rootView: any, fn: (view: any) => void) {
    function _visit(view: any) {
      fn(view);

      var subviews = view.subviews();
      for (var i = 0; i < subviews.count(); i++) {
        _visit(subviews.objectAtIndex(i));
      }
    }

    _visit(rootView);
}

export function listAllSubviews(rootView: any) {
    const result: {[index: string]: any} = [];
    walkViewTree(rootView, (view) => {
        var id = String(view.identifier());
        if (id && id.indexOf('_') !== 0) {
          result[id] = view;
        }
      });
    return result;
}

export function getSubviewsById(rootView: any, identifier: string) {
    const result: any[] = [];
    walkViewTree(rootView, (view) => {
        var id = String(view.identifier());
        if (id && id.indexOf('_') !== 0 && String(identifier) === id) {
          result.push(view);
        }
      });
    console.log('---reuslt---', result.length);
    return result;
}

export function getSubviewById(rootView: any, identifier: string) {
    return getSubviewsById(rootView, identifier)[0];
}
