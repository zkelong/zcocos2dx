LANGUAGE = LANGUAGE or { }
LANGUAGE.EN = "en"
LANGUAGE.CH = "ch"
LANGUAGE.VN = "vn"
LANGUAGE.TH = "th"
SysSetting = SysSetting or { }

function SysSetting.isCanPlayMusic()
	return cc.UserDefault:getInstance():getBoolForKey("music_can_play")
end
function SysSetting.isCanPlayEffect()
	return cc.UserDefault:getInstance():getBoolForKey("effect_can_play")
end
function SysSetting.getSoundVolume()
	if cc.UserDefault:getInstance():getBoolForKey("is_all_init") == false then
		-- default settings
		cc.UserDefault:getInstance():setBoolForKey("is_all_init", true)
		cc.UserDefault:getInstance():setFloatForKey("sound_volume_num", 1)
		cc.UserDefault:getInstance():setBoolForKey("music_can_play", true)
		cc.UserDefault:getInstance():setBoolForKey("effect_can_play", true)

	end
	return cc.UserDefault:getInstance():getFloatForKey("sound_volume_num")
end
function SysSetting.initUserData()
	if cc.UserDefault:getInstance():getBoolForKey("is_init_" .. Player._uuid) == false then
		cc.UserDefault:getInstance():setBoolForKey("is_init_" .. Player._uuid, true)
		cc.UserDefault:getInstance():setBoolForKey("not_accept_team_invitation" .. Player._uuid, false)
		cc.UserDefault:getInstance():setBoolForKey("auto_accept_friend_invitation" .. Player._uuid, false)
		cc.UserDefault:getInstance():setBoolForKey("cannot_apply_as_friend" .. Player._uuid, false)
		cc.UserDefault:getInstance():setBoolForKey(string.format("voice_setting_%d_%s", ChatConstant.Position.kMainUnion, Player._uuid), true)
		cc.UserDefault:getInstance():setBoolForKey(string.format("voice_setting_%d_%s", ChatConstant.Position.kMainTeam, Player._uuid), true)
		cc.UserDefault:getInstance():setBoolForKey(string.format("voice_setting_%d_%s", ChatConstant.Position.kMainPrivate, Player._uuid), true)
		cc.UserDefault:getInstance():setBoolForKey("recommend_power_in_battle" .. Player._uuid, true)
	end
end
function SysSetting.playMusic(music_file, is_loop, from_custom)
	if is_loop == nil then
		is_loop = true
	end
	if not from_custom then
		SysSetting.s_sceneBGM = music_file
	end
	AudioEngine.playMusic(music_file, is_loop)
	if SysSetting.isCanPlayMusic() == false then
		AudioEngine.setMusicVolume(0)
		print("cannot play music")
	end
end

function SysSetting.stopEffect(handle)
	AudioEngine.stopEffect(handle)
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

function SysSetting.playDub(file, stopBeforeDub)
	if SysSetting.dubId and stopBeforeDub then
		SysSetting.stopEffect(SysSetting.dubId)
	end

	file = string.format("audio/%s/%s", SysSetting.getLang(), file)
	if cc.FileUtils:getInstance():isFileExist(file) then
		SysSetting.dubId = SysSetting.playEffect(file)
	else
		SysSetting.dubId = nil
	end
	return SysSetting.dubId
end

function SysSetting.isAcceptTeamInvite()
	return not cc.UserDefault:getInstance():getBoolForKey("not_accept_team_invitation" .. Player._uuid)
end
function SysSetting.isAutoAcceptFriendInvite()
	return cc.UserDefault:getInstance():getBoolForKey("auto_accept_friend_invitation" .. Player._uuid)
end
function SysSetting.cannotApplyAsFriend()
	return cc.UserDefault:getInstance():getBoolForKey("cannot_apply_as_friend" .. Player._uuid)
end
function SysSetting.canPlayVoice(ty)
	return cc.UserDefault:getInstance():getBoolForKey(string.format("voice_setting_%d_%s", ty, Player._uuid))
end
function SysSetting.isRecommendPowerInBattle()
	return cc.UserDefault:getInstance():getBoolForKey("recommend_power_in_battle" .. Player._uuid)
end
function SysSetting.getLang()
	local lang = cc.UserDefault:getInstance():getStringForKey("lang")
	if lang == nil or #lang == 0 then
        local lang_code = cc.Application:getInstance():getCurrentLanguage()
        
		lang =  SysSetting.getLangByCode(lang_code)
        if not lang then
            lang = E_Language[1]
        end
		return lang
	else
		if SysSetting.language == nil then
			return lang
		else
			return SysSetting.language
		end
	end
end
function SysSetting.getLangByCode(lang_code)
    local lang_str = ""
    if lang_code == cc.LANGUAGE_ENGLISH then
        lang_str = "en"
    elseif lang_code == cc.LANGUAGE_CHINESE then
        lang_str = "ch"
    elseif lang_code == 19 then
        lang_str = "th"
    end
    for k, v in ipairs(E_Language) do
        if v == lang_str then
            return v
        end
    end
end
function SysSetting.reloadText()
	LANG_TB = nil
	g_DirtyWords = nil

	package.loaded[string.format("deal_config.%s.language", SysSetting.language)] = nil
	myRequire(string.format("deal_config.%s.language", SysSetting.language))
	package.loaded[string.format("deal_config.%s.DirtyWords", SysSetting.language)] = nil
	myRequire(string.format("deal_config.%s.DirtyWords", SysSetting.language))
end

function SysSetting.setLang(ty, updateText)
	if ty == SysSetting.language then
		if updateText then
			SysSetting.reloadText()
		end
		return
	end

	SysSetting.language = ty

	cc.UserDefault:getInstance():setStringForKey("lang", ty)

	SysSetting.reloadText()

	local searchPaths = cc.FileUtils:getInstance():getSearchPaths()
	local count = #searchPaths

	for index = count, 1, -1 do
		local result = string.find(searchPaths[index], "res/lang/")
		if result ~= nil then
			table.remove(searchPaths, index)
		end
	end

	cc.FileUtils:getInstance():setSearchPaths(searchPaths)
	cc.FileUtils:getInstance():addSearchPath(string.format("res/lang/%s/", SysSetting.language))
	local download_path = cc.FileUtils:getInstance():getWritablePath() .. "download/"
	cc.FileUtils:getInstance():addSearchPath(string.format("%sres/lang/%s/", download_path, SysSetting.language), true)
    cc.FileUtils:getInstance():addSearchPath(string.format("%s%s", download_path, "res/lang/common"))
    cc.FileUtils:getInstance():addSearchPath("res/lang/common")
	K_DEFAULT_FONT = string.format("lang/%s/fzy4jw.ttf", SysSetting.language)
	tsixi.TLabel:setDefaultFont(K_DEFAULT_FONT)
	cc.SpriteFrameCache:getInstance():removeUnusedSpriteFrames()
	cc.Director:getInstance():getTextureCache():removeAllTextures()
end
AudioEngine.setMusicVolume(SysSetting.getSoundVolume())
AudioEngine.setEffectsVolume(SysSetting.getSoundVolume())
