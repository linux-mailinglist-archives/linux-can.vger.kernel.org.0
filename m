Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F334549A751
	for <lists+linux-can@lfdr.de>; Tue, 25 Jan 2022 03:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbiAYChQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jan 2022 21:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2371569AbiAYAIl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jan 2022 19:08:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD3C0885A9
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 13:56:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nC7KR-0003Yq-5p
        for linux-can@vger.kernel.org; Mon, 24 Jan 2022 22:56:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BB39521382
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id AB4A82137C;
        Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 25fd6233;
        Mon, 24 Jan 2022 21:56:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dariobin@libero.it>
Subject: [PATCH 9/9] can: c_can: ethtool: use default drvinfo
Date:   Mon, 24 Jan 2022 22:56:42 +0100
Message-Id: <20220124215642.3474154-10-mkl@pengutronix.de>
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

The ethtool core implements a default drvinfo.

There's no need to replicate this in the driver, no additional
information is added, so remove this and rely on the default.

Cc: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_ethtool.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_ethtool.c b/drivers/net/can/c_can/c_can_ethtool.c
index 6655146294fc..8a826a6813bd 100644
--- a/drivers/net/can/c_can/c_can_ethtool.c
+++ b/drivers/net/can/c_can/c_can_ethtool.c
@@ -11,14 +11,6 @@
 
 #include "c_can.h"
 
-static void c_can_get_drvinfo(struct net_device *netdev,
-			      struct ethtool_drvinfo *info)
-{
-	struct c_can_priv *priv = netdev_priv(netdev);
-	strscpy(info->driver, "c_can", sizeof(info->driver));
-	strscpy(info->bus_info, dev_name(priv->device), sizeof(info->bus_info));
-}
-
 static void c_can_get_ringparam(struct net_device *netdev,
 				struct ethtool_ringparam *ring,
 				struct kernel_ethtool_ringparam *kernel_ring,
@@ -33,7 +25,6 @@ static void c_can_get_ringparam(struct net_device *netdev,
 }
 
 static const struct ethtool_ops c_can_ethtool_ops = {
-	.get_drvinfo = c_can_get_drvinfo,
 	.get_ringparam = c_can_get_ringparam,
 };
 
-- 
2.34.1


