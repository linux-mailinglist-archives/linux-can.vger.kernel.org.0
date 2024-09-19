Return-Path: <linux-can+bounces-1514-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB80397C89A
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 13:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A60287EE8
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782719CCF4;
	Thu, 19 Sep 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="gS1o+2uJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sUyvtQi8"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C0199FD0;
	Thu, 19 Sep 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745282; cv=none; b=moOB6m9twgRtG3XzLbRIlrllqnSpw0AXEDf+FzTVc3RYRUHhUmOe0KYsh8o/lz8YNiOeZ7YkcVHQewvQduUyBJGk6uCZmAjYmgg65rkxAZJ5hRnHyeQOHV4FLyUtoypQPwrtXHwPoqxWuU0tC1zBlyQdyuUGslYGv7PHE+OPJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745282; c=relaxed/simple;
	bh=YBXzMq+t9SmI+2Czr9UYejhXeY1g5J7XoznuPVgx0vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s8NGtJdwvyXuZ4/RghFj/mw9kz8GbppD2MmaujJlxsxZ1UnDH7O9ZEjvb2T+24x7Jja3O4UflqFPxDpUdFeW+3PsSNMAmZoig4dwVanSzJcPqDIk3NIFhE3vypsIn8MBBpWuLyLLTCCua3VopwSzZunEZEkrKyHj8kaLVk0iLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=gS1o+2uJ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sUyvtQi8 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726745279; x=1758281279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CzE9ykpUdDz8aAMAjQQwVPCItKYM0lPcbiDeepD5YKI=;
  b=gS1o+2uJwFXHR5I8bvoVmLSz768bWYMdTJBf3Ly2wUDcA/Wrm6bZ8lK1
   c2Jkrit0dN7HzlcCnAqiQUgOQqDu4tzSmHIymjzFElH2ojghA2VrT3nQf
   a699tx006/Zf0JthlBU/Rg9DS3DXAR4HAX/zmvAeuvVZogZlOuiIY3jjA
   kbqRQEag0hBQOcpaL6whmGLfbMJz9yi/pbLMroxqcnHTdFnbE3/H2wS/Q
   22TxXHSPeoJcE6g/lPDVMKl2gDcNiblxyXRz7whfk/P67vncbOUZ/w8ix
   1YoQDQhyu2ZlSEFDiz0uRxypMtHebjTobTWzTyYDhgnnvkU8m4qw/4MGZ
   w==;
X-CSE-ConnectionGUID: sAC9dt4QRd6/T3OTiNSz3Q==
X-CSE-MsgGUID: Jrh/ttjSRmWKVLSKMkQAFA==
X-IronPort-AV: E=Sophos;i="6.10,241,1719871200"; 
   d="scan'208";a="39024125"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Sep 2024 13:27:56 +0200
X-CheckPoint: {66EC0ABB-24-E520F13A-D17B83D9}
X-MAIL-CPID: 8D00C0C6F25B9C3A6D8E8E4FB426A0F5_2
X-Control-Analysis: str=0001.0A682F21.66EC0ABC.0076,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F15016CB31;
	Thu, 19 Sep 2024 13:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726745271;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CzE9ykpUdDz8aAMAjQQwVPCItKYM0lPcbiDeepD5YKI=;
	b=sUyvtQi8M9djNkuhWu14s0Kkv7AJiwNJvp9CGlmmojXJWmZiKnprUtAD7HJ5UyHl8Zpe3S
	11M3mnnIwFPHQKd/I1fFW0tuy3yEBEHy7bB2pXv0aPyDooWkN8mNn8cuj+F0+yRPXGwixW
	iM2YKCzQeH+5wOADa9KOwbiVoCKoCPYVEQApM08fOGb767dhq0b88E8f2AKoJZ2WghmFip
	BS7Xswaj0u5U5fMah7A8BEzN9AWaN6WwFQLF/wzf/KTFYvRnx1h1Q3TEnBhorCKdbzXz8f
	hUMQP8DgLxJShKc4EfGrTctZ/v7ZgdK9Jeod5tMrSalGzUMk5kNzcwoeqyLN1g==
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
Subject: [PATCH v2 1/2] can: m_can: set init flag earlier in probe
Date: Thu, 19 Sep 2024 13:27:27 +0200
Message-ID: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
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

v2: no changes

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


