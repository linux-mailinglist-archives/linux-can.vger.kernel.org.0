Return-Path: <linux-can+bounces-1509-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BA597BDEC
	for <lists+linux-can@lfdr.de>; Wed, 18 Sep 2024 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C721F216E0
	for <lists+linux-can@lfdr.de>; Wed, 18 Sep 2024 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F36118C326;
	Wed, 18 Sep 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="G1tnGi/R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="IB//NBFE"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D218C035;
	Wed, 18 Sep 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726669460; cv=none; b=iOahaNa02PYTso0sVFoVdAZciiiTSU3EBFUKnhS3Ftd/ctnOANL1xXxbHSV6at7uNdq09jZ524nXZsBZOvQrW/xIIV39xtzLajvyxkJAjjgNHEiCNGOpgE3mK4PWLlNPwmUJ0D1XzkW211pqLgR5eNYX7zXt8pDMP7QfDEvdF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726669460; c=relaxed/simple;
	bh=WZdd6qkbAcrCiFk9WqvM25UJJzbrmYQT1Q/03zMr3oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WkE4P2VBVMy9WmDkOD+IYdqZqdsqQyLRDgNr7n8Df/twhwnsQRuzmlmxsjtBlx77QjA0KIDJCGC3juYWCEs57YCr8+6/bdWphFph2ZNVMCjl3Wy3/FpB9oRFpcnMIbOHxYyO135Tlph+em8LAcJ6+qgq9oVDAoeYkb8YvNT+7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=G1tnGi/R; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=IB//NBFE reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726669456; x=1758205456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YPP7c19jIEYTnTACbt4kKLTlfycxs9Nav34JXprnn1I=;
  b=G1tnGi/RAR0j3L2lPaA0MEOb0k4pcbWHuM11RslFPJ5Gv2eB0oeUQh+X
   hb56qYj269Llx3TYK/KURztsTZa8+Nlgjv/Y2nOILfvYhlFnjODYzs/bt
   Iu7T9+2NGKux0YZ+Kra30X9YPIDa160Saf0eSFsKi5w5embP8zWDolT9e
   wlbjW0EpCqPIRImk7KP1nEl4LNQzvPFTal1VED3dmtAd9YD+9gOY/X0Zm
   pbabCTa+cd+7d7TQFM48P0R4jUCk+S74teD6TXu+i1Q/jUkP6uv2ZZFU2
   Xw1ebJGTeX+LrywW0GqQBcmjXVmN4oGlk2jukB26VDfyB74vbCAYIG+wC
   g==;
X-CSE-ConnectionGUID: l8qH4+vXTFuL7l2KpHOd7w==
X-CSE-MsgGUID: 7gpAiLU5QpW+u2+zsI/XrQ==
X-IronPort-AV: E=Sophos;i="6.10,239,1719871200"; 
   d="scan'208";a="39006264"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Sep 2024 16:23:04 +0200
X-CheckPoint: {66EAE248-F-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: F253FEB8238044BC080F49D137CE35E5_0
X-Control-Analysis: str=0001.0A782F17.66EAE248.00F4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCAA316A3F3;
	Wed, 18 Sep 2024 16:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726669379;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=YPP7c19jIEYTnTACbt4kKLTlfycxs9Nav34JXprnn1I=;
	b=IB//NBFEDxvBbaEaebiPwvgvQLUI4yiV6Rfh27er2H1VPMffgz3Fz/Vf2r5ENcDKWBo9Po
	89RqU4ccvly0YKv3Zasc1EaFVeCT3Rs8P0UcP1IVtCerqU7gR1CCuaml11gUJtXKe5/mR4
	TBRFvH8mZMS2510iXEV+wdNYB2IWlODyaKb5CpPCrDm7U1VfrBHTLwNz9TayQukQePPCJb
	ysr1E1RiY16N5VSSwH5Km+rLCqFEd21EiFmVnKN1twVSTOBgfZ000DcSqrkcsBJsxy3ZkH
	HrChCDJcjKBCTtHAqGurZa3z/z17cWNa+j0WC6Cnsmfj3bd2aECc7frJWgT19w==
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
Subject: [PATCH 1/2] can: m_can: set init flag earlier in probe
Date: Wed, 18 Sep 2024 16:21:53 +0200
Message-ID: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726669005.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
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
 drivers/net/can/m_can/m_can.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 012c3d22b01dd..47481afb9add3 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1681,6 +1681,14 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
+	/* Forcing standby mode should be redundant, as the chip should be in
+	 * standby after a reset. Write the INIT bit anyways, should the chip
+	 * be configured by previous stage.
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


