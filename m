Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8063056A4
	for <lists+linux-can@lfdr.de>; Wed, 27 Jan 2021 10:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhA0JQt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jan 2021 04:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhA0JPM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jan 2021 04:15:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8EC061574
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 01:14:31 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l4gbs-0002nM-LX
        for linux-can@vger.kernel.org; Wed, 27 Jan 2021 09:55:32 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 890605CF024
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 08:55:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EB7E55CF01D;
        Wed, 27 Jan 2021 08:55:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id af6be69f;
        Wed, 27 Jan 2021 08:55:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: gw: fix typo
Date:   Wed, 27 Jan 2021 09:55:29 +0100
Message-Id: <20210127085529.2768537-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127085529.2768537-1-mkl@pengutronix.de>
References: <20210127085529.2768537-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes a typo found by codespell.

Fixes: 94c23097f991 ("can: gw: support modification of Classical CAN DLCs")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/gw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 8598d9da0e5f..ba4124805602 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -225,7 +225,7 @@ static void mod_store_ccdlc(struct canfd_frame *cf)
 	if (ccf->len <= CAN_MAX_DLEN)
 		return;
 
-	/* potentially broken values are catched in can_can_gw_rcv() */
+	/* potentially broken values are caught in can_can_gw_rcv() */
 	if (ccf->len > CAN_MAX_RAW_DLC)
 		return;
 
-- 
2.29.2


