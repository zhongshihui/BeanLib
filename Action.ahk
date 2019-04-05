﻿
/*
说明:BeanLib内的通用函数/方法对象
*/

class Action{
	
	isAction:=true
	func:="",funcThis:=""
	conditions := Object("before","","after","")
	static funcObjCalledName:=["Call",""]
	
;---------------------------------------------------------------------- 

	class meta{
		actionThis:=""
;---------------------------------------------------------------------- 
		initFunc(aFuncThis,aFunc){
			type.afFuncObj(aFunc)
			this.actionThis.func:=aFunc
			this.actionThis.funcThis:=aFuncThis
			return
		}
;---------------------------------------------------------------------- 

	onError(){
		if(IsObject(this.onErrorAction)){
			this.onErrorAction.Call()
		}
		else{
		}
		return
	}
;---------------------------------------------------------------------- 
	onBefore(){
		try{
			this.thethis.conditions.before.Call()
		}
		catch{
			this.onError()
		}
		return
	}
;---------------------------------------------------------------------- 		
	} ;------class Meta   End
	
;---------------------------------------------------------------------- 	
	__call(aMethodName,aParams*){

        if(Bean.isCall(aMethodName)){
			this.meta.onBefore()
			aParams.InsertAt(1,this.funcThis)
			return SmartCall(this.func,aParams*)			
		}
		
		else if(ObjHasKey(this.meta,aMethodName)){
			aParams.InsertAt(1,this.meta)
			return SmartCall(this.meta[aMethodName],aParams*)
		}		
		else if (Bean.isMeta(aMethodName)){
			return false
		}
		
		else{
			throw Exception(_EX.NoExistMethod)
		}
		return
	}
;---------------------------------------------------------------------- 
	__New(aFuncThis,aFunc){
			this.meta.actionThis := this
			this.initFunc(aFuncThis,aFunc)
			return this
	}
} ;---------class Action End