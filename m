Return-Path: <linux-can+bounces-1545-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68F97EE3D
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 17:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04EE1C216DB
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEB58F54;
	Mon, 23 Sep 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="U8DvJcdE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qKLpscQn"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121428C06;
	Mon, 23 Sep 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105567; cv=none; b=ZYr5e95c4eGyPQK69VHJUxY0IAjEpW6YWFIBFaTVDYRQwdmuKlQ/vGZAPfUDyw1YlFRjtWcHwe9s8qbv9tQBO5K2aDbgF2BoqZjO5eBIZS1TPiAlZ7hg/tqyyv+cNpsFrHyqiAz4AusKNAMziOppM+xISRp0y7YPdv+xMdRWe/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105567; c=relaxed/simple;
	bh=dMAUZ9MSmg+CpnqGsMrhcrcCOGbR6ZPk8iOdKsHk3aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UxcSV7DWu0rUa3+SR5RPAayxH0qVLkhp8NxY6s8AlKe2COMKpIlbZyjyWT62Vmlt8YiLRz4Vb7nD7Tdilyqdd+gNEzv+IKY6CNM/Fygt4zHRLyZJzCoCGC8baousD/VTeiBSOmopuiK6VR1xri+xJU+6VkKnq61CLvVsNHjFr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=U8DvJcdE; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qKLpscQn reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727105563; x=1758641563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7bin/J0ywcQnIptPo7xTu8YW/RVbrNQCnt9rUJuHX9w=;
  b=U8DvJcdEo5lUz35eDPkrtV3P7OnRu/JoX8JO3S4vlnagZYsFnZATTG3+
   YbYABwBbK+SNnzOx6bChpV6dUYHarvKtQQiLvP6ovQVr29U+HwSmzuON5
   fPwCdgVHGrc42ox70hOB9wYNzmbtvfr5EoeJN/LtXUuvTPC7zHnLy6K1E
   yqbBEkmiVD8PvdyFYFBhH20xbdNceKZeHXjKDI7eOk1ggDwlxdXwoPaN4
   Kyr8AKQMoItyUsp6Uj4gBMOc8DVGQ8GeYBcRs+RE6EDyCwt7vbWNHkFxU
   FOAwFSPiCkzP/mK6WFxPk/m0U9bwBatOuVa0/owsnwtU/cl4aDjz7Mugi
   g==;
X-CSE-ConnectionGUID: fna7zUbpSXiAGpILhyhRSQ==
X-CSE-MsgGUID: QL628llEQoqV4ggwkxTbZw==
X-IronPort-AV: E=Sophos;i="6.10,251,1719871200"; 
   d="scan'208";a="39075276"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Sep 2024 17:32:40 +0200
X-CheckPoint: {66F18A18-6-3BCFFE8C-D8CDCBC9}
X-MAIL-CPID: E6FD9E8382D3E384EEE49D414D156989_4
X-Control-Analysis: str=0001.0A682F2A.66F18A18.00D5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC4E416E813;
	Mon, 23 Sep 2024 17:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727105555;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7bin/J0ywcQnIptPo7xTu8YW/RVbrNQCnt9rUJuHX9w=;
	b=qKLpscQnyJq4LAmelEakB/7vW6cDMd0ofGg4DJ4EYWNfp5n7zm0RloobgKbEadmdX/uGfF
	Ng24vrLG+k8B3DotvaFXuiXQJBf2MmjFOslUZcvMMoX6066BmwZ5MQKCj2L+RWSUZk14M4
	X4cyn5LsxvDuxLQvSQW6c9tYPqXqzAsLwXEBnbsbpN5X+ri8Xv58G5eeJEcxV8AELo0Yuh
	3tQh/Yt4ac9sXf1cdoFM7hH/YqSJgzw+I7g27NRdHx2kVTmjsFY7WGvDgVyLT+Uq/Pt7xI
	1wx+8/GsLn8qwsv5U2DJJx3IYTbA3aCwf1cxQoBSGZ8VKkZRH/nM9LWh+XW/3Q==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	"Felipe Balbi (Intel)" <balbi@kernel.org>,
	Raymond Tan <raymond.tan@intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 1/2] can: m_can: set init flag earlier in probe
Date: Mon, 23 Sep 2024 17:32:15 +0200
Message-ID: <ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

While an m_can controller usually already has the init flag from a
hardware reset, no such reset happens on the integrated m_can_pci of the
Intel Elkhart Lake. If the CAN controller is found in an active state,
m_can_dev_setup() would fail because m_can_niso_supported() calls
m_can_cccr_update_bits(), which refuses to modify any other configuration
bits when CCCR_INIT is not set.

To avoid this issue, set CCCR_INIT before attempting to modify any other
configuration flags.

Fixes: cd5a46ce6fa6 ("can: m_can: don't enable transceiver when probing")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes
v3: updated comment to mention Elkhart Lake

 drivers/net/can/m_can/m_can.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 012c3d22b01dd..c85ac1b15f723 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1681,6 +1681,14 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
+	/* Write the INIT bit, in case no hardware reset has happened before
+	 * the probe (for example, it was observed that the Intel Elkhart Lake
+	 * SoCs do not properly reset the CAN controllers on reboot)
+	 */
+	err = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
+	if (err)
+		return err;
+
 	if (!cdev->is_peripheral)
 		netif_napi_add(dev, &cdev->napi, m_can_poll);
 
@@ -1732,11 +1740,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
-	/* Forcing standby mode should be redundant, as the chip should be in
-	 * standby after a reset. Write the INIT bit anyways, should the chip
-	 * be configured by previous stage.
-	 */
-	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
+	return 0;
 }
 
 static void m_can_stop(struct net_device *dev)
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

