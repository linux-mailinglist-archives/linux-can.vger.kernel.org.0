Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D57C36AC74
	for <lists+linux-can@lfdr.de>; Mon, 26 Apr 2021 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhDZGzl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Apr 2021 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhDZGzk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Apr 2021 02:55:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B033CC061756
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 23:54:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lav90-0003zY-AJ
        for linux-can@vger.kernel.org; Mon, 26 Apr 2021 08:54:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 82038616F80
        for <linux-can@vger.kernel.org>; Mon, 26 Apr 2021 06:54:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 498B3616F6A;
        Mon, 26 Apr 2021 06:54:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 199e4ce4;
        Mon, 26 Apr 2021 06:54:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Colin Ian King <colin.king@canonical.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 2/4] can: etas_es58x: Fix a couple of spelling mistakes
Date:   Mon, 26 Apr 2021 08:54:50 +0200
Message-Id: <20210426065452.3411360-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210426065452.3411360-1-mkl@pengutronix.de>
References: <20210426065452.3411360-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in netdev_dbg and netdev_dbg messages,
fix these.

Link: https://lore.kernel.org/r/20210415113050.1942333-1-colin.king@canonical.com
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 57e5f94468e9..8e9102482c52 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -688,7 +688,7 @@ int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
 
 	case ES58X_ERR_PROT_STUFF:
 		if (net_ratelimit())
-			netdev_dbg(netdev, "Error BITSUFF\n");
+			netdev_dbg(netdev, "Error BITSTUFF\n");
 		if (cf)
 			cf->data[2] |= CAN_ERR_PROT_STUFF;
 		break;
@@ -1015,7 +1015,7 @@ int es58x_rx_cmd_ret_u32(struct net_device *netdev,
 			int ret;
 
 			netdev_warn(netdev,
-				    "%s: channel is already opened, closing and re-openning it to reflect new configuration\n",
+				    "%s: channel is already opened, closing and re-opening it to reflect new configuration\n",
 				    ret_desc);
 			ret = ops->disable_channel(es58x_priv(netdev));
 			if (ret)
-- 
2.30.2


