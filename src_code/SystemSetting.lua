
SystemSetting = SystemSetting or { }

function SystemSetting.isCanPlayEffect()
	return cc.UserDefault:getInstance():getBoolForKey("effect_can_play")
end

function SystemSetting.playEffect(effect_file, is_loop)
	is_loop = is_loop or false

	local id = nil 
	if SystemSetting.isCanPlayEffect() == false then
        -- ios 11.3时音效设为0不起作用 此时设置为很小的一个音量来减小错误
		-- AudioEngine.setEffectsVolume(IS_IOS and 0.00001 or 0)
	else
		id = AudioEngine.playEffect(effect_file, is_loop)
	end
	return id
end

function SystemSetting.loadWords()
    myRequire("config.ch.Words")
end