Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BEA4A3EBD
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 09:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbiAaImc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 03:42:32 -0500
Received: from dd15738.kasserver.com ([85.13.151.39]:56568 "EHLO
        dd15738.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiAaImc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 03:42:32 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jan 2022 03:42:31 EST
Received: from dd15738.kasserver.com (dd0802.kasserver.com [85.13.143.1])
        by dd15738.kasserver.com (Postfix) with ESMTPSA id 122C45B0007E;
        Mon, 31 Jan 2022 09:33:04 +0100 (CET)
Subject: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
To:     linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de
From:   petter@ka-long.de
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 95.223.83.221
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20220131083304.122C45B0007E@dd15738.kasserver.com>
Date:   Mon, 31 Jan 2022 09:33:04 +0100 (CET)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Folks,

I am working on an IMX7D board. Some time ago I have back-ported the MCP2518FD driver to the official 5.4.70 NXP kernel and it works fine.

I am struggleing to get the mcp driver working on the latest nxp kernel 5.10.72.

Same hardware.

I did not find any unusal in the logs. pinctrl did not complain, spi seems to initialize normal.

The old kernel with the new (almost old one) device tree works. The new kernel did not work with the old or new device tree.

At the moment I am stuck. Could be anything. Must not be the driver itself.

BR
Niels



        mcp2518fd_clk: mcp2818fd_clk {
                compatible = "fixed-clock";
                #clock-cells = <0>;
                clock-frequency = <40000000>;
        };


&ecspi2 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_ecspi2>;
        status = "okay";

        fsl,spi-num-chipselects = <2>;
        cs-gpios = <&gpio5 1 0>, <&gpio1 3 0>;

        mcp2518fd@0 {
                compatible = "microchip,mcp2518fd";
                reg = <0>;
                interrupts-extended = <&gpio3 0 IRQ_TYPE_LEVEL_LOW>;
                spi-max-frequency = <20000000>;
                clocks = <&mcp2518fd_clk>;
        };

        mcp2518fd@1 {
                compatible = "microchip,mcp2518fd";
                reg = <1>;
                interrupts-extended = <&gpio4 23 IRQ_TYPE_LEVEL_LOW>;
                spi-max-frequency = <20000000>;
                clocks = <&mcp2518fd_clk>;
        };
};
