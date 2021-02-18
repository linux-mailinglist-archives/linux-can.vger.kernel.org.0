Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4A31F1DC
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 22:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBRVzV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 16:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBRVzU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Feb 2021 16:55:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA3C0613D6
        for <linux-can@vger.kernel.org>; Thu, 18 Feb 2021 13:54:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lCrFv-0000kl-1l
        for linux-can@vger.kernel.org; Thu, 18 Feb 2021 22:54:39 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7A51F5E44EE
        for <linux-can@vger.kernel.org>; Thu, 18 Feb 2021 21:54:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A627B5E44E3;
        Thu, 18 Feb 2021 21:54:36 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 549f0e67;
        Thu, 18 Feb 2021 21:54:35 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [net-rfc 1/2] can: isotp: isotp_setsockopt(): only allow to set low level TX flags for CAN-FD
Date:   Thu, 18 Feb 2021 22:54:33 +0100
Message-Id: <20210218215434.1708249-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218215434.1708249-1-mkl@pengutronix.de>
References: <20210218215434.1708249-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

CAN-FD frames have struct canfd_frame::flags, while classic CAN frames
don't.

This patch refuses to set TX flags (struct
can_isotp_ll_options::tx_flags) on non CAN-FD isotp sockets.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 3ef7f78e553b..e32d446c121e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1228,7 +1228,8 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 			if (ll.mtu != CAN_MTU && ll.mtu != CANFD_MTU)
 				return -EINVAL;
 
-			if (ll.mtu == CAN_MTU && ll.tx_dl > CAN_MAX_DLEN)
+			if (ll.mtu == CAN_MTU &&
+			    (ll.tx_dl > CAN_MAX_DLEN || ll.tx_flags != 0))
 				return -EINVAL;
 
 			memcpy(&so->ll, &ll, sizeof(ll));

base-commit: 3af409ca278d4a8d50e91f9f7c4c33b175645cf3
-- 
2.30.0


