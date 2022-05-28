Config = {
	DiscordToken = "ODQ1NDUzODM3ODk2NjQ2NzI2.YKhMPg.IvWCTCPrbdFAwk1UBy4tMoUv1Xs",
	GuildId = "845451161259868201",

	-- Format: ["Role Nickname"] = "Role ID" You can get role id by doing \@RoleName
	Roles = {
		["TestRole"] = "Some Role ID" -- This would be checked by doing exports.discord_perms:IsRolePresent(user, "TestRole")
	}
}
