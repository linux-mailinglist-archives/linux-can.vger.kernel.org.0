Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547902DB76E
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgLPAB0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgLOXZf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:25:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD2C0617A6
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:17:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJZu-0002TT-3w
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:17:58 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4537B5AE3C7
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EC1015AE39E;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 08c70e3f;
        Tue, 15 Dec 2020 23:17:48 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 01/16] can: tcan4x5x: replace DEVICE_NAME by KBUILD_MODNAME
Date:   Wed, 16 Dec 2020 00:17:31 +0100
Message-Id: <20201215231746.1132907-2-mkl@pengutronix.de>
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

This patch replaces the DEVICE_NAME macro by KBUILD_MODNAME and removed the
superfluous DEVICE_NAME.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 24c737c4fc44..1b5f706674af 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -10,7 +10,6 @@
 
 #include "m_can.h"
 
-#define DEVICE_NAME "tcan4x5x"
 #define TCAN4X5X_EXT_CLK_DEF 40000000
 
 #define TCAN4X5X_DEV_ID0 0x00
@@ -132,7 +131,7 @@ static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
 }
 
 static struct can_bittiming_const tcan4x5x_bittiming_const = {
-	.name = DEVICE_NAME,
+	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,
 	.tseg1_max = 31,
 	.tseg2_min = 2,
@@ -144,7 +143,7 @@ static struct can_bittiming_const tcan4x5x_bittiming_const = {
 };
 
 static struct can_bittiming_const tcan4x5x_data_bittiming_const = {
-	.name = DEVICE_NAME,
+	.name = KBUILD_MODNAME,
 	.tseg1_min = 1,
 	.tseg1_max = 32,
 	.tseg2_min = 1,
@@ -544,7 +543,7 @@ MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
 
 static struct spi_driver tcan4x5x_can_driver = {
 	.driver = {
-		.name = DEVICE_NAME,
+		.name = KBUILD_MODNAME,
 		.of_match_table = tcan4x5x_of_match,
 		.pm = NULL,
 	},

base-commit: efd5a1584537698220578227e6467638307c2a0b
-- 
2.29.2


