Return-Path: <linux-can+bounces-4953-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE7B98D4B
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F822E2CD5
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8429A312;
	Wed, 24 Sep 2025 08:21:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D812877CB
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702117; cv=none; b=VDKrvCCAeRCy9cRLwV+z60XIlL1OSJNpeha3s7LHA4HE2Guy+K6Rbz6A/G10ORsl6F2SluuabM/dtzIBWkS3NFIFC/GGNW2jp++G5o0dck2W7VZ0SmnsRIznAHO7QzjHIoPwfQ6ygmRZUmNLd5VEarQ5niKnHj45PguA71vFWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702117; c=relaxed/simple;
	bh=AzNE0d1w2Wc3y2liwIAy8mFHJTUYia3+rI0DGSqLVdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao33wb/yP0gc/UQAqq5nu4U7t7U4iQZ5Ko+393NLsOmxiMAHP2yDC2/ukdLDzLNwBWcjVXPLw91tkkE0tmArdudctSoF8QFSB/80QAclB9FJwhUb5q8dlD2LxAzKLGIfIPS94nuRjftq6/3JTj+yCojWk0g9j4ZnyNjVSImGByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001GY-L0; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000DwV-22;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D6AD2478865;
	Wed, 24 Sep 2025 08:21:06 +0000 (UTC)
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
Date: Wed, 24 Sep 2025 10:06:18 +0200
Message-ID: <20250924082104.595459-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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


