Return-Path: <linux-can+bounces-1952-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094879C3CB2
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B445E1F22283
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3F18870C;
	Mon, 11 Nov 2024 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="RjdPiKHr"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D49185920;
	Mon, 11 Nov 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323320; cv=none; b=C/WRdu0TndryzqGIHJRtNJ1yPJx5i/pch3BjMgRjKg7HCrLAZKVu3s/4j0MXG2QTxhYeppFmTN2O+Bhg8HjEpdr1oOYZtHxYCzI+e+l4azMIOLyqSuV6BHofV85FfCOqNdZfkqGu7bT9YbVP1u4Izz7EVDKNNm5e/buj7fqK2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323320; c=relaxed/simple;
	bh=WKPt/yqlvCh6WXh/shxcRQ0bf/KslpLgjP8nAlAXJ2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a981ZwsdK27nspZCkznOev1PftVPIwQKGjd36Bz66C/I+32q9lUOV+6t6fTmn7nUfwdr02SD25beMWfhtzqOnLVHv+RJaG+i7t9RILp4aI87hXCgU4xGBcAtU7tiDXlVVyEssxj/q/y2WXxAZxEC9h+q/IcZjU5Boe46jIy6gwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=RjdPiKHr; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5G+2VudxYkgR5Q+WSydh4Dzc/KKgJNma63QxDjf6acI=; b=RjdPiKHrB+x4Q2dmA6Cdas0Szk
	kcqDjWgHmJAVm+l9mVs1OdtZ0kNvrCjqqqOq6STCZNiVxY6T99Ko+L2RvMOP5eBJgIQX5MeWOaqqk
	GwVGmD9G2NEkCnF2FLvNK0/Jf3trpi/XG+ZeK2g76f61UA/b8igp2RaIRUsv58NLjDwZz74F5GpK0
	m1UZqGbNfH6CZQqfhqFn51WljFMEGkDgB2YeqmoXhxJZUuGfxfmyJKCAHvkHnG7xl6PxcPnGPIkaH
	J1HEXWb5P0a/8B/o/cAJvFifC8wXxLWaL+cnLMiEUsFeDRQFS/B+YYKVIm4yLbfzMvg5ZJXgY/tqT
	aaLra4Hg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAS1A-0000j5-Cd; Mon, 11 Nov 2024 11:51:36 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAS19-000JnT-2U;
	Mon, 11 Nov 2024 11:51:35 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 11 Nov 2024 11:51:25 +0100
Subject: [PATCH 3/3] can: m_can: call deinit callback when going into
 suspend.
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-tcan-standby-v1-3-f9337ebaceea@geanix.com>
References: <20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com>
In-Reply-To: <20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27455/Mon Nov 11 10:58:33 2024)

m_can user like the tcan4x5x device, can go into standby mode.
Low power RX mode is enabled to allow wake on can.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/m_can.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a171ff860b7c6992846ae8d615640a40b623e0cb..d9f820b5609ea3e8a98dc8a9f4d9948c09aa85c6 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2451,6 +2451,9 @@ int m_can_class_suspend(struct device *dev)
 		if (cdev->pm_wake_source) {
 			hrtimer_cancel(&cdev->hrtimer);
 			m_can_write(cdev, M_CAN_IE, IR_RF0N);
+
+			if (cdev->ops->deinit)
+				cdev->ops->deinit(cdev);
 		} else {
 			m_can_stop(ndev);
 		}
@@ -2490,6 +2493,10 @@ int m_can_class_resume(struct device *dev)
 			 * again.
 			 */
 			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
+
+			if (cdev->ops->init)
+				cdev->ops->init(cdev);
+
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);

-- 
2.46.2


