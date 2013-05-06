package slavara.as3.game.starling.gui.builders {
	import feathers.controls.Button;
	import feathers.controls.ProgressBar;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Slider;
	import feathers.core.DisplayListWatcher;
	import feathers.display.Scale9Image;
	import slavara.as3.core.utils.Validate;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersButtonConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersProgressBarConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersScrollContainerConfig;
	import slavara.as3.game.starling.gui.configurations.controlls.feathers.FeathersSliderConfig;
	import slavara.as3.game.starling.gui.configurations.GUIConfig;
	import slavara.as3.game.starling.utils.TexUtils;
	import starling.display.DisplayObject;
	
	/**
	 * @author SlavaRa
	 */
	public class FeathersGUIBuilder extends StarlingGUIBuilder {
		
		public function FeathersGUIBuilder(config:GUIConfig) {
			super(config);
		}
		
		protected override function preBuildItem(config:GUIConfig):DisplayObject {
			var item:DisplayObject;
			switch(Object(config).constructor) {
				case FeathersButtonConfig:
					item = getFeathersButton(FeathersButtonConfig(config));
					break;
				case FeathersSliderConfig:
					item = getFeathersSlider(FeathersSliderConfig(config));
					break;
				case FeathersScrollContainerConfig:
					item = getFeathersScrollContainer(FeathersScrollContainerConfig(config));
					break;
				case FeathersProgressBarConfig:
					item = getFeathersProgressBar(FeathersProgressBarConfig(config));
					break;
				default: return super.preBuildItem(config);
			}
			return postBuildItem(item, config);
		}
		
		private function getFeathersButton(config:FeathersButtonConfig):DisplayObject {
			const button:Button = new Button();
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
		
		private function getFeathersSlider(config:FeathersSliderConfig):DisplayObject {
			const slider:Slider = new Slider();
			const watcher:DisplayListWatcher = new DisplayListWatcher(slider);
			
			slider.name = config.name;
			slider.minimum = config.minimum;
			slider.maximum = config.maximum;
			slider.value = config.value;
			slider.step = config.step;
			slider.showThumb = config.showThumb;
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;
			
			watcher.setInitializerForClass(feathers.controls.Button, function():void {
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
			
			watcher.setInitializerForClass(feathers.controls.Button, function():void {
				if (Validate.isNotNull(config.texMinimumTrackDefaultSkin)) {
					slider.minimumTrackProperties.defaultSkin = createImageFromARP(config.texMinimumTrackDefaultSkin);
				}
				if (Validate.isNotNull(config.texMinimumTrackDownSkin)) {
					slider.minimumTrackProperties.downSkin = createImageFromARP(config.texMinimumTrackDownSkin);
				}
			}, Slider.DEFAULT_CHILD_NAME_MINIMUM_TRACK);
			
			watcher.setInitializerForClass(feathers.controls.Button, function():void {
				if (Validate.isNotNull(config.texMaximumTrackDefaultSkin)) {
					slider.maximumTrackProperties.defaultSkin = createImageFromARP(config.texMaximumTrackDefaultSkin);
				}
				if (Validate.isNotNull(config.texMaximumTrackDownSkin)) {
					slider.maximumTrackProperties.downSkin = createImageFromARP(config.texMaximumTrackDownSkin);
				}
			}, Slider.DEFAULT_CHILD_NAME_MAXIMUM_TRACK);
			
			return slider;
		}
		
		private function getFeathersScrollContainer(config:FeathersScrollContainerConfig):DisplayObject {
			const container:ScrollContainer = new ScrollContainer();
			
			if (Validate.isNotNull(config.horizontalLayout)) {
				container.layout = config.horizontalLayout;
			}
			if (Validate.isNotNull(config.verticalLayout)) {
				container.layout = config.verticalLayout;
			}
			
			container.scrollerProperties.horizontalScrollPolicy = config.scrollerProperties.horizontalScrollPolicy;
			container.scrollerProperties.verticalScrollPolicy = config.scrollerProperties.verticalScrollPolicy;
			container.verticalScrollPosition = config.verticalScrollPosition;
			container.horizontalScrollPosition = config.horizontalScrollPosition;
			return container;
		}
		
		private function getFeathersProgressBar(config:FeathersProgressBarConfig):DisplayObject {
			const progressBar:.ProgressBar = new ProgressBar();
			
			if(Validate.isNotNull(config.backgroundSkin)) {
				progressBar.backgroundSkin = createImageFromARP(config.backgroundSkin);
			}
			
			if(Validate.isNotNull(config.fillSkin)) {
				const image:Scale9Image = new Scale9Image(TexUtils.getScale9Textures(name, scale9Grid));
				image.width = config.rect.x << 1;
				progressBar.fillSkin = image;
			}
			
			progressBar.minimum = config.minimum;
			progressBar.maximum = config.maximum;
			progressBar.value = config.value;
			
			return progressBar;
		}
		
	}
}