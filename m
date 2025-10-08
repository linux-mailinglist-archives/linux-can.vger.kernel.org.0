Return-Path: <linux-can+bounces-5109-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1653BC6694
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 217104EE3F5
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 19:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290E2C15A0;
	Wed,  8 Oct 2025 19:08:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31232C0F62
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950490; cv=none; b=T/92esRku2e1IzO9jiSIRGOTAD6Kh0YrzlTYnHai/DnRhYuIABASKF0e8xDhOD6nZJ4OEDlUch7X6WI/xQ6zcy+Bh55M9MhzaiONXuClr+0mZkd8iUzkJlyPRvWdzMD/Chm5BPjdm+P6ykC6fLeMdc/406GXlrWD5DWYM8dlQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950490; c=relaxed/simple;
	bh=hqi5JhCiVO5Imio5JsBDzf7vDICuUe3IlNASWp18oaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qvj/AwxET2xisWZbiD5lwC9pDOGrY5G3UoRM8aVBExgQXxG/neH2g7oklYwnOE57n9M4xT3/quNJihCm3lMb1sUU2vQGjun+74N2zzhYGeR1ODANo/RafKT4ZYhFrjKP6r52OgcHc4USuurNDrZ18nzQgfA0931xe3KfmW8R4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW4-0003RN-3P; Wed, 08 Oct 2025 21:08:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW3-002cDE-0h;
	Wed, 08 Oct 2025 21:07:59 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CCBA14821F6;
	Wed, 08 Oct 2025 19:07:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 08 Oct 2025 21:07:37 +0200
Subject: [PATCH 2/7] can: m_can: hrtimer_callback(): rename to
 m_can_polling_timer()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-m_can-cleanups-v1-2-1784a18eaa84@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
In-Reply-To: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=hqi5JhCiVO5Imio5JsBDzf7vDICuUe3IlNASWp18oaU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5raDR3E+j+0HDVBxRhTJiiBkDNHcdwF5uNQuo
 uzxaqjgREyJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOa2gwAKCRAMdGXf+ZCR
 nOLPCACaNY+xH357bLjeWSwLcA2n+QTXPlB7eaFMcXmipw3waqxeUbfQA2KNsLFsmrb1VKfUo5l
 isdrIdgCIYb9M2wN+/OPjsJKLiwKpTsJosryiOWHLqYgwxzzNnYZXzKH1jUiM6/UmY+usUNc1aC
 4EJcqhk5PQZLFCwiohZtvofeawVGOjTtnKyxUlXfxJeW3Pez/eSwK/jMD9ywNQBDnqOWeHV9YdU
 yrXhlWSPILPzu3f5RjfY6w0EBUNU0IVqgTrU2jmblSy0W25TFsjINQGwHTniUUnE928puhdKwa0
 +Jj+mh+RT+EPsf4GvQCApri4/RjjLUgymXeIuBvu/0rF/PFY
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The original use of struct m_can_classdev::hrtimer was to support polling
for devices without IRQ, with the timer function called hrtimer_callback().

Commit 07f25091ca02 ("can: m_can: Implement receive coalescing") uses the
hrtimer for software-supported IRQ coalescence, with the timer function
called m_can_coalescing_timer().

To improve the readability of the driver, rename hrtimer_callback() to
m_can_polling_timer(), which better describes the functionality.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 03e2c431ffab..d4aa46b236ea 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2045,7 +2045,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
+static enum hrtimer_restart m_can_polling_timer(struct hrtimer *timer)
 {
 	struct m_can_classdev *cdev = container_of(timer, struct
 						   m_can_classdev, hrtimer);
@@ -2418,7 +2418,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
-		hrtimer_setup(&cdev->hrtimer, &hrtimer_callback, CLOCK_MONOTONIC,
+		hrtimer_setup(&cdev->hrtimer, m_can_polling_timer, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_PINNED);
 	} else {
 		hrtimer_setup(&cdev->hrtimer, m_can_coalescing_timer, CLOCK_MONOTONIC,

-- 
2.51.0


