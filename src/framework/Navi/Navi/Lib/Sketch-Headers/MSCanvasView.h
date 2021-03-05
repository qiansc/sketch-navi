//
//  MSCanvasView.h
//  Navi
//
//  Created by QIANSC on 2020/11/30.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import "MSDocument.h"
#import "MSCanvasViewDelegate.h"
#import "MSEventHandlerManager.h"
#import "MSViewPort.h"

@interface MSCanvasView : NSView
{
    BOOL handToolIsActive;
    struct CGPoint handToolOriginalPoint;
    struct CGPoint handToolOriginalScrollOrigin;
    BOOL hasDraggedOutsideInitialPadding;
    struct CGPoint mouseDownPoint;
    id _eventMonitor;
    struct CGPoint _handToolOriginalPoint;
    struct CGPoint _handToolOriginalScrollOrigin;
    BOOL _didMouseDown;
    BOOL _shouldDrawPixelated;
    BOOL _shouldOptimisePerformance;
    BOOL _needsUpdateCursor;
    BOOL _haveStoredMostRecentFullScaleScrollOrigin;
    BOOL _magnifying;
    BOOL _didMouseDragged;
    BOOL _hasUserFocus;
    BOOL _hasWindow;
    BOOL _shouldRedrawNextEqualRenderingInstruction;
//    NSObject<MSTilingSystemProvider> *_tiledRenderer;
    id <MSCanvasViewDelegate> _delegate;
    MSEventHandlerManager *_eventHandlerManager;
//    _TtC6Sketch11MSRulerView *_horizontalRuler;
//    _TtC6Sketch11MSRulerView *_verticalRuler;
    id _document;
//    MSRenderingDriver *_driver;
//    MSMouseTracker *_mouseTracker;
    unsigned long long _handToolState;
//    MSOverlaySettings *_overlaySettings;
//    MSZoomTool *_zoomTool;
    double _temporaryVerticalGuide;
    double _temporaryHorizontalGuide;
//    _TtC6Sketch18MSGuideOverlayTool *_guideOverlayTool;
//    _TtC6Sketch18MSScrollRecognizer *_scrollRecognizer;
    struct __CFRunLoopObserver *_displayRunLoopObserver;
    struct __CVDisplayLink *_displayLink;
//    MSRenderInstruction *_renderInstruction;
    double _windowBackingScale;
    unsigned long long _renderMask;
    struct CGPoint _scalingCenterInViewCoordinates;
    struct CGPoint _mostRecentFullScaleScrollOrigin;
    struct _opaque_pthread_mutex_t _renderLock;
}

+ (struct CGPoint)absoluteCoordinatesFromViewCoordinates:(struct CGPoint)arg1 forViewPort:(id)arg2;
+ (struct CGPoint)viewCoordinatesFromAbsoluteCoordinates:(struct CGPoint)arg1 forViewPort:(id)arg2;
+ (struct CGPoint)scrollOriginAfterScalingViewPort:(id)arg1 toZoomValue:(double)arg2 scalingCenterInViewCoordinates:(struct CGPoint)arg3;
+ (id)viewPortAfterScalingViewPort:(id)arg1 toZoom:(double)arg2 centeredOnAbsoluteCoordinates:(struct CGPoint)arg3;
@property BOOL shouldRedrawNextEqualRenderingInstruction; // @synthesize shouldRedrawNextEqualRenderingInstruction=_shouldRedrawNextEqualRenderingInstruction;
@property(nonatomic) unsigned long long renderMask; // @synthesize renderMask=_renderMask;
@property(nonatomic) double windowBackingScale; // @synthesize windowBackingScale=_windowBackingScale;
@property(nonatomic) BOOL hasWindow; // @synthesize hasWindow=_hasWindow;
@property BOOL hasUserFocus; // @synthesize hasUserFocus=_hasUserFocus;
@property(readonly, nonatomic) struct _opaque_pthread_mutex_t renderLock; // @synthesize renderLock=_renderLock;
// @property(copy) MSRenderInstruction *renderInstruction; // @synthesize renderInstruction=_renderInstruction;
@property(nonatomic) struct __CVDisplayLink *displayLink; // @synthesize displayLink=_displayLink;
@property(readonly, nonatomic) struct __CFRunLoopObserver *displayRunLoopObserver; // @synthesize displayRunLoopObserver=_displayRunLoopObserver;
// @property(readonly, nonatomic) _TtC6Sketch18MSScrollRecognizer *scrollRecognizer; // @synthesize scrollRecognizer=_scrollRecognizer;
@property(nonatomic) BOOL didMouseDragged; // @synthesize didMouseDragged=_didMouseDragged;
@property(nonatomic, getter=isMagnifying) BOOL magnifying; // @synthesize magnifying=_magnifying;
@property(nonatomic) BOOL haveStoredMostRecentFullScaleScrollOrigin; // @synthesize haveStoredMostRecentFullScaleScrollOrigin=_haveStoredMostRecentFullScaleScrollOrigin;
@property(nonatomic) struct CGPoint mostRecentFullScaleScrollOrigin; // @synthesize mostRecentFullScaleScrollOrigin=_mostRecentFullScaleScrollOrigin;
@property(nonatomic) struct CGPoint scalingCenterInViewCoordinates; // @synthesize scalingCenterInViewCoordinates=_scalingCenterInViewCoordinates;
// @property(readonly, nonatomic) _TtC6Sketch18MSGuideOverlayTool *guideOverlayTool; // @synthesize guideOverlayTool=_guideOverlayTool;
@property(nonatomic) double temporaryHorizontalGuide; // @synthesize temporaryHorizontalGuide=_temporaryHorizontalGuide;
@property(nonatomic) double temporaryVerticalGuide; // @synthesize temporaryVerticalGuide=_temporaryVerticalGuide;
// @property(readonly, nonatomic) MSZoomTool *zoomTool; // @synthesize zoomTool=_zoomTool;
@property(readonly, nonatomic) BOOL needsUpdateCursor; // @synthesize needsUpdateCursor=_needsUpdateCursor;
@property(nonatomic) BOOL shouldOptimisePerformance; // @synthesize shouldOptimisePerformance=_shouldOptimisePerformance;
@property(nonatomic) BOOL shouldDrawPixelated; // @synthesize shouldDrawPixelated=_shouldDrawPixelated;
// @property(copy, nonatomic) MSOverlaySettings *overlaySettings; // @synthesize overlaySettings=_overlaySettings;
@property(nonatomic) unsigned long long handToolState; // @synthesize handToolState=_handToolState;
@property(nonatomic) BOOL didMouseDown; // @synthesize didMouseDown=_didMouseDown;
// @property(readonly, nonatomic) MSMouseTracker *mouseTracker; // @synthesize mouseTracker=_mouseTracker;
// @property(readonly, nonatomic) MSRenderingDriver *driver; // @synthesize driver=_driver;
@property(nonatomic) __weak id *document; // @synthesize document=_document;
// @property(nonatomic) __weak _TtC6Sketch11MSRulerView *verticalRuler; // @synthesize verticalRuler=_verticalRuler;
// @property(nonatomic) __weak _TtC6Sketch11MSRulerView *horizontalRuler; // @synthesize horizontalRuler=_horizontalRuler;
@property(retain, nonatomic) MSEventHandlerManager *eventHandlerManager; // @synthesize eventHandlerManager=_eventHandlerManager;
@property(nonatomic) __weak id <MSCanvasViewDelegate> delegate; // @synthesize delegate=_delegate;
// @property(retain, nonatomic) NSObject<MSTilingSystemProvider> *tiledRenderer; // @synthesize tiledRenderer=_tiledRenderer;
- (void)startAnimatingViewPort:(id)arg1;
- (struct CGPoint)zoomPoint:(struct CGPoint)arg1;
- (struct CGSize)convertSizeToPage:(struct CGSize)arg1;
- (struct CGPoint)convertPointFromPage:(struct CGPoint)arg1;
- (struct CGPoint)convertPoint:(struct CGPoint)arg1 toCoordinateSpace:(id)arg2;
- (void)ignoreNextKeyDownEventUntilModifiersChange;
- (void)returnToDefaultHandlerIfNeededForResize;
- (void)windowDidResize:(id)arg1;
- (void)viewWillStartLiveResize;
- (void)smartMagnifyWithEvent:(id)arg1;
- (void)eventHandlerManager:(id)arg1 didChangeCurrentHandler:(id)arg2;
- (void)setFrame:(struct CGRect)arg1;
- (void)refreshSidebarWithMask:(unsigned long long)arg1;
- (id)pages;
- (id)currentPage;
- (id)selectedLayers;
- (void)handleFlagsChangedEvent:(id)arg1;
- (void)_scheduleToolbarItemValidation;
- (void)changeColor:(id)arg1;
- (void)cursorUpdate:(id)arg1;
- (void)updateCursorIfNeeded;
- (void)setNeedsUpdateCursor;
- (BOOL)updateCursor;
- (void)changeFont:(id)arg1;
- (BOOL)isOpaque;
- (id)menuForEvent:(id)arg1;
- (void)switchToSymbolHandlerIfPasteboardContentsDetected:(id)arg1;
- (BOOL)wantsPeriodicDraggingUpdates;
- (void)updateDraggingItemsForDrag:(id)arg1;
- (BOOL)performDragOperation:(id)arg1;
- (unsigned long long)draggingUpdated:(id)arg1;
- (BOOL)prepareForDragOperation:(id)arg1;
- (void)draggingExited:(id)arg1;
- (unsigned long long)draggingEntered:(id)arg1;
- (BOOL)resignFirstResponder;
- (BOOL)acceptsFirstResponder;
- (BOOL)acceptsFirstMouse:(id)arg1;
- (void)insertBacktab:(id)arg1;
- (void)insertTab:(id)arg1;
- (void)insertTabIgnoringFieldEditor:(id)arg1;
- (void)keyUp:(id)arg1;
- (BOOL)performActionWithIdentifier:(id)arg1;
- (void)keyDown:(id)arg1;
- (void)insertText:(id)arg1;
- (void)doCommandBySelector:(SEL)arg1;
- (void)handToolMouseUp;
- (void)handToolMouseDragged:(id)arg1;
- (void)handToolMouseDown:(id)arg1;
- (void)displayPropertiesDidChange;
- (void)completeMagnifyWithFactor;
- (void)magnifyByFactor:(double)arg1 centerOnMouse:(BOOL)arg2;
- (void)scroll:(id)arg1;
- (void)scrollWheel:(id)arg1;
- (void)magnifyWithEvent:(id)arg1;
- (void)centerSelectionInVisibleArea;
- (void)centerLayersInCanvas;
- (void)centerRect:(struct CGRect)arg1 animated:(BOOL)arg2;
- (void)centerRect:(struct CGRect)arg1;
- (void)trackMouse:(id)arg1;
- (void)mouseMoved:(id)arg1;
- (void)mouseUp:(id)arg1;
- (void)doMouseDraggedEvent:(id)arg1;
- (void)mouseDraggedOutsideCanvas;
- (BOOL)isPointOutsideCanvas:(struct CGPoint)arg1;
- (void)mouseDragged:(id)arg1;
- (void)mouseDown:(id)arg1;
- (void)mouseExited:(id)arg1;
- (void)mouseEntered:(id)arg1;
- (void)_redrawContentImmediately:(BOOL)arg1;
- (void)renderIfNeeded;
- (unsigned long long)updateRenderInstructionIfNeeded;
- (void)setNeedsRenderWithMask:(unsigned long long)arg1;
- (void)applyCurrentRenderingParametersToInstruction:(id)arg1;
- (void)applyCurrentOverlayToInstruction:(id)arg1;
- (void)applyCurrentDocumentToInstructions:(id)arg1;
@property(readonly, nonatomic) BOOL isReadyToRender;
- (void)_scheduleRedraw:(BOOL)arg1;
- (void)refreshRulers;
- (struct CGPoint)mouseInView;
- (void)animationDidFinishAtViewPort:(id)arg1;
- (void)animationDidFinish;
- (void)endZoomToolMode;
- (void)zoomOut;
- (void)setZoomValueCenteredInCanvas:(double)arg1;
- (void)scaleContentBy:(double)arg1;
- (void)scaleContentBy:(double)arg1 withScalingCenterInViewCoordinates:(struct CGPoint)arg2;
- (void)zoomToActualSizeAnimated:(BOOL)arg1;
- (void)zoomToFitRect:(struct CGRect)arg1;
- (void)animateToZoom:(double)arg1 scalingCenteredOnAbsoluteCoordinates:(struct CGPoint)arg2;
- (void)animateToZoom:(double)arg1;
- (void)zoomIn;
@property(nonatomic) double zoomValue;
- (struct CGRect)visibleContentRect;
- (void)animateScrollOriginToPoint:(struct CGPoint)arg1;
- (struct CGPoint)viewCenterInAbsoluteCoordinatesForViewPort:(id)arg1;
- (struct CGPoint)centerForScalingInAbsoluteCoordinates;
@property(nonatomic) struct CGPoint scrollOrigin;
// - (void)animateToViewPort:(id)arg1 duration:(double)arg2 forceRedraw:(BOOL)arg3 completion:(CDUnknownBlockType)arg4;
- (void)animateToViewPort:(id)arg1;
- (void)zoomBy:(double)arg1 centeredOnViewPoint:(struct CGPoint)arg2;
- (id)viewPortAfterScalingToZoom:(double)arg1 selectionCentered:(BOOL)arg2;
- (id)viewPortAfterScalingToZoom:(double)arg1 centeredOnAbsoluteCoordinates:(struct CGPoint)arg2;
- (id)viewPortWithCenter:(struct CGPoint)arg1 zoomValue:(double)arg2;
- (id)viewPortForZoomToFitRect:(struct CGRect)arg1;
@property(retain, nonatomic) MSViewPort *viewPort;
- (id)overlayItemImages:(struct CGColorSpace *)arg1 backingScale:(double)arg2;
- (id)temporaryGuideOverlayItemContainerWithParameters:(struct MSRenderingParameters)arg1;
- (id)overlayItems:(unsigned long long)arg1 parameters:(struct MSRenderingParameters)arg2;
- (id)flowItems:(unsigned long long)arg1;
- (void)scrollBy:(struct CGPoint)arg1;
- (void)scrollToScrollOrigin:(struct CGPoint)arg1;
- (void)displayLayer:(id)arg1;
- (void)placeOriginInTopLeft;
- (void)centerDocumentAndPlaceScrollOriginInTopLeft;
- (void)centerInBounds;
- (void)prepare;
- (void)viewDidChangeBackingProperties;
- (long long)tag;
- (BOOL)isFlipped;
- (void)removeFromSuperview;
- (void)setupDisplayLinkForWindow:(id)arg1;
- (void)windowDidResignMain:(id)arg1;
- (void)windowDidBecomeMain:(id)arg1;
- (void)viewDidChangeEffectiveAppearance;
- (void)viewDidMoveToWindow;
- (void)removeObserversForNotifications;
- (void)refreshAfterVisualSettingsChange;
- (void)addObserversForNotifications;
- (void)endImporting;
- (void)beginImporting;
- (void)initTiledRendererAndSyncFirstFrame:(BOOL)arg1;
- (void)initDriver;
- (void)teardown;
- (void)dealloc;
- (void)commonInit;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;
- (BOOL)clickShouldDismissPopover:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
