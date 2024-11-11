Return-Path: <linux-can+bounces-1954-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E389C3CB9
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 12:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430FD1C21736
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4E188905;
	Mon, 11 Nov 2024 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="VTAL07pV"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4FE18870C;
	Mon, 11 Nov 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323338; cv=none; b=JTQU2HX/xoNcQv/wlr55md6D7r7lEu+6ZKs4db9E3GewyIh5E10QzERqx2b0pjLFOYNT6hYpcLJHvp5k3IFreqtfvP1Mz0Toxe0O9Pr5LzUn9KzMloDmq5dLsGfm38O2BY5ZRrWLMNV0039dl7iy83Ae6JF4SXAMAak4TDtRpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323338; c=relaxed/simple;
	bh=W5uiWkO2cHCiM3fQ7VIpZPVLLeqxMqm5VHI2NmTnx6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCgJsi3jUD0+mJBye/jgzRSEgGM4y/Bf5wbbK42DuXWEm3qPsom8Yf0gBaZ6puWwvZLNRx94BhBLIGA7PNrYwsbtNKl+M39Nhb7XeG5lCCLp6p9gY9whPwZpMseg4iHORMY+YMZF/fcc29Z0Ki53xSlD2EOCtnXdMs4dpuYGuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=VTAL07pV; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/I7aNJPYCLDXRn0sdCZcFtLMPgSoN8VrVDY69crr8c0=; b=VTAL07pVpv8KpTr11jbNiNBAtv
	D7CKYfmoKxRrhOB6TF6E1ZdnvFfqd5YWD1tkDeIOHBMh9VT85v3I9sdhR/SzMRrlxmcZ9NtMRTxUz
	sH1UXtJqR2n+zRfohNHC5IM6DrUKOKDl3xJv0fGE6UIxhDzll27me45Y6+3cObTlYiev/14fyEQZ6
	PV6Mf7fBSaaCvXc5+/5pYUcPpSfmwc+/u1xzgc8IuayoWHxSxCkTBYF6a0pEiMSBTUDzpAZxEtd7/
	CcSx0BR0gpuXiDPvjD2q1HgmimclvpUVG9JfqYeqNcXAwZRgnnjJiYp3jkO8VlCFHEsC0b4gji696
	N7+g/Hrg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAS19-0000ix-Tt; Mon, 11 Nov 2024 11:51:35 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAS19-000JnT-0u;
	Mon, 11 Nov 2024 11:51:35 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 11 Nov 2024 11:51:23 +0100
Subject: [PATCH 1/3] can: m_can: add deinit callback
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-tcan-standby-v1-1-f9337ebaceea@geanix.com>
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

This is added in preparation for calling standby mode in the tcan4x5x
driver or other users of m_can.
For the tcan4x5x; If Vsup is 12V, standby mode will save 7-8mA, when
the interface is down.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/m_can.c | 3 +++
 drivers/net/can/m_can/m_can.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a7b3bc439ae596527493a73d62b4b7a120ae4e49..a171ff860b7c6992846ae8d615640a40b623e0cb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1756,6 +1756,9 @@ static void m_can_stop(struct net_device *dev)
 
 	/* set the state as STOPPED */
 	cdev->can.state = CAN_STATE_STOPPED;
+
+	if (cdev->ops->deinit)
+		cdev->ops->deinit(cdev);
 }
 
 static int m_can_close(struct net_device *dev)
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..6206535341a22a68d7c5570f619e6c4d05e6fcf4 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -68,6 +68,7 @@ struct m_can_ops {
 	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
 			  const void *val, size_t val_count);
 	int (*init)(struct m_can_classdev *cdev);
+	int (*deinit)(struct m_can_classdev *cdev);
 };
 
 struct m_can_tx_op {

-- 
2.46.2


