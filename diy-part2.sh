#!/bin/bash
#=================================================
# Description: DIY script for ImmortalWrt build
#=================================================

# 1. 修改 HomeProxy 依赖为 sing-box-full（支持 Clash API）
find package -path "*luci-app-homeproxy/Makefile" -exec sed -i 's/+sing-box/+sing-box-full/g' {} \;

# 2. 生成基础配置
rm -f .config
make defconfig

# 3. 添加自定义软件包
echo "CONFIG_TARGET_mediatek=y" >> .config
echo "CONFIG_TARGET_mediatek_filogic=y" >> .config
echo "CONFIG_TARGET_mediatek_filogic_DEVICE_h3c_magic-nx30-pro=y" >> .config

echo "CONFIG_PACKAGE_luci=y" >> .config
echo "CONFIG_PACKAGE_luci-ssl=y" >> .config
echo "CONFIG_PACKAGE_luci-app-homeproxy=y" >> .config
echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config
echo "CONFIG_PACKAGE_ttyd=y" >> .config
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> .config
echo "CONFIG_PACKAGE_kmod-mtd-rw=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-homeproxy-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-openclash-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-argon-config-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-ttyd-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_sing-box-full=y" >> .config
echo "CONFIG_PACKAGE_zram-swap=y" >> .config

# 4. 应用配置
make defconfig
