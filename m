Return-Path: <linux-can+bounces-4996-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41123B9F1E2
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC00F4E4C19
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34F3009FF;
	Thu, 25 Sep 2025 12:14:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBD2FF15E
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802442; cv=none; b=aC3mecefKN8YhAmS+54hRDO0V+5j/zofp4K9eLqiKv7YC5LZPeHNVH9VrnfJ2q6fbBOpdSdRlKXXMTAeNZtgtJyA4qQ3q3/dm3MC6oNMJjI2GomHEewg+/cyyxCOl9S6hcecwvK2GSFurq1pjE6qKplH+hDOgoFwMtGM9iLRaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802442; c=relaxed/simple;
	bh=AzNE0d1w2Wc3y2liwIAy8mFHJTUYia3+rI0DGSqLVdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffbZXLC6ozNNM4MtU8uhEPVTzWp/e7bUpQHHh9xX68eBhN9b91Bs6LN3kfBLQj5+d1SReV1mJ1nEFm0008mHI9oTTXBKLpF0C8PXdpTrDPtoASuY7sCb7WajHsG1yp8I1FN6/8V+FtJJNrcjGe9mhF3JhRdMU+VQ8ZDLENJ7kVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-0000Vd-Dx; Thu, 25 Sep 2025 14:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqt-000Pv8-0p;
	Thu, 25 Sep 2025 14:13:35 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D534747996D;
	Thu, 25 Sep 2025 12:13:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/48] can: m_can: use us_to_ktime() where appropriate
Date: Thu, 25 Sep 2025 14:07:38 +0200
Message-ID: <20250925121332.848157-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

From: Xichao Zhao <zhao.xichao@vivo.com>

The tx_coalesce_usecs_irq are more suitable for using the
us_to_ktime(). This can make the code more concise and
enhance readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250825090904.248927-1-zhao.xichao@vivo.com
[mkl: remove not needed line break]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fe74dbd2c966..e1d725979685 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2213,11 +2213,9 @@ static int m_can_set_coalesce(struct net_device *dev,
 	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
 
 	if (cdev->rx_coalesce_usecs_irq)
-		cdev->irq_timer_wait =
-			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
+		cdev->irq_timer_wait = us_to_ktime(cdev->rx_coalesce_usecs_irq);
 	else
-		cdev->irq_timer_wait =
-			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
+		cdev->irq_timer_wait = us_to_ktime(cdev->tx_coalesce_usecs_irq);
 
 	return 0;
 }

base-commit: fc006f5478fcf07d79b35e9dcdc51ecd11a6bf82
-- 
2.51.0


