package {
	import flash.display.Sprite;
	import slavara.as3.core.data.Data;
	import slavara.as3.core.data.DataContainer;
	import slavara.as3.core.display.BaseSprite;
	import slavara.as3.core.enums.StateMachineEnum;
	import slavara.as3.core.events.StateMachineEvent;
	import slavara.as3.core.statemachine.StateMachine;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.Validate;
	
	/**
	 * @author SlavaRa
	 */
	public class Main extends BaseSprite {
		
		public function Main():void {
			super();
		}
		
		protected override function onAddedToStage():void {
			
			//{ region Validate.isVector
			//trace(Validate.isVector(new <int>[1]));				//ok
			//trace(Validate.isVector(new <uint>[0xff]));			//ok
			//trace(Validate.isVector(new <Number>[1.2]));			//ok
			//trace(Validate.isVector(new <String>["true"]));		//ok
			//trace(Validate.isVector(new <Boolean>[true]));		//ok
			//trace(Validate.isVector(new <Sprite>[new Sprite()]));	//ok
			//} endregion
			
			//{ region Collection.remove and Collection.exists
			//trace(Collection.exists(1, list));		//ok true
			//trace(Collection.remove(1, list));		//ok 1
			//trace(Collection.exists(1, list));		//ok false
			//trace(list);								//ok 2,3,4,5
			//} endregion
			
			//{ region Collection.removeAt
			//const list:Vector.<int> = new <int>[1,2,3,4,5];
			//trace(Collection.removeAt(1, list));		//ok 2
			//trace(list);								//ok 1,3,4,5
			//} endregion
			
			//{ region Collection.insert
			//const list:Vector.<int> = new <int>[1,2,3,4,5];
			//trace(Collection.insert(0, 4, list));		//ok 0
			//trace(Collection.insert(99, 5, list));	//ok 99
			//trace(list)								//ok 1,2,3,4,0,99,5
			//} endregion
			
			//{ region DataContainer
			//const container:DataContainer = new DataContainer();		//ok if debug
			//container.addChild(new Data());							//ok if debug
			//container.addChild(new Data()).name = "data";				//ok if debug
			//container.addChild(new Data());							//ok if debug
			//trace(container.numChildren);								//ok 3
			//container.removeChildAt(0);								//ok
			//trace(container.numChildren);								//ok 2
			//container.removeChild(container.getChildByName("data"));	//ok 
			//trace(container.numChildren);								//ok 1
			//container.removeChildren();								//ok
			//trace(container.numChildren);								//ok 0
			//} endregion
			
			//{ region StateMachine
			//const statemachine:StateMachine = new StateMachine();
			//statemachine.add(StateEnum.A, StateEnum.B);
			//statemachine.add(StateEnum.B, StateEnum.A);
			//statemachine.addTransitionListener(StateMachineEnum.CHANGE, StateEnum.A, function():void { trace("to A") } ); //ok to A
			//statemachine.addTransitionListener(StateMachineEnum.CHANGE, StateEnum.B, function():void { trace("to B") } ); //ok to B
			//statemachine.setState(StateEnum.B);
			//statemachine.setState(StateEnum.A);
			//statemachine.removeTransitionListeners();
			//} endregion
			
			
			
		}
		
	}
	
}

//{ region fake states of StateMechine
//import slavara.as3.core.enums.BaseEnum;
//class StateEnum extends BaseEnum {
	//public static const A:BaseEnum = new StateEnum("Foo");
	//public static const B:BaseEnum = new StateEnum("Foo");
	//public function StateEnum(num:String) {
		//super(num);
	//}
//}
//} endregion
