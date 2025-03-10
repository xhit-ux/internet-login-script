# **井冈山大学网络登陆验证一键运行脚本（PowerShell 版）**  

## **📌 说明**  
本脚本适用于 **Windows 设备**，用于在校园网络环境下自动完成**网络认证登录**。  
**请确保已连接到校园 Wi-Fi**，然后执行本脚本完成登录。  

---

## **📥 使用步骤**  

### **1️⃣ 下载脚本**  
- 复制以下 PowerShell 代码，并保存为 `login.ps1` 文件。  
- 执行以下命令将脚本移动至桌面：

```cmd
git clone https://github.com/xhit-ux/internet-login-script.git
cd ./internet-login-script
move .\logins.ps1 "$env:USERPROFILE\Desktop"
cd ..
del ./internet-login-script

```
### **2️⃣ 编辑脚本**
- 在**桌面**上找到并左键双击打开`logins.ps1`
- **找到** `user_account` 和 `user_password` 字段，在引号内填入你的 **账号** 和 **密码**。  

```powershell
$user_account=""   # 👈 在此填写学号
$user_password=""  # 👈 在此填写密码
```

### **3️⃣ 运行脚本**
- 右键文件，找到并点击`使用powershell运行`

---
## **❌ 常见问题**
### 允许 PowerShell 运行脚本
**由于 Windows 默认不允许执行 PowerShell 脚本，你需要临时解除限制。**

- **方式 1：临时绕过 PowerShell 限制(安全系数++)**  
  - 打开 命令提示符（cmd），输入以下命令并回车：
    ```cmd
     powershell -ExecutionPolicy Bypass -File login.ps1
    ```
    🎯 作用：这只会影响当前命令，不会修改系统安全策略。

- **方式 2：永久允许运行脚本（需管理员权限）**  
如果你不想每次都输入 Bypass，可以 **永久修改 PowerShell 执行策略**：

  - **右键**「开始菜单」> 选择 **Windows PowerShell（管理员）**
  - 输入以下命令并回车：
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```
  - 之后你可以选择:
    -  **直接双击** login.ps1 运行
    - 在**桌面**右键选择 `在终端中打开` 并执行以下命令:
      ```powershell
      ./logins.ps1
      ```
      即可运行
