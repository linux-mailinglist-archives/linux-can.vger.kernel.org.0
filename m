Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459B13DA248
	for <lists+linux-can@lfdr.de>; Thu, 29 Jul 2021 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhG2Lj0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Jul 2021 07:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhG2LjY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jul 2021 07:39:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED452C061765
        for <linux-can@vger.kernel.org>; Thu, 29 Jul 2021 04:39:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m94Nk-00048T-Es
        for linux-can@vger.kernel.org; Thu, 29 Jul 2021 13:39:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 99E4265ADE2
        for <linux-can@vger.kernel.org>; Thu, 29 Jul 2021 11:39:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2BA9465ADDE;
        Thu, 29 Jul 2021 11:39:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 563704b7;
        Thu, 29 Jul 2021 11:39:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: j1939: j1939_session_tx_dat(): fix typo
Date:   Thu, 29 Jul 2021 13:39:17 +0200
Message-Id: <20210729113917.1655492-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes a typo in the j1939_session_tx_dat() function.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index efdf79de3db6..b28c22d30686 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -822,7 +822,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 		memcpy(&dat[1], &tpdat[offset], len);
 		ret = j1939_tp_tx_dat(session, dat, len + 1);
 		if (ret < 0) {
-			/* ENOBUS == CAN interface TX queue is full */
+			/* ENOBUFS == CAN interface TX queue is full */
 			if (ret != -ENOBUFS)
 				netdev_alert(priv->ndev,
 					     "%s: 0x%p: queue data error: %i\n",
-- 
2.30.2


