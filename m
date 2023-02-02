Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863DD687B9E
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjBBLJM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjBBLJJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE229EEC
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSh-0006uq-AB
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:09:03 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C4D1616D2E8
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:08:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 244D916D28D;
        Thu,  2 Feb 2023 11:08:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1f07d2f8;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 08/17] can: netlink: can_changelink(): convert from netdev_err() to NL_SET_ERR_MSG_FMT()
Date:   Thu,  2 Feb 2023 12:08:45 +0100
Message-Id: <20230202110854.2318594-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202110854.2318594-1-mkl@pengutronix.de>
References: <20230202110854.2318594-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit 51c352bdbcd2 ("netlink: add support for formatted extack
messages") formatted extack messages are supported to inform the user
space or warnings/errors during netlink calls.

Replace the netdev_err() by NL_SET_ERR_MSG_FMT() to better inform the
user about the problem. While there, use %u to print unsigned values
and improve error message a bit.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 02f5c00c521f..a03b45a020b9 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -220,8 +220,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			return err;
 
 		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
-			netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
-				   priv->bitrate_max);
+			NL_SET_ERR_MSG_FMT(extack,
+					   "arbitration bitrate %u bps surpasses transceiver capabilities of %u bps",
+					   bt.bitrate, priv->bitrate_max);
 			return -EINVAL;
 		}
 
@@ -324,8 +325,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			return err;
 
 		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
-			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
-				   priv->bitrate_max);
+			NL_SET_ERR_MSG_FMT(extack,
+					   "CANFD data bitrate %u bps surpasses transceiver capabilities of %u bps",
+					   dbt.bitrate, priv->bitrate_max);
 			return -EINVAL;
 		}
 
-- 
2.39.1


