Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87423EF309
	for <lists+linux-can@lfdr.de>; Tue, 17 Aug 2021 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhHQUFU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Aug 2021 16:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhHQUFU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Aug 2021 16:05:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F31C061764
        for <linux-can@vger.kernel.org>; Tue, 17 Aug 2021 13:04:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mG5KH-0000Iv-BQ
        for linux-can@vger.kernel.org; Tue, 17 Aug 2021 22:04:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8E24F669247
        for <linux-can@vger.kernel.org>; Tue, 17 Aug 2021 20:04:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2B7B2669245;
        Tue, 17 Aug 2021 20:04:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dc359313;
        Tue, 17 Aug 2021 20:04:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: netlink: can_tdc_changelink(): assign tdc only after complete validation
Date:   Tue, 17 Aug 2021 22:04:41 +0200
Message-Id: <20210817200441.434270-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Feel free to squash into you series.

Marc

 drivers/net/can/dev/netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index ba644f120573..f16a98998f45 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -109,7 +109,7 @@ static int can_tdc_changelink(struct net_device *dev, const struct nlattr *nla,
 {
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_priv *priv = netdev_priv(dev);
-	struct can_tdc *tdc = &priv->tdc;
+	struct can_tdc tdc = { };
 	const struct can_tdc_const *tdc_const = priv->tdc_const;
 	int err;
 
@@ -130,7 +130,7 @@ static int can_tdc_changelink(struct net_device *dev, const struct nlattr *nla,
 		if (tdcv < tdc_const->tdcv_min || tdcv > tdc_const->tdcv_max)
 			return -EINVAL;
 
-		tdc->tdcv = tdcv;
+		tdc.tdcv = tdcv;
 	}
 
 	if (tb_tdc[IFLA_CAN_TDC_TDCO]) {
@@ -139,7 +139,7 @@ static int can_tdc_changelink(struct net_device *dev, const struct nlattr *nla,
 		if (tdco < tdc_const->tdco_min || tdco > tdc_const->tdco_max)
 			return -EINVAL;
 
-		tdc->tdco = tdco;
+		tdc.tdco = tdco;
 	}
 
 	if (tb_tdc[IFLA_CAN_TDC_TDCF]) {
@@ -148,9 +148,11 @@ static int can_tdc_changelink(struct net_device *dev, const struct nlattr *nla,
 		if (tdcf < tdc_const->tdcf_min || tdcf > tdc_const->tdcf_max)
 			return -EINVAL;
 
-		tdc->tdcf = tdcf;
+		tdc.tdcf = tdcf;
 	}
 
+	priv->tdc = tdc;
+
 	return 0;
 }
 
-- 
2.32.0


