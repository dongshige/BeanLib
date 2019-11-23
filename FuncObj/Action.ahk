﻿

/*
说明:BeanLib内的通用函数/方法对象
*/
class Action{

	;为了实现Action类的静态方法,参考自 JSON类 的设计,这是解决静态方法问题的一个不错的解决方案
	;这也能说明阅读他人代码的重要性
	class Functor{
		__Call(theAction, ByRef arg, args*){
			return (new this).Call(theAction, arg, args*)
		}
	}
;------------------------------
	
	;当方法不依赖于this的时候,可以直接调用Action的For方法,传入一个参数就可以,简洁而方便
	class for extends Action.Functor{
		Call(theAction, ByRef Obj,args*){
			Type.assertObj(Obj)
			return new Action(Obj,Obj)
		} 
	} ;---------class for End

;------------------------------

	isAction:=true
	func:="",funcThis:=""
	before:="",after:=""
	__toString := []
;---------------------------------------------------------------------- 
	
;~ /*
	_NewEnum(){
		if(this.__class != "Action"){
			theTipString = this出错
			TrayTip,%A_ScriptName%,%theTipString% 
			return
		}
;现在看来是枚举类的设计有问题
		return new BeanEnum(Object("func",this.func,"funcThis",this.funcThis,"before",this.before,"after",this.assertter))
	}
;~ */
;---------------------------------------------------------------------- 
		initFunc(aFuncThis,aFunc){
			type.assertFuncObj(aFunc)
			this.func:=aFunc
			this.funcThis:=aFuncThis ;是不是因为这个地方出了问题呢？
			return
		}
		onError(){
			throwWithSt("onError！ onError！ onError！	")
			return
		}
;---------------------------------------------------------------------- 
		onBefore(){
			return
		}
;---------------------------------------------------------------------- 
name[]{
    get {
		theName := this.func.name
		if(theName="")
			return "NS*"
		else
			return theName
    }
    set {
	return False
    }
}
;---------------------------------------------------------------------- 
beforeName[]{
    get {
		theObj := this.before
		if (type.isFuncObj(theObj)){
			return theObj.name
		}
		else{
			return toString(theObj)
		}
    }
    set {
	return False
    }
}
;---------------------------------------------------------------------- 
afterName[]{
    get {
		theObj := this.assertter
		if (type.isFuncObj(theObj)){
			return theObj.name
		}
		else{
			return toString(theObj)
		}
    }
    set {
	return False
    }
}
;---------------------------------------------------------------------- 
		toString(){			
			theFuncName := this.name
			theBeforeName := this.beforeName
			theAfterName := this.assertterName
			theClassName := this.__Class
			resultString = {Type:%theClassName%,Func:%theFuncName%,Before:%theBeforeName%,After:%theAfterName%}
			return resultString
		}
;---------------------------------------------------------------------- 
		call(aParams*){
			rawCall(this,"onBefore")
			result := SmartCall(this.funcThis,this.func,aParams*)
			return result
		}
;---------------------------------------------------------------------- 	
	__call(aMethodName:="",aParams*){
		iscall := Bean.isCall(aMethodName,this)
        if(iscall){
			result := rawCall(this,"call",aParams*)
			return result
		}
		else if (aMethodName = "toString"){
			result := rawCall(this,"toString",aParams*)
			return result
		}
		else if (Bean.isMeta(aMethodName)){
			return false
		}
		else{
			throwWithSt(_EX.NoExistMethod)
		}
		return
	}
;---------------------------------------------------------------------- 
	__New(aFuncThis,aFunc){
			this._NewEnum:=this.base._NewEnum
			this.theThis := this
			rawCall(this,"initFunc",aFuncThis,aFunc)
			return this
	}
} ;---------class Action End