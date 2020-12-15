Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49342DB773
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgLPABV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgLOXZL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:25:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC2C0617A7
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:18:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJZv-0002Uh-53
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:17:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7E98F5AE3CB
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 182695AE3A0;
        Tue, 15 Dec 2020 23:17:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 305a9327;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 03/16] can: tcan4x5x: rename tcan4x5x.c -> tcan4x5x-core.c
Date:   Wed, 16 Dec 2020 00:17:33 +0100
Message-Id: <20201215231746.1132907-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215231746.1132907-1-mkl@pengutronix.de>
References: <20201215231746.1132907-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a preparation patch to move the regmap related code into a seperate
file. This patch removes the tcan4x5x.c to tcan4x5x-core.c.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/Makefile                        | 3 +++
 drivers/net/can/m_can/{tcan4x5x.c => tcan4x5x-core.c} | 0
 2 files changed, 3 insertions(+)
 rename drivers/net/can/m_can/{tcan4x5x.c => tcan4x5x-core.c} (100%)

diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
index ef7963ff2006..91f9190dc007 100644
--- a/drivers/net/can/m_can/Makefile
+++ b/drivers/net/can/m_can/Makefile
@@ -7,3 +7,6 @@ obj-$(CONFIG_CAN_M_CAN) += m_can.o
 obj-$(CONFIG_CAN_M_CAN_PCI) += m_can_pci.o
 obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
 obj-$(CONFIG_CAN_M_CAN_TCAN4X5X) += tcan4x5x.o
+
+tcan4x5x-objs :=
+tcan4x5x-objs += tcan4x5x-core.o
diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x-core.c
similarity index 100%
rename from drivers/net/can/m_can/tcan4x5x.c
rename to drivers/net/can/m_can/tcan4x5x-core.c
-- 
2.29.2


