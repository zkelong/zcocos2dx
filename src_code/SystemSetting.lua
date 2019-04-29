
function SysSetting.isCanPlayEffect()
	return cc.UserDefault:getInstance():getBoolForKey("effect_can_play")
end

function SysSetting.playEffect(effect_file, is_loop)
	is_loop = is_loop or false

	local id = nil 
	if SysSetting.isCanPlayEffect() == false then
        -- ios 11.3时音效设为0不起作用 此时设置为很小的一个音量来减小错误
		-- AudioEngine.setEffectsVolume(IS_IOS and 0.00001 or 0)
	else
		id = AudioEngine.playEffect(effect_file, is_loop)
	end
	return id
end