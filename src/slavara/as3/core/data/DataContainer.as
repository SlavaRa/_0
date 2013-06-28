package slavara.as3.core.data {
	import flash.utils.getQualifiedClassName;
	import slavara.as3.core.debug.Assert;
	import slavara.as3.core.utils.Collection;
	import slavara.as3.core.utils.MathUtils;

	[ExcludeClass]
	public class DataContainer extends Data {
		
		use namespace $internal;
		
		public function DataContainer() {
			super();
			CONFIG::debug
			{
				if ((this as Object).constructor === DataContainer) {
					throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
				}
			}
			_list = new <Data>[];
		}
		
		public function addChild(child:Data):Data {
			Assert.isNull(child, "child");
			Assert.isThis(child, this);
			if (child.$parent === this)	{
				$setChildIndex(child, _list.indexOf(child));
				return child;
			}
			return $addChildAt(child, _list.length);
		}
		
		public function addChildAt(child:Data, index:int):Data {
			Assert.isNull(child, "child");
			Assert.indexLessThanOrMoreThan(index, 0, _list.length);
			Assert.isThis(child, this);
			if (child.$parent === this) {
				$setChildIndex(child, _list.indexOf(child));
				return child;
			}
			return $addChildAt(child, index);
		}
		
		public function removeChild(child:Data):Data {
			Assert.isNull(child, "child");
			Assert.isThis(child, this);
			return $removeChildAt(_list.indexOf(child));
		}
		
		public function removeChildAt(index:int):Data {
			Assert.indexLessThanOrMoreThan(index, 0, _list.length);
			return $removeChildAt(index);
		}
		
		public function removeChildren(startIndex:int = 0, endIndex:int = int.MAX_VALUE):void {
			if(endIndex >= _list.length) {
				endIndex = _list.length;
			} else {
				++endIndex;
			}
			
			const length:int = endIndex - startIndex;
			
			Assert.indexLessThan(length, 0);
			Assert.indexLessThan(startIndex, 0);
			Assert.indexMoreThan(endIndex, _list.length);
			
			if (length > 0) {
				for each (var child:Data in _list.splice(startIndex, length)) {
					child.$setParent(null);
				}
			}
		}
		
		public function getChildAt(index:int):Data {
			Assert.indexLessThanOrMoreThan(index, 0, _list.length);
			return _list[index];
		}
		
		public function getChildByName(name:String):Data {
			for each (var child:Data in _list) {
				if (child.name === name) {
					return child;
				}
			}
			return null;
		}
		
		public function getChildIndex(child:Data):int {
			Assert.isNull(child, "child");
			Assert.isNotThis(child.$parent, this);
			return _list.indexOf(child);
		}
		
		public function setChildIndex(child:Data, index:int):void {
			Assert.isNull(child, "child");
			Assert.indexLessThanOrMoreThan(index, 0, _list.length);
			$setChildIndex(child, index);
		}
		
		public function swapChildren(child1:Data, child2:Data):void {
			Assert.isNull(child1);
			Assert.isNull(child2);
			Assert.isNotThis(child1.$parent, this);
			Assert.isNotThis(child2.$parent, this);
			$swapChildrenAt(child1, child2, _list.indexOf(child1), _list.indexOf(child2));
		}
		
		public function contains(child:Data):Boolean {
			Assert.isNull(child, "child");
			return $contains(child);
		}
		
		public function sort(compareFunction:Function):Vector.<Data> {
			return _list.sort(compareFunction);
		}
		
		private var _list:Vector.<Data>;
		
		private function $addChildAt(child:Data, index:int):Data {
			const parent:DataContainer = child.$parent;
			if (parent) {
				parent.$removeChildAt(parent._list.indexOf(child));
			}
			Collection.insert(child, index, _list);
			child.$setParent(this);
			return child;
		}
		
		private function $removeChildAt(index:int):Data {
			const child:Data = Data(Collection.removeAt(index, _list));
			child.$setParent(null);
			return child;
		}
		
		private function $setChildIndex(child:Data, index:int):void {
			const oldIndex:int = _list.indexOf(child);
			if (oldIndex === index) {
				return;
			}
			Collection.removeAt(oldIndex, _list);
			Collection.insert(child, index, _list);
		}
		
		private function $swapChildrenAt(child1:Data, child2:Data, index1:int, index2:int):void {
			//TODO: убрать слайс
			_list.splice(index1, 1, child2);
			_list.splice(index2, 1, child1);
		}
		
		private function $contains(child:Data):Boolean {
			do {
				if (child === this) {
					return true;
				}
				child = child.$parent;
			} while (child !== null);
			return false;
		}
		
		public function get numChildren():int {
			return _list.length;
		}
		
	}
}