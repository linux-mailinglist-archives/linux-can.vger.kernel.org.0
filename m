Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF34671A43
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 12:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjARLQy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 06:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjARLQP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 06:16:15 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8607F9B5
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 02:30:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:4745:2e6d:e3a6:3327])
        by albert.telenet-ops.be with bizsmtp
        id AAWB2900J2zf9gW06AWBzF; Wed, 18 Jan 2023 11:30:12 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pI5hm-005aJQ-Ff;
        Wed, 18 Jan 2023 11:30:11 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pI5hr-001Jmq-PD;
        Wed, 18 Jan 2023 11:30:11 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: phy-can-transceiver: Skip warning if no "max-bitrate"
Date:   Wed, 18 Jan 2023 11:29:58 +0100
Message-Id: <88e158f97dd52ebaa7126cd9631f34764b9c0795.1674037334.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

According to the DT bindings, the "max-bitrate" property is optional.
However, when it is not present, a warning is printed.
Fix this by adding a missing check for -EINVAL.

Fixes: a4a86d273ff1b6f7 ("phy: phy-can-transceiver: Add support for generic CAN transceiver driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/phy/phy-can-transceiver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 95c6dbb52da720bf..ce511ad5d3690763 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -99,6 +99,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	u32 max_bitrate = 0;
+	int err;
 
 	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
 	if (!can_transceiver_phy)
@@ -124,8 +125,8 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(phy);
 	}
 
-	device_property_read_u32(dev, "max-bitrate", &max_bitrate);
-	if (!max_bitrate)
+	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
+	if ((err != -EINVAL) && !max_bitrate)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
 	phy->attrs.max_link_rate = max_bitrate;
 
-- 
2.34.1

