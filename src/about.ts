var sketch: Sketch = require('sketch');
// // Or, require without UI, Settings, DataSupplier, Async,
// var sketchDom: SketchDom = require('sketch/dom');
// // and require others according to your needs
// var async: Async = require('sketch/async');
// var DataSupplier: DataSupplier = require('sketch/data-supplier');
// var UI: UI = require('sketch/ui');
// var Settings: Settings = require('sketch/settings');

// var document: Document = sketch.getSelectedDocument();
// var page: Page = document.selectedPage;


export default function() {
  const doc = sketch.getSelectedDocument()
  const selectedLayers = doc.selectedLayers
  const selectedCount = selectedLayers.length

  if (selectedCount === 0) {
    sketch.UI.message('No layers are selected.')
  } else {
    sketch.UI.message(`${selectedCount} layers selected.`)
  }
}
