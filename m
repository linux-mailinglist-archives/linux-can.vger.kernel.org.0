Return-Path: <linux-can+bounces-2259-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D319DE660
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 13:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869CF164C76
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 12:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955319D8A4;
	Fri, 29 Nov 2024 12:27:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B019CD16
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883257; cv=none; b=biscd8dcHatenzNhWMAf+KUXiRxILlf8TirUqd/GWebpH94JcbOsGzmemWvoPhx4GWy8aPHCw0tF/ipshL+HqEUIgnB5GrLb0A9g2AGQKW7TgMskIf1Kty2JxKA43k1Iy8pa/Echs3nXPeD4Z8hqudk/+ifHB5E4EWJZu22Z4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883257; c=relaxed/simple;
	bh=6/608tDubOPvRZw50aMIPy4K1oH69byWhgujTZog154=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WptrDxlDMFEtGE+uxhggcCYse7NmgHD2HjA3/174h8BAlmFZCjrke7N1EcToLr7Rrh8fcmgs0HfoSCm0R9G6AMxfw18OPCHSz/mPVVTg83DmDtzLXRh8n32nkNIp53l6RTHiwr8jwtVMrQgarjsEbqJLB1Yaox+Kp/jkuCQ6uoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH05s-0007li-GU
	for linux-can@vger.kernel.org; Fri, 29 Nov 2024 13:27:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH05r-000mgn-0l
	for linux-can@vger.kernel.org;
	Fri, 29 Nov 2024 13:27:32 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id ABED838112D
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:27:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 182E4381104;
	Fri, 29 Nov 2024 12:27:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ced4dbfe;
	Fri, 29 Nov 2024 12:27:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/14] can: c_can: c_can_handle_bus_err(): update statistics if skb allocation fails
Date: Fri, 29 Nov 2024 13:16:50 +0100
Message-ID: <20241129122722.1046050-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129122722.1046050-1-mkl@pengutronix.de>
References: <20241129122722.1046050-1-mkl@pengutronix.de>
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

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Ensure that the statistics are always updated, even if the skb
allocation fails.

Fixes: 4d6d26537940 ("can: c_can: fix {rx,tx}_errors statistics")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20241122221650.633981-2-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_main.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index 511615dc3341..cc371d0c9f3c 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1014,49 +1014,57 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
-	if (unlikely(!skb))
-		return 0;
 
 	/* check for 'last error code' which tells us the
 	 * type of the last error to occur on the CAN bus
 	 */
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	if (likely(skb))
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 	switch (lec_type) {
 	case LEC_STUFF_ERROR:
 		netdev_dbg(dev, "stuff error\n");
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
 		stats->rx_errors++;
 		break;
 	case LEC_FORM_ERROR:
 		netdev_dbg(dev, "form error\n");
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_FORM;
 		stats->rx_errors++;
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 		stats->tx_errors++;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT1;
 		stats->tx_errors++;
 		break;
 	case LEC_BIT0_ERROR:
 		netdev_dbg(dev, "bit0 error\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT0;
 		stats->tx_errors++;
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		stats->rx_errors++;
 		break;
 	default:
 		break;
 	}
 
+	if (unlikely(!skb))
+		return 0;
+
 	netif_receive_skb(skb);
 	return 1;
 }
-- 
2.45.2



