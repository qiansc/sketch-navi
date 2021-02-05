//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jul  6 2018 12:02:43).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MSEventHandler.h"
#import "MSPathController.h"

@interface MSShapeEventHandler : MSEventHandler
{
    unsigned long long _ignoreSelectionChangesCount;
//    MSEditShapeInspectorViewController *_inspectorViewController;
    NSArray *_layers;
//    MSVectorOverlayController *_overlayController;
    MSPathController *_pathController;
//    MSShapeEditingBehavior *_editingBehavior;
//    MSStyleInspectorSection *_styleSection;
}

// @property(nonatomic) __weak MSStyleInspectorSection *styleSection; // @synthesize styleSection=_styleSection;
// @property(retain, nonatomic) MSShapeEditingBehavior *editingBehavior; // @synthesize editingBehavior=_editingBehavior;
@property(readonly, nonatomic) MSPathController *pathController; // @synthesize pathController=_pathController;
// @property(readonly, nonatomic) MSVectorOverlayController *overlayController; // @synthesize overlayController=_overlayController;
@property(readonly, copy, nonatomic) NSArray *layers; // @synthesize layers=_layers;
- (void)vectorOverlayController:(id)arg1 didSelectLayers:(id)arg2;
- (void)vectorOverlayControllerDidFinishInteractiveSelection:(id)arg1;
- (void)vectorOverlayController:(id)arg1 didDeselectHandles:(id)arg2;
- (void)vectorOverlayController:(id)arg1 didSelectHandles:(id)arg2;
- (void)vectorOverlayController:(id)arg1 didUnhighlightHandle:(id)arg2;
- (void)vectorOverlayController:(id)arg1 didHighlightHandle:(id)arg2;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
// - (void)performPathControllerUpdate:(CDUnknownBlockType)arg1;
@property(readonly, nonatomic) BOOL ignorePathController;
- (void)selectionDidChangeTo:(id)arg1;
- (void)documentDidChange:(id)arg1;
- (void)pathDidOpenOrClose;
- (id)makeTouchBar;
// @property(readonly, nonatomic) MSEditShapeInspectorViewController *inspectorViewController; // @synthesize inspectorViewController=_inspectorViewController;
- (unsigned long long)inspectorLocation;
- (id)styleViewControllersForLayers:(id)arg1 fromStyleInspectorSection:(id)arg2;
- (id)inspectorViewControllersForLayers:(id)arg1 standardControllers:(id)arg2;
- (id)toolbarIdentifier;
- (void)changeColor:(id)arg1;
- (id)overlayItems:(unsigned long long)arg1 parameters:(struct MSRenderingParameters)arg2;
- (void)delete:(id)arg1;
- (long long)curveModeForPressedKey:(long long)arg1;
- (void)flagsChanged:(id)arg1;
- (void)keyDown:(id)arg1;
- (void)insertBacktab:(id)arg1;
- (void)insertTab:(id)arg1;
- (void)selectAll:(id)arg1;
- (void)duplicate:(id)arg1;
- (id)layersToCopy;
- (BOOL)updateCursor;
- (void)trackMouse:(id)arg1;
- (BOOL)absoluteMouseUp:(struct CGPoint)arg1 flags:(unsigned long long)arg2;
- (id)parentGroupForInserting;
- (void)insertNewShapeForEditingAtPoint:(struct CGPoint)arg1;
- (BOOL)mouseDownEvent:(id)arg1;
- (struct CGRect)selectedRect;
- (void)zoomToSelection;
- (void)updateToolButton;
- (void)setAllowSelectionOnly:(BOOL)arg1;
- (void)toggleForceSelection:(id)arg1;
- (void)forceSelection:(id)arg1;
- (void)markLayer:(id)arg1 asEditing:(BOOL)arg2;
- (void)setLayers:(id)arg1;
- (void)resetWithOptions:(unsigned long long)arg1;
- (void)layerListSelectionDidChange:(id)arg1;
- (void)handlerWillLoseFocus;
- (void)handlerGotFocus;
- (void)selectBestEditPoint;
- (void)dealloc;
- (id)initWithManager:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

