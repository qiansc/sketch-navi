@interface MSCanvasViewController : NSViewController
{
    BOOL _shouldHideOverlayControls;
    BOOL _observingDefaults;
    MSCanvasView *_canvasView;
    NSView *_rulerCornerView;
    NSLayoutConstraint *_rulerWidthConstraint;
    NSLayoutConstraint *_rulerHeightConstraint;
    MSDocument *_document;
}

+ (id)overlayOptionsDefaultsKeys;
@property(nonatomic, getter=isObservingDefaults) BOOL observingDefaults; // @synthesize observingDefaults=_observingDefaults;
@property(nonatomic) BOOL shouldHideOverlayControls; // @synthesize shouldHideOverlayControls=_shouldHideOverlayControls;
@property(nonatomic) __weak MSDocument *document; // @synthesize document=_document;
@property(nonatomic) __weak NSLayoutConstraint *rulerHeightConstraint; //
@property(nonatomic) __weak NSLayoutConstraint *rulerWidthConstraint; // @synthesize rulerWidthConstraint=_rulerWidthConstraint;
@property(retain, nonatomic) NSView *rulerCornerView; // @synthesize rulerCornerView=_rulerCornerView;
//@property(retain, nonatomic) _TtC6Sketch11MSRulerView *verticalRuler; // @synthesize verticalRuler=_verticalRuler;
//@property(retain, nonatomic) _TtC6Sketch11MSRulerView *horizontalRuler; // @synthesize horizontalRuler=_horizontalRuler;
@property(retain, nonatomic) MSCanvasView *canvasView; // @synthesize canvasView=_canvasView;
- (void)rulerViewStopCoalescingHistory:(id)arg1;
- (void)rulerViewStartCoalescingHistory:(id)arg1;
- (void)rulerViewDidDisableTemporaryGuide:(id)arg1;
- (void)rulerView:(id)arg1 didMoveTemporaryGuideToPosition:(double)arg2;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)endObservingDefaults;
- (void)beginObservingDefaults;
- (void)updateContentSettings;
- (void)updateOverlaySettings;
- (unsigned long long)currentOverlayOptions;
- (void)canvasViewDidChangeEffectiveAppearance:(id)arg1;
@property(nonatomic) double zoomValue;
@property(nonatomic) struct CGPoint scrollOrigin;
- (void)refreshRulers;
- (void)prepareForDealloc;
- (void)viewWillDisappear;
- (void)viewDidAppear;
- (void)viewDidLoad;
- (void)updateRulers;
- (void)dealloc;
- (void)awakeFromNib;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

