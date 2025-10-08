Return-Path: <linux-can+bounces-5111-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4813EBC6697
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 21:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6013F19E3F37
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183F2C15B1;
	Wed,  8 Oct 2025 19:08:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD82C0F91
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950491; cv=none; b=WG617r/B6MgOBs4GFhrloZpLAOzg78r4UaErbrvjj72/866o+NO44cvUXUVN877NBnemhygIYne9MMR2txrtil0U/HcOJUNdsNJbQnY5kiTNKmTI2U6wQHzaZn0jDeHAEC2sNBuHuF3QCAZyf/T6hkhxbR+u1+PxMmvsb/nJrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950491; c=relaxed/simple;
	bh=pSIg4w43P6DHspql22I5oY6RYYzVHVSRk26zpHsOzzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CV1/d7PHt2DaK4vqYMAw0tEdVWScRYVUhQMLTe40LUZRylTdGn38sC8xQwwcR20WoUr76GoC2Xlwy2mcfdhxxUPnqJic/kVYNcdKCLVqXG/+wRnDTha11iz4Ah5gATou2SL9fpSrHITGpWL2ld2DFOUuhnY3bq9k4z+Mr08B3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW4-0003RS-3P; Wed, 08 Oct 2025 21:08:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW3-002cDO-1S;
	Wed, 08 Oct 2025 21:07:59 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C3EE4821FB;
	Wed, 08 Oct 2025 19:07:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 08 Oct 2025 21:07:42 +0200
Subject: [PATCH 7/7] can: m_can: m_can_get_berr_counter(): don't wake up
 controller if interface is down
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-m_can-cleanups-v1-7-1784a18eaa84@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
In-Reply-To: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=pSIg4w43P6DHspql22I5oY6RYYzVHVSRk26zpHsOzzs=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5raMPX96GJKRD76fHRQ79PrAoU4fLmz4zBZXS
 NTytYnnMrKJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOa2jAAKCRAMdGXf+ZCR
 nHNiCACZv/pgKj5utZB5oUUW+J4a3g+ye8cwvOLN+eIomr7xKH8ur+N0oQHXJgxRnpySZM0FsYO
 YJz+1VA3ekASBxO5HEUo/PnZmryLchOjY7IMSOZOR0+q1YAwE7ym4CTzLAuzRofptfSqXtPHOaR
 JL3+16DWurdTpJhLJxsvV1HD+KkAOHn7IB1AhNyANY1dKF9Er6HQxazia6i3ZlQ9w4Ul0qhdoyp
 d4lIPVk7BWuU/c05IU8VXDTJ5RVKfFPOMRUgIArXnaUpErK1o0h6qySiI2wlItovn/IWe1tbXwK
 /fN5JUpyZYHcdVbR4a/Je5OFKxyWNOTZg8ECpceun9pE8DRr
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

If the interface is down, the CAN controller might be powered down, the
clock disabled, and/or it's external reset asserted.

Don't wake up the controller to read the CAN bus error counters, if the
interface is down.

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 4451ea750b74..0b622248e229 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -790,6 +790,10 @@ static int m_can_get_berr_counter(const struct net_device *dev,
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int err;
 
+	/* Avoid waking up the controller if the interface is down */
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
 	err = m_can_clk_start(cdev);
 	if (err)
 		return err;

-- 
2.51.0


