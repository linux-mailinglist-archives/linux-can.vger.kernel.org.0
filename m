Return-Path: <linux-can+bounces-2066-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171FC9CDA4F
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 09:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8332832DC
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EB718C900;
	Fri, 15 Nov 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mYv6NyCn"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75518B494;
	Fri, 15 Nov 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658571; cv=none; b=WY/AokO9wKurkDbMDswS5SLqRTDQtesbQ0oBuQ/+KyTZVMIKWQIVWUHEUqYQWp6aMRR9NMUGq0e0Qhm2wiTeVHZTCnfKpJbXJXrYhT6H5oYpFCSdJCl37oxHrPLd352kP27vGT2C/tBvpLkv8ryOR/z1yVvqNpm8Lgg78A6WnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658571; c=relaxed/simple;
	bh=S4FdzVYjf8ENUDl5+hO/16Bd9XzJEIyN8MgztKh0+WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHoXBmqlZxYlKJMEYkUi55fkXahK7Q8QvZI9Z0tJ+i1eGpp/162drroR4LSstfFUsCIc9dnMYFPxUmHl7joQUBX8D8WET14YLbz59StCf2RZXYRPXcykE934Z5R1xkgOs4aYFsB6XBekdS4xaXRECmDLZlQ9aow4VST48FDQvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mYv6NyCn; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fffJKcNg4TRyI9YeClU3v8Y+9T3jAfJxagBxbbCRtD4=; b=mYv6NyCn6v7HLiTonOGOuenjFn
	fCZK4mePVqbWNWQoNF/fqYMN1k9tGyrHmzNRWegRXKhnw4k6Td9S2UHpOkPO4TS7Wk+/pDsQDYz4P
	AMHdfTnnBjcP5FhrTPFOx0DaQPmaNWdv8WB3xkMZgO27WzbrUsY2fHtYbL/Y/AyzKXqBg+k1xQz1x
	nMhMhVj6rte0qSFP2l3YNT/GnoHQJbGuebFDDG4tU7W/o8doS1VSzh2zXGce0TmhjB1uyrIUAIRLI
	RsBRLwk57XMSPX6PYflBmBw3zCysVJr5hGMDXJRlARcBbKqqJLGYneiLXaqpnpd/ahb/LWcXhHoa7
	9wShZ4bw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBrUk-000NVB-2K; Fri, 15 Nov 2024 09:15:58 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBrUj-000OuX-1c;
	Fri, 15 Nov 2024 09:15:57 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 15 Nov 2024 09:15:50 +0100
Subject: [PATCH can-next v2 1/3] can: m_can: add deinit callback
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-tcan-standby-v2-1-4eb02026b237@geanix.com>
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

This is added in preparation for calling standby mode in the tcan4x5x
driver or other users of m_can.
For the tcan4x5x; If Vsup 12V, standby mode will save 7-8mA, when the
interface is down.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/m_can.c | 10 +++++++---
 drivers/net/can/m_can/m_can.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a7b3bc439ae596527493a73d62b4b7a120ae4e49..667c70f8dc5e7e8b15b667119b63dea1fe667e8a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1750,12 +1750,16 @@ static void m_can_stop(struct net_device *dev)
 
 	/* Set init mode to disengage from the network */
 	ret = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
-	if (ret)
-		netdev_err(dev, "failed to enter standby mode: %pe\n",
-			   ERR_PTR(ret));
 
 	/* set the state as STOPPED */
 	cdev->can.state = CAN_STATE_STOPPED;
+
+	if (!ret && cdev->ops->deinit)
+		ret = cdev->ops->deinit(cdev);
+
+	if (ret)
+		netdev_err(dev, "failed to enter standby mode: %pe\n",
+			   ERR_PTR(ret));
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


