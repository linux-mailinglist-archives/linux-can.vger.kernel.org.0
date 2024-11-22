Return-Path: <linux-can+bounces-2181-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C169A9D60E4
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 15:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5341F21C9F
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745011632C2;
	Fri, 22 Nov 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WopVSqhx"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749DF13A878;
	Fri, 22 Nov 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287183; cv=none; b=jEzXi85ksZEmvWN1on92LvkT0o89JIMl+lRriPbE35UsDrwuQc0xDbnTuQxd3hQgkFw3gcgv7ThKsgB2queWWRgM3cQKxX5dXXSn040GG2lc16JeoelP5WANdUblpE/UIUPpeISlw83JDpMWnZTn0qLBXhQfAXINnvhemVHhB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287183; c=relaxed/simple;
	bh=IxCNHelaMrEjh5uqr6QwN2TyLcl0N2cfe8sWplCp9GQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQE6Dtq0yTVdn4sn0tZEhPE3W2SwDfpOCcIEhua7ZDzVLWdNFa2CcZ8cHMWMRFky4YWrqtEu2xOt/a0cdsUB05Uu4zgpa3WEQ+CnSwCd9bCksED5qiLibegUVmSv9OuFXjcbTXFGZtO4UpzrThD2IjnyJFKQB4b6/5tH0R1vqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WopVSqhx; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=s/g999F984FmZQoAKj5iV8ej5wGcgW8M4SRdlhH5yNU=; b=WopVSqhxTsRhzFVhdC0CNCVWc5
	6JSrbu1hWuM7Y0p8urzEZDLeFAhcGFMtzetR/n85XIaumpvc1MMUyaEV2nK6NWaR/Lyuv1eYXWXcz
	ULPnXdPbqpc+DQKop6kJ+s1E7Cvr7sPubdmaRy5/zLxvKWeXQ9gDCNMg+ljawj20YJK7rDZsWs3Ki
	A0BfbMG7W6LtH+golBYyrbwNwmQwAyBbn0TcqiCBjN+VY8Ism5Q/BXFZ5KWVcmcKeKVlG+dMOw3FR
	kf95Edhek25HMqamJagrr4ru+3FGtAZF6m88Lmp3mDslyXkA6rpHpaaUYVUAu2OV+t0RV3Dqas8cu
	dvVu/3NA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tEV1W-000KID-9L; Fri, 22 Nov 2024 15:52:42 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tEV1W-000HFz-06;
	Fri, 22 Nov 2024 15:52:41 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 22 Nov 2024 15:52:22 +0100
Subject: [PATCH can-next v3 1/3] can: m_can: add deinit callback
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-tcan-standby-v3-1-90bafaf5eccd@geanix.com>
References: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
In-Reply-To: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27465/Fri Nov 22 10:41:26 2024)

This is added in preparation for calling standby mode in the tcan4x5x
driver or other users of m_can.
For the tcan4x5x; If Vsup 12V, standby mode will save 7-8mA, when the
interface is down.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/m_can.c | 7 +++++++
 drivers/net/can/m_can/m_can.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16e9e7d7527d9762d73a7ec47940c73c0976e05d..e31ce973892a96f47d26d06464e0f6e2245550fd 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1756,6 +1756,13 @@ static void m_can_stop(struct net_device *dev)
 
 	/* set the state as STOPPED */
 	cdev->can.state = CAN_STATE_STOPPED;
+
+	if (cdev->ops->deinit) {
+		ret = cdev->ops->deinit(cdev);
+		if (ret)
+			netdev_err(dev, "failed to deinitialize: %pe\n",
+				   ERR_PTR(ret));
+	}
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


