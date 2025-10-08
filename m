Return-Path: <linux-can+bounces-5110-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C5ABC6691
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F05519E163E
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC82C15A9;
	Wed,  8 Oct 2025 19:08:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303029B233
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950490; cv=none; b=mRnKAkr+kGQwbQmAVdRp7106Gj+l0unlB9+OWtKbjvaxEEGXo7v4xaSvwPCAVjymt419a9iHlCqLYrTouKcSU+fUpo1cBEFxrOICkA5YAsBiWGp+AqGdi/eVIlg/kbNuCnJ2Y4tgPZCy9eSHlVq21NOfwuztMQCRt33LHNsNrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950490; c=relaxed/simple;
	bh=o4Y8rgbRUuDMvNZrs1nSGq+Y96elsEU9l3xfUMYO850=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAnRosvXlvFdnGdbDS8dSE+bTBZaPEfqIB2qMQnDsmRoHJFyZpLIIsDeUOQgVhHyElh+pRabkg8rXrx//5t8dGBkp+EpHs2NzGsqUIlNIitaeXAEbececmx4ei4sPhOuFV+JCFNjAYydDj1ZZD/hRNscM1tkUzu0ZZc2yMxwZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW4-0003RQ-3Q; Wed, 08 Oct 2025 21:08:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW3-002cDL-1I;
	Wed, 08 Oct 2025 21:07:59 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F30444821F9;
	Wed, 08 Oct 2025 19:07:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 08 Oct 2025 21:07:40 +0200
Subject: [PATCH 5/7] can: m_can: m_can_class_register(): remove error
 message in case devm_kzalloc() fails
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-m_can-cleanups-v1-5-1784a18eaa84@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
In-Reply-To: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=o4Y8rgbRUuDMvNZrs1nSGq+Y96elsEU9l3xfUMYO850=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5raJI4S0e2shCK90HajW+PRixqOmB2tDH6f/q
 4RJS8qdSiKJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOa2iQAKCRAMdGXf+ZCR
 nAmnB/9Qbg9EF9iG/4cC9DBtFbsRK6r9QtaYeNVgNU17juoAHeHNgkgw2WsQc21h4oaj7a6gUIX
 pDUKRkSoLQAwfYfWLB69KW4kMOVxp+hEN64+WoLBSvPVV63ZQ4OefwrmhckVViXzaAaNzyeyq2k
 8UG2n/Ig/Qn+NJ0BMNLtX8YcWPuOhNrWdS0D7Go9+QS4oi1c3g/PMKDk2UwCTdPA9udwzjbSi03
 9mHwTGwBeMCvw1z4RAYzSR1tVjogUSQMytVY7wytzF9BSDGkt3tZNdTwMioQQRdA083VTljAptM
 gWrpd9gxqFy+8e3sX9PTwNgyKY/aX5g/1fxbeN5P3DrSZq1Y
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

If devm_kzalloc() fails, it already outputs an error message. Remove the
error message from m_can_class_register() accordingly.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 4cb4eee3602a..92a4feec4174 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2399,10 +2399,8 @@ int m_can_class_register(struct m_can_classdev *cdev)
 			devm_kzalloc(cdev->dev,
 				     cdev->tx_fifo_size * sizeof(*cdev->tx_ops),
 				     GFP_KERNEL);
-		if (!cdev->tx_ops) {
-			dev_err(cdev->dev, "Failed to allocate tx_ops for workqueue\n");
+		if (!cdev->tx_ops)
 			return -ENOMEM;
-		}
 	}
 
 	ret = m_can_clk_start(cdev);

-- 
2.51.0


