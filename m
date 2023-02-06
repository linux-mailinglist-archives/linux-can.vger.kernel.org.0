Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE46F68BDE8
	for <lists+linux-can@lfdr.de>; Mon,  6 Feb 2023 14:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjBFNUa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Feb 2023 08:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjBFNUP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Feb 2023 08:20:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287AE25BBB
        for <linux-can@vger.kernel.org>; Mon,  6 Feb 2023 05:18:52 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pP1OQ-0001y9-SD
        for linux-can@vger.kernel.org; Mon, 06 Feb 2023 14:18:46 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 48DAA171558
        for <linux-can@vger.kernel.org>; Mon,  6 Feb 2023 13:16:30 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7CDEF17130D;
        Mon,  6 Feb 2023 13:16:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ae8af2d7;
        Mon, 6 Feb 2023 13:16:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 36/47] can: dev: register_candev(): bail out if both fixed bit rates and bit timing constants are provided
Date:   Mon,  6 Feb 2023 14:16:09 +0100
Message-Id: <20230206131620.2758724-37-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206131620.2758724-1-mkl@pengutronix.de>
References: <20230206131620.2758724-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CAN driver framework supports either fixed bit rates or bit timing
constants. Bail out during driver registration if both are given.

Link: https://lore.kernel.org/all/20230202110854.2318594-7-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3b51055be40e..7f9334a8af50 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -530,6 +530,11 @@ int register_candev(struct net_device *dev)
 	if (!priv->data_bitrate_const != !priv->data_bitrate_const_cnt)
 		return -EINVAL;
 
+	/* We only support either fixed bit rates or bit timing const. */
+	if ((priv->bitrate_const || priv->data_bitrate_const) &&
+	    (priv->bittiming_const || priv->data_bittiming_const))
+		return -EINVAL;
+
 	if (!can_bittiming_const_valid(priv->bittiming_const) ||
 	    !can_bittiming_const_valid(priv->data_bittiming_const))
 		return -EINVAL;
-- 
2.39.1


