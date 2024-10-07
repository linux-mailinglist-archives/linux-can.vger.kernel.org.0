Return-Path: <linux-can+bounces-1595-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4369926E3
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 10:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EE11F22E42
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5C518A93F;
	Mon,  7 Oct 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="feRvz87w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aqsTDOeo"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93F17C203;
	Mon,  7 Oct 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289478; cv=none; b=bkDtcGHA1/jYlFammap4py1bPECnips4CNnA/a/UlLBmUMo2R+PsrA2LTXy+xTSdT/ml6OeojaMo8on4xStm10PNe9s91hdY0mwuECp43WTPhnS3wsNis7ua4BYE+9AHkXJ4tPRXWJ+55tM9le8jSeIWQn0Xsc1FD3BJ1rlW4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289478; c=relaxed/simple;
	bh=2P/3SYlQzuEDT09aLRhadj45a9SWACw9nyneRFqqVtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CWSTa29l38EwFScUy/evY4ZyskOCi6RLTa7gCVsPfpP1+okTpy/wL8CxkYnrXZhUm2yfZgI9BwJM86GZ3DVVCFuUa8YmV6qkCGFYxIbC3tUxJbROPa4EZrK7S7rwovHFfIcTUfEsZTz0W+MIlmyy3NVCoqegz0lxA15Rsii56+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=feRvz87w; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aqsTDOeo reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1728289474; x=1759825474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kZLHKkZcSRfUU6Wcyx/OfRhBUNPMTTzmQTipgLzwHz0=;
  b=feRvz87wV4upVY2GIBgEwwJjdb3GIhtnKXFCZusiBOlvGNGgZAzlG7NS
   866+e93g3uBiSq+IInwLtBDPqKyx3OYULzNqkt9NH7NtRqY53UsUTjshd
   TWZcZp3yCT3LeLu13EoJb7eE7LDRK0E4uN2tY7x/s8WYWh36r/9DPIPnP
   5LazwyD7CRUuGGtU83yCgv2+VvuMuVRS8TeVcYAmoISseeqMOQSH4LgMy
   qe9DvDE880XYGJXpyfp1XRkxQ52tQIuy3WD0OzVbPRwcEf/ZJ8tUlgrYQ
   tB3qkIKJI+aYCU9CL8w2LfH5pKk3zg/+U1pwigbB+7meAp9P0M8vn3A/+
   g==;
X-CSE-ConnectionGUID: rZ70ks/rTpKb0dn1sugSrg==
X-CSE-MsgGUID: nPQYMujiT7aNJtDW504mMw==
X-IronPort-AV: E=Sophos;i="6.11,183,1725314400"; 
   d="scan'208";a="39298933"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Oct 2024 10:24:31 +0200
X-CheckPoint: {67039ABF-F-69B013CD-E6388B31}
X-MAIL-CPID: A63DD35BB5EAE5D33262B5486BBD2C8B_1
X-Control-Analysis: str=0001.0A682F1C.67039ABF.0075,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3145516BE23;
	Mon,  7 Oct 2024 10:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1728289466;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kZLHKkZcSRfUU6Wcyx/OfRhBUNPMTTzmQTipgLzwHz0=;
	b=aqsTDOeooiTDdZxttXBMnP31t9Q92LYbn2zIf3FpQYAhjDQ5rbN9M7ITqk8HsPjPr1fhNo
	Gw19eXB8Sm4yfPEOua5SaYIXq+/2gfvq/S+PGCMOZI2R1hLTA5gzQNd2gdVixQ79mQyXoZ
	OS+LAcw8R0dj9FHeMCprGOeMHr4WRcnky8o+R4DRPDzzqne+vcjy55rxD9kG9Hz8qm8ubN
	gZ1I0RpfB6rdB20mFmcS9p3EsGenTY06IMofIuVO3vFsgcMpwEYXMaWMHLLq8RdruL3vbS
	ZX213a2UHReFujdkvguBY+5a1+gT4CB5JxuZ/un2HDNQdAFt2nUiPYo+VIHcWQ==
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
Subject: [PATCH v4 1/2] can: m_can: set init flag earlier in probe
Date: Mon,  7 Oct 2024 10:23:58 +0200
Message-ID: <e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
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
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

v2: no changes
v3: updated comment to mention Elkhart Lake
v4: added Reviewed-by

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


