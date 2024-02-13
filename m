Return-Path: <linux-can+bounces-251-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619DB852F7E
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 12:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D2B28A5F5
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 11:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376A39AF0;
	Tue, 13 Feb 2024 11:34:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4508E37167
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824091; cv=none; b=NP8ftIPBAo02aOyqIBO35buQt77rupDFHtM0PlzLdwddrrK5x22/NOm+605+EYJqY/11VhMN1sPE2RfT3psvwR7QVA4luZzliICoqrMnOSudI90sEisy7PvgOMfL0uL9qPWW8FI+E6Vco/4j+vq0ICEEli9f7+HFMiuNyEjILr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824091; c=relaxed/simple;
	bh=t0Y8CpeDu5U5jiEMD7xzwE8k+1BsWw+TJB/4buolzTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DO1M0doPMTLafYXGUjfZ8MfJEkHRuYirlRD1BIqc2wVSGchnx5ss4lyKB5Dkqsf7ghmgAgsb+QO+R3ghVOLo+AapEVD9f9djdKue0Vx3Py3pWoAcvsrk6wlf8k5JDVI/8dYouOCAII0CKUtTviXFsQi3R7MZz+1T9x9/nu2hNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3m-00019X-SC
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:46 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3i-000TUd-VP
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:43 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9F95A28D6A4
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5E6DD28D64C;
	Tue, 13 Feb 2024 11:34:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2fc3bf79;
	Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Simon Horman <simon.horman@corigine.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/23] can: m_can: Use u32 for putidx
Date: Tue, 13 Feb 2024 12:25:15 +0100
Message-ID: <20240213113437.1884372-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

putidx is not an integer normally, it is an unsigned field used in
hardware registers. Use a u32 for it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/all/20240207093220.2681425-9-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b31df3e3ceeb..1b62613f195c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -486,7 +486,7 @@ static void m_can_clean(struct net_device *net)
 	struct m_can_classdev *cdev = netdev_priv(net);
 
 	if (cdev->tx_skb) {
-		int putidx = 0;
+		u32 putidx = 0;
 
 		net->stats.tx_errors++;
 		if (cdev->version > 30)
@@ -1695,12 +1695,12 @@ static int m_can_close(struct net_device *dev)
 	return 0;
 }
 
-static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
+static int m_can_next_echo_skb_occupied(struct net_device *dev, u32 putidx)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	/*get wrap around for loopback skb index */
 	unsigned int wrap = cdev->can.echo_skb_max;
-	int next_idx;
+	u32 next_idx;
 
 	/* calculate next index */
 	next_idx = (++putidx >= wrap ? 0 : putidx);
@@ -1719,7 +1719,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
-	int putidx;
+	u32 putidx;
 
 	cdev->tx_skb = NULL;
 
-- 
2.43.0



