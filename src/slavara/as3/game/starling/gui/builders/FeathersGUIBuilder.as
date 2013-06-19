package slavara.as3.game.starling.gui.builders {
	import feathers.controls.Button;
	import feathers.controls.ProgressBar;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Slider;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.TextInput;
	import feathers.core.DisplayListWatcher;
	import feathers.core.ITextEditor;
	import feathers.display.Scale9Image;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersButtonConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersProgressBarConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersScrollContainerConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersSliderConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersTextInputConfig;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.utils.TexUtils;
	import starling.display.DisplayObject;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersGUIBuilder extends StarlingGUIBuilder {
		
		public static function buildButton(button:Button, config:FeathersButtonConfig):DisplayObject {
			button.useHandCursor = config.useHandCursor;
			
			if (Validate.stringIsNotEmpty(config.label)) {
				button.label = config.label;
				button.defaultLabelProperties.textFormat = config.textFormat;
			}
			if (Validate.isNotNull(config.texDefaultSkin)) {
				button.defaultSkin = createImageFromARP(config.texDefaultSkin);
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
		
		public static function buildScrollContainer(container:ScrollContainer, config:FeathersScrollContainerConfig):DisplayObject {
			if (Validate.isNotNull(config.horizontalLayout)) {
				container.layout = config.horizontalLayout;
			}
			if (Validate.isNotNull(config.verticalLayout)) {
				container.layout = config.verticalLayout;
			}
			if(Validate.isNotNull(config.scrollerProperties)) {
				container.scrollerProperties.horizontalScrollPolicy = config.scrollerProperties.horizontalScrollPolicy;
				container.scrollerProperties.verticalScrollPolicy = config.scrollerProperties.verticalScrollPolicy;
			}
			container.horizontalScrollPosition = config.horizontalScrollPosition;
			container.verticalScrollPosition = config.verticalScrollPosition;
			return container;
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
				if(Validate.stringIsNotEmpty) {
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
				case FeathersSliderConfig:
					item = buildSlider(new Slider(), FeathersSliderConfig(config));
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