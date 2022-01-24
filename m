Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE7749A748
	for <lists+linux-can@lfdr.de>; Tue, 25 Jan 2022 03:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352199AbiAYCgq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jan 2022 21:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2371537AbiAYAIa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jan 2022 19:08:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE51C07E5FF
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 13:56:47 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nC7KQ-0003Xy-4R
        for linux-can@vger.kernel.org; Mon, 24 Jan 2022 22:56:46 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 91A2821371
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6F06821364;
        Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 49c1b805;
        Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/9] can: bittiming: can_validate_bitrate(): simplify bit rate checking
Date:   Mon, 24 Jan 2022 22:56:38 +0100
Message-Id: <20220124215642.3474154-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124215642.3474154-1-mkl@pengutronix.de>
References: <20220124215642.3474154-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch simplifies the validation of the fixed bit rates. If a
supported bit rate is found, directly return 0.

If no valid bit rate is found return -EINVAL;

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/bittiming.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index d5fca3bfaf9a..1b1d1499e2f1 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -248,18 +248,14 @@ can_validate_bitrate(struct net_device *dev, struct can_bittiming *bt,
 		     const u32 *bitrate_const,
 		     const unsigned int bitrate_const_cnt)
 {
-	struct can_priv *priv = netdev_priv(dev);
 	unsigned int i;
 
 	for (i = 0; i < bitrate_const_cnt; i++) {
 		if (bt->bitrate == bitrate_const[i])
-			break;
+			return 0;
 	}
 
-	if (i >= priv->bitrate_const_cnt)
-		return -EINVAL;
-
-	return 0;
+	return -EINVAL;
 }
 
 int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
-- 
2.34.1


