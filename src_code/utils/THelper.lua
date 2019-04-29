kl = kl or {}
kl.THelper = kl.THelper or {}


function require_debug(_name)
    package.loaded[_name] = nil
    return myRequire(_name)
end

kl.THelper.addCustomEventListener = function(evt_str, node, callback)
	local listener = cc.EventListenerCustom:create(evt_str, callback)
	local eventDispatcher = node:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node)
end

kl.THelper.dispatchCustomEvent = function(evt_str, datas, node)
	myRequire("common.SceneManager")
	node = node or SceneManager:getCurrentScene()
	local eventDispatcher = node:getEventDispatcher()
	local event = cc.EventCustom:new(evt_str)
	event._userdata = datas
	eventDispatcher:dispatchEvent(event)
end