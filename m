Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F202146B8EA
	for <lists+linux-can@lfdr.de>; Tue,  7 Dec 2021 11:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhLGK2m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Dec 2021 05:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhLGK20 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Dec 2021 05:28:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E828C061354
        for <linux-can@vger.kernel.org>; Tue,  7 Dec 2021 02:24:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1muXeY-0003QB-Nm
        for linux-can@vger.kernel.org; Tue, 07 Dec 2021 11:24:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 618E56BE8F3
        for <linux-can@vger.kernel.org>; Tue,  7 Dec 2021 10:24:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1F6CF6BE8B3;
        Tue,  7 Dec 2021 10:24:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 06a34a1f;
        Tue, 7 Dec 2021 10:24:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 8/9] can: m_can: make custom bittiming fields const
Date:   Tue,  7 Dec 2021 11:24:19 +0100
Message-Id: <20211207102420.120131-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207102420.120131-1-mkl@pengutronix.de>
References: <20211207102420.120131-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

The assigned timing structs will be defined a const anyway, so we can
avoid a few casts by declaring the struct fields as const as well.

Link: https://lore.kernel.org/all/4508fa4e639164b2584c49a065d90c78a91fa568.1636967198.git.matthias.schiffer@ew.tq-group.com
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index ad063b101411..2c5d40997168 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -85,8 +85,8 @@ struct m_can_classdev {
 	struct sk_buff *tx_skb;
 	struct phy *transceiver;
 
-	struct can_bittiming_const *bit_timing;
-	struct can_bittiming_const *data_timing;
+	const struct can_bittiming_const *bit_timing;
+	const struct can_bittiming_const *data_timing;
 
 	struct m_can_ops *ops;
 
-- 
2.33.0


