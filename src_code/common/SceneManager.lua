SceneManager = SceneManager or { }



function SceneManager:getCurrentScene()
    if self.scene and self.scene.addChild then
		return self.scene
	else
		return cc.Director:getInstance():getRunningScene()
	end
end