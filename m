Return-Path: <linux-can+bounces-3521-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D13AA74B4
	for <lists+linux-can@lfdr.de>; Fri,  2 May 2025 16:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394F81C05C9F
	for <lists+linux-can@lfdr.de>; Fri,  2 May 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDFA2571A7;
	Fri,  2 May 2025 14:14:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251272571C5
	for <linux-can@vger.kernel.org>; Fri,  2 May 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195246; cv=none; b=Jpo87rvkcKPbkObG2Mn8xPQ3twohsrbU7BNLLcLw3LjaU5+wgTuKH7Bdto6RfzRMjnpe/JpikMet/69/5xNBwlQpSMKlytN/F5b7F1xAEJXy6USFO618BnlHQTMdtERYA796vQRHlM7ncnBpXsY9PXvcwMB4CDxa41NZGo7WKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195246; c=relaxed/simple;
	bh=5nFrpQd9CUa012/GckQTi/lhWF6yzNe/Y2s7EnVqJ/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=baiYdKfZXbOyhCRJd5RPQ9vVF4Lr86L4vnDy1vxs4MVxguo6IVwTvlNd2XIRdRHurGrRsuC+j8MyV+n4dc++xExNHpSMx0DAXF5f1R1Nv4pWWvK7lhN0jvQcBjm2xpX/6+MIkJBNgYMgtljCG6uCNi5CxEEE2Sonrdx+Xe8jddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uAr9M-0000vF-CB
	for linux-can@vger.kernel.org; Fri, 02 May 2025 16:14:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uAr9L-000lQi-2R
	for linux-can@vger.kernel.org;
	Fri, 02 May 2025 16:13:59 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6D7554065C9
	for <linux-can@vger.kernel.org>; Fri, 02 May 2025 14:13:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C8D7840659F;
	Fri, 02 May 2025 14:13:56 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2f2dab4b;
	Fri, 2 May 2025 14:13:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 May 2025 16:13:45 +0200
Subject: [PATCH 2/3] can: rockchip_canfd: m_can_class_unregister: fix order
 of unregistration calls
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-can-rx-offload-del-v1-2-59a9b131589d@pengutronix.de>
References: <20250502-can-rx-offload-del-v1-0-59a9b131589d@pengutronix.de>
In-Reply-To: <20250502-can-rx-offload-del-v1-0-59a9b131589d@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-048ad
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=5nFrpQd9CUa012/GckQTi/lhWF6yzNe/Y2s7EnVqJ/g=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoFNMeP4LWFCBDYcQbczXAXiVIxU95CWbmX7+W/
 wOU0gSWp1GJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaBTTHgAKCRAMdGXf+ZCR
 nCn0B/0UMKR2GTxZ/k7J5SU8yW/Bhib/H3TGkg7426M95DLuHIPgf8B6VWddUWQAikF6m/DfuvL
 vLIy/2LqUeBT7O2b+aKjH7MOYKCGekmmtJLyJBIwNapj7kxahfmdkLIQlKjA5RR3WiHkW+as5+2
 5ASOR93haIYNulqKd2CmRh072BXfZOMe+37ykvupQ/IKQMEQz67Vbc931Ht2Fuml4oZnY73g2LO
 WqAMfEpvrCeM1rLeWhCOS8O7hfLg2wAPsOl1MiukX8qwGyUyJWWiWmtSmy1dWfXqQ8pHT/wMlZr
 /AxjoZCWiNoN2t2DQCJhPd3pN1etMVw7k/Kis3xHfXZnpa4+
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

If a driver is removed, the driver framework invokes the driver's
remove callback. A CAN driver's remove function calls
unregister_candev(), which calls net_device_ops::ndo_stop further down
in the call stack for interfaces which are in the "up" state.

The removal of the module causes the a warning, as
can_rx_offload_del() deletes the NAPI, while it is still active,
because the interface is still up.

To fix the warning, first unregister the network interface, which
calls net_device_ops::ndo_stop, which disables the NAPI, and then call
can_rx_offload_del().

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 7107a37da36c..c3fb3176ce42 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -937,8 +937,8 @@ static void rkcanfd_remove(struct platform_device *pdev)
 	struct rkcanfd_priv *priv = platform_get_drvdata(pdev);
 	struct net_device *ndev = priv->ndev;
 
-	can_rx_offload_del(&priv->offload);
 	rkcanfd_unregister(priv);
+	can_rx_offload_del(&priv->offload);
 	free_candev(ndev);
 }
 

-- 
2.47.2



