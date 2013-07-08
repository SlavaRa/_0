package slavara.as3.game.starling.gui.builders {
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.List;
	import feathers.controls.ProgressBar;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Slider;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.TextInput;
	import feathers.core.DisplayListWatcher;
	import feathers.core.ITextEditor;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale3Textures;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersButtonConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersButtonGroupConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersListConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersProgressBarConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersScrollContainerConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersSliderConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersTextInputConfig;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.utils.TexUtils;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersGUIBuilder extends StarlingGUIBuilder {
		
		public static function createScale3Image(scale3tex:Scale3Textures):DisplayObject {
			return new Scale3Image(scale3tex);
		}
		
		public static function buildButton(button:Button, config:FeathersButtonConfig):DisplayObject {
			button.useHandCursor = config.useHandCursor;
			
			if (Validate.stringIsNotEmpty(config.label)) {
				button.label = config.label;
				button.defaultLabelProperties.textFormat = config.textFormat;
			}
			if (Validate.isNotNull(config.texDefaultSkin)) {
				button.defaultSkin = createImageFromARP(config.texDefaultSkin);
			} else if(Validate.isNotNull(config.scale3texDefaultSkin)) {
				button.defaultSkin = createScale3Image(config.scale3texDefaultSkin);
			}
			if (Validate.isNotNull(config.texUpSkin)) {
				button.upSkin = createImageFromARP(config.texUpSkin);
			}
			if (Validate.isNotNull(config.texDownSkin)) {
				button.downSkin = createImageFromARP(config.texDownSkin);
			}
			if (Validate.isNotNull(config.texDefaultIcon)) {
				button.defaultIcon = createImageFromARP(config.texDefaultIcon);
			}
			return button;
		}
		
		public static function buildButtonGroup(group:ButtonGroup, config:FeathersButtonGroupConfig):DisplayObject {
			group.direction = config.direction;
			group.gap = config.gap;
			group.isEnabled = true;
			if(Validate.isNotNull(config.dataProvider)) {
				group.dataProvider = config.dataProvider;
			}
			if(Validate.isNotNull(config.buttonFactory)) {
				group.buttonFactory = config.buttonFactory;
			}
			return group;
		}
		
		public static function buildSlider(slider:Slider, config:FeathersSliderConfig):DisplayObject {
			const watcher:DisplayListWatcher = new DisplayListWatcher(slider);
			
			slider.minimum = config.minimum;
			slider.maximum = config.maximum;
			slider.value = config.value;
			slider.step = config.step;
			slider.showThumb = config.showThumb;
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;
			
			watcher.setInitializerForClass(Button, function():void {
				if (Validate.isNotNull(config.texThumbDefaultSkin)) {
					slider.thumbProperties.defaultSkin = createImageFromARP(config.texThumbDefaultSkin);
				}
				if (Validate.isNotNull(config.texThumbDownSkin)) {
					slider.thumbProperties.downSkin = createImageFromARP(config.texThumbDownSkin);
				}
				if (Validate.isNotNull(config.texThumbHoverSkin)) {
					slider.thumbProperties.hoverSkin = createImageFromARP(config.texThumbHoverSkin);
				}
			}, feathers.controls.Slider.DEFAULT_CHILD_NAME_THUMB);
			
			watcher.setInitializerForClass(Button, function():void {
				if (Validate.isNotNull(config.texMinimumTrackDefaultSkin)) {
					slider.minimumTrackProperties.defaultSkin = createImageFromARP(config.texMinimumTrackDefaultSkin);
				}
				if (Validate.isNotNull(config.texMinimumTrackDownSkin)) {
					slider.minimumTrackProperties.downSkin = createImageFromARP(config.texMinimumTrackDownSkin);
				}
			}, Slider.DEFAULT_CHILD_NAME_MINIMUM_TRACK);
			
			watcher.setInitializerForClass(Button, function():void {
				if (Validate.isNotNull(config.texMaximumTrackDefaultSkin)) {
					slider.maximumTrackProperties.defaultSkin = createImageFromARP(config.texMaximumTrackDefaultSkin);
				}
				if (Validate.isNotNull(config.texMaximumTrackDownSkin)) {
					slider.maximumTrackProperties.downSkin = createImageFromARP(config.texMaximumTrackDownSkin);
				}
			}, Slider.DEFAULT_CHILD_NAME_MAXIMUM_TRACK);
			
			return slider;
		}
		
		public static function buildScrollContainer(scroll:ScrollContainer, config:FeathersScrollContainerConfig):DisplayObject {
			if(Validate.isNotNull(config.horizontalLayout)) {
				config.horizontalLayout.useVirtualLayout = config.useVirtualLayout;
				scroll.layout = config.horizontalLayout;
			}
			if(Validate.isNotNull(config.verticalLayout)) {
				config.verticalLayout.useVirtualLayout = config.useVirtualLayout;
				scroll.layout = config.verticalLayout;
			}
			if(Validate.isNotNull(config.scrollerProperties)) {
				scroll.scrollerProperties.horizontalScrollPolicy = config.scrollerProperties.horizontalScrollPolicy;
				scroll.scrollerProperties.verticalScrollPolicy = config.scrollerProperties.verticalScrollPolicy;
				scroll.scrollerProperties.scrollBarDisplayMode = config.scrollerProperties.scrollBarDisplayMode;
				scroll.scrollerProperties.interactionMode = config.scrollerProperties.interactionMode;
				scroll.scrollerProperties.horizontalScrollBarFactory = config.scrollerProperties.horizontalScrollBarFactory;
				scroll.scrollerProperties.verticalScrollBarFactory = config.scrollerProperties.verticalScrollBarFactory;
			}
			scroll.horizontalScrollPosition = config.horizontalScrollPosition;
			scroll.verticalScrollPosition = config.verticalScrollPosition;
			scroll.elasticity = config.elasticity;
			scroll.elasticSnapDuration = config.elasticSnapDuration;
			scroll.hasElasticEdges = config.hasElasticEdges;
			return scroll;
		}
		
		public static function buildList(list:List, config:FeathersListConfig):DisplayObject {
			if(Validate.isNotNull(config.horizontalLayout)) {
				config.horizontalLayout.useVirtualLayout = config.useVirtualLayout;
				list.layout = config.horizontalLayout;
			}
			if(Validate.isNotNull(config.verticalLayout)) {
				config.verticalLayout.useVirtualLayout = config.useVirtualLayout;
				list.layout = config.verticalLayout;
			}
			if(Validate.isNotNull(config.itemRendererProperties)) {
				list.itemRendererProperties.gap = config.itemRendererProperties.gap;
				list.itemRendererProperties.horizontalAlign = config.itemRendererProperties.horizontalAlign;
				list.itemRendererProperties.iconPosition = config.itemRendererProperties.iconPosition;
				list.itemRendererProperties.iconSourceField = config.itemRendererProperties.iconSourceField;
				list.itemRendererProperties.labelField = config.itemRendererProperties.labelField;
				list.itemRendererProperties.verticalAlign = config.itemRendererProperties.verticalAlign;
			}
			if(Validate.isNotNull(config.itemRendererFactory)) {
				list.itemRendererFactory = config.itemRendererFactory;
			}
			if(Validate.isNotNull(config.dataProvider)){
				list.dataProvider = config.dataProvider;
			}
			if(Validate.isNotNull(config.scrollerProperties)) {
				list.scrollerProperties.horizontalScrollPolicy = config.scrollerProperties.horizontalScrollPolicy;
				list.scrollerProperties.verticalScrollPolicy = config.scrollerProperties.verticalScrollPolicy;
				list.scrollerProperties.scrollBarDisplayMode = config.scrollerProperties.scrollBarDisplayMode;
				list.scrollerProperties.interactionMode = config.scrollerProperties.interactionMode;
				list.scrollerProperties.horizontalScrollBarFactory = config.scrollerProperties.horizontalScrollBarFactory;
				list.scrollerProperties.verticalScrollBarFactory = config.scrollerProperties.verticalScrollBarFactory;
			}
			list.horizontalScrollPosition = config.horizontalScrollPosition;
			list.verticalScrollPosition = config.verticalScrollPosition;
			list.elasticity = config.elasticity;
			list.elasticSnapDuration = config.elasticSnapDuration;
			list.hasElasticEdges = config.hasElasticEdges;
			list.isEnabled = config.isSelectable;
			return list;
		}
		
		public static function buildProgressBar(progressBar:ProgressBar, config:FeathersProgressBarConfig):DisplayObject {
			if(Validate.isNotNull(config.backgroundSkin)) {
				progressBar.backgroundSkin = createImageFromARP(config.backgroundSkin);
			}
			if(Validate.isNotNull(config.fillSkin)) {
				const image:Scale9Image = new Scale9Image(TexUtils.getScale9Textures(config.fillSkin, config.rect));
				image.width = config.rect.x << 1;
				progressBar.fillSkin = image;
			}
			progressBar.minimum = config.minimum;
			progressBar.maximum = config.maximum;
			progressBar.value = config.value;
			return progressBar;
		}
		
		public static function buildTextInput(textInput:TextInput, config:FeathersTextInputConfig):DisplayObject {
			textInput.paddingTop = config.paddingTop;
			textInput.paddingRight = config.paddingRight;
			textInput.paddingBottom = config.paddingBottom;
			textInput.paddingLeft = config.paddingLeft;
			textInput.textEditorFactory = function():ITextEditor {
				const editor:StageTextTextEditor = new StageTextTextEditor();
				editor.fontFamily = config.fontName;
				editor.fontSize = config.fontSize;
				editor.color = config.color;
				editor.textAlign = config.hAlign;
				if(Validate.stringIsNotEmpty(config.restrict)) {
					editor.restrict = config.restrict;
				}
				if(config.maxChars !== -1) {
					editor.maxChars = config.maxChars;
				}
				return editor;
			}
			if(Validate.stringIsNotEmpty(config.text)) {
				textInput.text = config.text;
			}
			if(Validate.isNotNull(config.scale3texBackgroundTex)){
				textInput.backgroundSkin = createScale3Image(config.scale3texBackgroundTex);
			}
			return textInput;
		}
		
		public function FeathersGUIBuilder(config:GUIConfig) {
			super(config);
		}
		
		protected override function preBuildItem(config:GUIConfig):DisplayObject {
			var item:DisplayObject;
			switch(Object(config).constructor) {
				case FeathersButtonConfig:
					item = buildButton(new Button(), FeathersButtonConfig(config));
					break;
				case FeathersButtonGroupConfig:
					item = buildButtonGroup(new ButtonGroup(), FeathersButtonGroupConfig(config));
					break;
				case FeathersSliderConfig:
					item = buildSlider(new Slider(), FeathersSliderConfig(config));
					break;
				case FeathersListConfig:
					item = buildList(new List(), FeathersListConfig(config));
					break;
				case FeathersScrollContainerConfig:
					item = buildScrollContainer(new ScrollContainer(), FeathersScrollContainerConfig(config));
					break;
				case FeathersProgressBarConfig:
					item = buildProgressBar(new ProgressBar(), FeathersProgressBarConfig(config));
					break;
				case FeathersTextInputConfig:
					item = buildTextInput(new TextInput(), FeathersTextInputConfig(config));
					break;
				default: return super.preBuildItem(config);
			}
			return postBuildItem(item, config);
		}
		
	}
}