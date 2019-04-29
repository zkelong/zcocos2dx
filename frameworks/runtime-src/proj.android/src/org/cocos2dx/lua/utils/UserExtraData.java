package org.cocos2dx.lua.utils;

public class UserExtraData {
	// public static final int TYPE_SELECT_SERVER = 1; //选择服务器
	public static final int TYPE_CREATE_ROLE = 1; // 创建角色
	public static final int TYPE_ENTER_GAME = 3; // 进入游戏
	public static final int TYPE_LEVEL_UP = 2; // 等级提升
	public static final int TYPE_EXIT_GAME = 5; // 退出游戏
	public static final int TYPE_ON_RECHARGE = 10; // 充值到帐
	public static final int TYPE_ON_EXCEPTION = 11; // lua出现异常

	private int dataType;
	private String roleID;
	private String roleName;
	private String roleLevel;
	private int serverID;
	private String serverName;
	private int moneyNum;
	private long roleCTime;
	private String m_extraData;

	public int getDataType() {
		return dataType;
	}

	public void setDataType(int dataType) {
		this.dataType = dataType;
	}

	public String getRoleID() {
		return roleID;
	}

	public void setRoleID(String roleID) {
		this.roleID = roleID;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleLevel() {
		return roleLevel;
	}

	public void setRoleLevel(String roleLevel) {
		this.roleLevel = roleLevel;
	}

	public int getServerID() {
		return serverID;
	}

	public void setServerID(int serverID) {
		this.serverID = serverID;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public int getMoneyNum() {
		return moneyNum;
	}

	public void setMoneyNum(int moneyNum) {
		this.moneyNum = moneyNum;
	}

	public long getRoleCTime() {
		return roleCTime;
	}

	public void setRoleCTime(long roleCTime) {
		this.roleCTime = roleCTime;
	}

	public String getExtraData() {
		return m_extraData;
	}

	public void setExtraData(String m_extraData) {
		this.m_extraData = m_extraData;
	}

}
