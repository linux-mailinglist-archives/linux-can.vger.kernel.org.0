Return-Path: <linux-can+bounces-2435-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76509F65B2
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 13:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5158F188268D
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BD1A23AB;
	Wed, 18 Dec 2024 12:17:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CC19A288
	for <linux-can@vger.kernel.org>; Wed, 18 Dec 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524250; cv=none; b=VmzVSYPzMOCI8qalV/tXbuAG3FWTUrItYIlNS15sJC46bXLfxGw5mIUj6Pk+2AarjVRTEWAMCgRPgB/Ra4G2ItN8MZhV3m94W5oSvexwc03CXA2KyUluNr3G4uLr+s+MHQeSJbckn48n9tbjhd1OtdlLIh5NQiKV77h/cbMzjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524250; c=relaxed/simple;
	bh=IpqxAPIsZx3w25GQdM2uw9JCEezPzauequ1qRCOnV4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYVatPQ9+H5EDliyb4kPxtgb1+YVqYkHFonUKnSSE5M7FsnAkWF11X0wKUdnRELtVotoGTNt6qmmYqEBfK6Lnq6k/mtV/4Bp450bfT/snqtc8fJ47COoSY/C4AJKJfWpHBHzbwzafUUxvrUlkCNmdS6d9eiqh18YWGIVyO3iNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNszW-0003Uj-NX
	for linux-can@vger.kernel.org; Wed, 18 Dec 2024 13:17:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNszV-0041vx-2Q
	for linux-can@vger.kernel.org;
	Wed, 18 Dec 2024 13:17:26 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3BC4F39168A
	for <linux-can@vger.kernel.org>; Wed, 18 Dec 2024 12:17:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 64CC5391677;
	Wed, 18 Dec 2024 12:17:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ac31a6d3;
	Wed, 18 Dec 2024 12:17:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/2] can: m_can: set init flag earlier in probe
Date: Wed, 18 Dec 2024 13:10:27 +0100
Message-ID: <20241218121722.2311963-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218121722.2311963-1-mkl@pengutronix.de>
References: <20241218121722.2311963-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

While an m_can controller usually already has the init flag from a
hardware reset, no such reset happens on the integrated m_can_pci of the
Intel Elkhart Lake. If the CAN controller is found in an active state,
m_can_dev_setup() would fail because m_can_niso_supported() calls
m_can_cccr_update_bits(), which refuses to modify any other configuration
bits when CCCR_INIT is not set.

To avoid this issue, set CCCR_INIT before attempting to modify any other
configuration flags.

Fixes: cd5a46ce6fa6 ("can: m_can: don't enable transceiver when probing")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://patch.msgid.link/e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 533bcb77c9f9..67c404fbe166 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1695,6 +1695,14 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
+	/* Write the INIT bit, in case no hardware reset has happened before
+	 * the probe (for example, it was observed that the Intel Elkhart Lake
+	 * SoCs do not properly reset the CAN controllers on reboot)
+	 */
+	err = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
+	if (err)
+		return err;
+
 	if (!cdev->is_peripheral)
 		netif_napi_add(dev, &cdev->napi, m_can_poll);
 
@@ -1746,11 +1754,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
-	/* Forcing standby mode should be redundant, as the chip should be in
-	 * standby after a reset. Write the INIT bit anyways, should the chip
-	 * be configured by previous stage.
-	 */
-	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
+	return 0;
 }
 
 static void m_can_stop(struct net_device *dev)

base-commit: 954a2b40719a21e763a1bba2f0da92347e058fce
-- 
2.45.2



