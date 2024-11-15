Return-Path: <linux-can+bounces-2065-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B949CDA4D
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 09:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407371F2230E
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 08:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F02C18C322;
	Fri, 15 Nov 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OnEuSPdm"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7EF18BBB0;
	Fri, 15 Nov 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658571; cv=none; b=saEVUib2k5jsQPubejEn7Id8pFm0JpmTyt3DOWutH1lhNbVz19zJ/GK1tfewIAxxvhlR6pzZMKRDShXwrovS0G7+YYo/QMbvkSY4CauwSNXtsxbNyENSayCuc9Pg74QMDHrnqRSfhk+xCUp1yljEhqgdnniSMpiPlPyaZVFLrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658571; c=relaxed/simple;
	bh=FDNy8FkvV10nfa+QEbB3gpFLXnzwm2jxaJ1fG6Cz1T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhYaycT7pfNNLgqVMUUNWVb5NuHhliGFqH2PYELRoFjOS+jcHQpicm/xeQgerxGCaFAjc8HCw/2fAmeYxMh67QeMWSupf9StEkrByU7jsooN4O+szy3O3u/StN3NXxg/GwwsLOosGaPHXpncFzXZWr7/GM0oHUvVs5hHgb8z6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OnEuSPdm; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LtXv/DpSElxGJy84GvBNudhOEGFQ2jn1JlbIjsEVIG0=; b=OnEuSPdmdO7Mb1R5a+Z9jKvsqA
	B5eObidjDkB0GP5Jbu0nEfYJ0tTLTQBixBEgkBpPsbd+gy6QwlwHGCcd1wxkjKNgmQ/9qbZZTKz0z
	jMG7A3UKMDHlbadwjtFFGL6RwY1JvF/lq2nYZoSA5YnMmkLPXycVGbsUf7yew9Cec0UkjcRYNdylH
	q1mrV2TxtGvQz9hlvFAV3eg2n7lir4sc0IlxrtKg+FqixgmEUf2Fki7wmyVkfC71HBqxHxfAVWi0P
	4GAvcsV/FArFemBNV93nsTXzfOH/e8e53XWEOTpweWo6e+C7pRm+y3+689XOIVZV81lZxqlvsvlQW
	I7cUxPdg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBrUk-000NVG-Gu; Fri, 15 Nov 2024 09:15:58 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBrUj-000OuX-34;
	Fri, 15 Nov 2024 09:15:57 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 15 Nov 2024 09:15:52 +0100
Subject: [PATCH can-next v2 3/3] can: m_can: call deinit/init callback when
 going into suspend/resume
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-tcan-standby-v2-3-4eb02026b237@geanix.com>
References: <20241115-tcan-standby-v2-0-4eb02026b237@geanix.com>
In-Reply-To: <20241115-tcan-standby-v2-0-4eb02026b237@geanix.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27458/Thu Nov 14 10:38:08 2024)

m_can user like the tcan4x5x device, can go into standby mode.
Low power RX mode is enabled to allow wake on can.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/m_can.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 667c70f8dc5e7e8b15b667119b63dea1fe667e8a..76a691de89baba1addf24342815c76e1ab32a776 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2440,6 +2440,7 @@ int m_can_class_suspend(struct device *dev)
 {
 	struct m_can_classdev *cdev = dev_get_drvdata(dev);
 	struct net_device *ndev = cdev->net;
+	int ret = 0;
 
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
@@ -2452,6 +2453,9 @@ int m_can_class_suspend(struct device *dev)
 		if (cdev->pm_wake_source) {
 			hrtimer_cancel(&cdev->hrtimer);
 			m_can_write(cdev, M_CAN_IE, IR_RF0N);
+
+			if (cdev->ops->deinit)
+				ret = cdev->ops->deinit(cdev);
 		} else {
 			m_can_stop(ndev);
 		}
@@ -2463,7 +2467,7 @@ int m_can_class_suspend(struct device *dev)
 
 	cdev->can.state = CAN_STATE_SLEEPING;
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);
 
@@ -2471,14 +2475,13 @@ int m_can_class_resume(struct device *dev)
 {
 	struct m_can_classdev *cdev = dev_get_drvdata(dev);
 	struct net_device *ndev = cdev->net;
+	int ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
 
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
-		int ret;
-
 		ret = m_can_clk_start(cdev);
 		if (ret)
 			return ret;
@@ -2491,6 +2494,10 @@ int m_can_class_resume(struct device *dev)
 			 * again.
 			 */
 			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
+
+			if (cdev->ops->init)
+				ret = cdev->ops->init(cdev);
+
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);
@@ -2504,7 +2511,7 @@ int m_can_class_resume(struct device *dev)
 		netif_start_queue(ndev);
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_resume);
 

-- 
2.46.2


