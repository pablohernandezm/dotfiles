local config = {
	name = "jdtls",
	cmd = { "jdtls" },
	root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),

	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {},
	},

	init_options = {
		bundles = {
			vim.fn.glob("/usr/share/java-debug/com.microsoft.java.debug.plugin.jar", 1),
		},
	},
}
require("jdtls").start_or_attach(config)
