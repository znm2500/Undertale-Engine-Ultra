[English](#undertale-engine-ultra-english-version) | [中文](#undertale-engine-ultra-中文版)

---

## Undertale Engine Ultra (English Version)

This is an open-source game engine built with [GameMaker Studio 2](https://www.yoyogames.com/en/gamemaker), aiming to replicate the core mechanics and style of the famous RPG, *Undertale*.

**This project is based on, improved, and extended from TML's [UndertaleEngine](https://github.com/TML233/UndertaleEngine).**

Developers can use this engine as a foundation to create their own *Undertale* fan games or to study its internal workings.

### Features

Based on the current project structure, this engine includes the following features:

*   **Advanced Battle System**:
    *   Turn-based battle flow (`battle_turn`).
    *   Bullet hell attacks (`battle_bullet`, `battle_bullet_bone`, `battle_bullet_gb`).
    *   Flexible battle board (`battle_board`) with support for various shapes.
    *   FIGHT, ACT, ITEM, MERCY menus (`battle_button`).
    *   Multiple SOUL modes (`battle_soul_red`, `_blue`, `_green`, etc.).
    *   Enemy dialogue system (`battle_dialog_enemy`).

*   **Dialogue & Text System**:
    *   Classic typewriter effect (`text_typer`).
    *   Customizable character portraits (`face_sans`).
    *   UI dialog boxes (`ui_dialog`).

*   **Overworld & Interaction**:
    *   Character movement (`char_player`).
    *   Save points (`char_save`).
    *   Room transitions (`trigger_warp`).

*   **Shop System**:
    *   Complete shop interaction logic (`shop`, `shop_dialog`, `shop_host`).

*   **UI & Menus**:
    *   Main menu (`room_menu`).
    *   Game over screen (`room_gameover`).
    *   Settings menu (`room_settings`).

### Tech Stack

*   **Engine:** GameMaker Studio 2 (v2.3.0 or higher recommended)
*   **Language:** GameMaker Language (GML)

### Getting Started

1.  Ensure you have the latest version of [GameMaker Studio 2](https://www.yoyogames.com/en/gamemaker) installed.
2.  Clone or download this repository to your local machine.
3.  In GameMaker Studio 2, select "Import Project".
4.  Navigate to and open the `UNDERTALE Engine Ultra.yyp` file in the project root.
5.  Click the "Run" button (F5) in the IDE to compile and run the game.

### Project Structure
```
.
├───fonts/         # Game fonts
├───objects/       # All game objects (characters, enemies, UI elements, etc.)
├───rooms/         # Game scenes/levels
├───scripts/       # GML scripts and function libraries
├───sounds/        # Sound effects and music
├───sprites/       # Sprites and animation assets
└───UNDERTALE Engine Ultra.yyp # GameMaker project file
```

### How to Contribute

All forms of contribution are welcome! If you find a bug, have a feature suggestion, or want to improve the code, feel free to:

*   Join our QQ group for discussions: **964060828**
*   Fork the repository and open a Pull Request.

### Disclaimer

This project is an unofficial fan creation for educational and entertainment purposes only.
The rights to *Undertale* and all its related characters, music, and assets belong to its creator, **Toby Fox**.
Please support the official game.

---

## Undertale Engine Ultra (中文版)

这是一个使用 [GameMaker Studio 2](https://www.yoyogames.com/en/gamemaker) 构建的开源游戏引擎，旨在复刻著名 RPG 游戏《Undertale》的核心机制和风格。

**本项目基于 TML 的 [UndertaleEngine](https://github.com/TML233/UndertaleEngine) 并加以改进和扩展。**

开发者可以利用这个引擎作为基础，来创建自己的《Undertale》同人游戏或学习其内部工作原理。

### 主要功能 (Features)

根据现有项目结构，本引擎包含了以下功能：

*   **高级战斗系统 (Advanced Battle System)**:
    *   回合制战斗流程 (`battle_turn`)。
    *   弹幕攻击 (`battle_bullet`, `battle_bullet_bone`, `battle_bullet_gb`)。
    *   灵活的战斗面板 (`battle_board`)，支持多种形状。
    *   FIGHT, ACT, ITEM, MERCY 菜单 (`battle_button`)。
    *   SOUL（灵魂）的多种模式 (`battle_soul_red`, `_blue`, `_green` 等)。
    *   敌人对话系统 (`battle_dialog_enemy`)。

*   **对话和文本系统 (Dialogue & Text System)**:
    *   经典的打字机效果 (`text_typer`)。
    *   可定制的角色头像 (`face_sans`)。
    *   UI 对话框 (`ui_dialog`)。

*   **世界地图与交互 (Overworld & Interaction)**:
    *   角色移动 (`char_player`)。
    *   存档点 (`char_save`)。
    *   场景切换 (`trigger_warp`)。

*   **商店系统 (Shop System)**:
    *   完整的商店交互逻辑 (`shop`, `shop_dialog`, `shop_host`)。

*   **UI & 菜单 (UI & Menus)**:
    *   主菜单 (`room_menu`)。
    *   游戏结束界面 (`room_gameover`)。
    *   设置菜单 (`room_settings`)。

### 技术栈 (Tech Stack)

*   **引擎 (Engine):** GameMaker Studio 2 (v2.3.0 or higher recommended)
*   **语言 (Language):** GameMaker Language (GML)

### 如何开始 (Getting Started)

1.  确保您已安装最新版本的 [GameMaker Studio 2](https://www.yoyogames.com/en/gamemaker)。
2.  克隆或下载此仓库到您的本地计算机。
3.  在 GameMaker Studio 2 中，选择 "Import Project"。
4.  找到并打开项目根目录下的 `UNDERTALE Engine Ultra.yyp` 文件。
5.  点击 IDE 右上角的 "Run" 按钮 (F5) 来编译和运行游戏。

### 项目结构 (Project Structure)
```
.
├───fonts/         # 游戏字体
├───objects/       # 所有游戏对象 (角色, 敌人, UI元素等)
├───rooms/         # 游戏场景/关卡
├───scripts/       # GML 脚本和函数库
├───sounds/        # 音效和背景音乐
├───sprites/       # 精灵和动画资源
└───UNDERTALE Engine Ultra.yyp # GameMaker project file
```

### 如何贡献 (How to Contribute)

我们欢迎任何形式的贡献！如果您发现了 Bug、有新的功能建议或想要改进代码，请随时：

*   加入我们的 QQ 交流群: **964060828**
*   Fork 本仓库并发起 Pull Request。

### 免责声明 (Disclaimer)

本项目是一个非官方的粉丝创作，仅用于学习和娱乐目的。
《Undertale》及其所有相关角色、音乐和设定的权利均属于其创作者 **Toby Fox**。
请支持正版游戏。
