// 根据用户选择决定是否执行初始化脚本
if (variable::get("init-script")) {
    print("🚀 开始执行初始化脚本(开发环境)...");

    let result = system::command("../install.sh");

    print(result);

}
