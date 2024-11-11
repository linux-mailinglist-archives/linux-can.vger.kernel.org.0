Return-Path: <linux-can+bounces-1951-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C69C3CAD
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 12:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C51E1F21F00
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04FD18453C;
	Mon, 11 Nov 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="x7S7psVH"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D614A4CC;
	Mon, 11 Nov 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323308; cv=none; b=grKbfBBINgUKPc0H0ynSBbZhPLjxIHAdrMjHUDsRKfDJw0DRE9uWvtRvI8oidkPaRTQlGGhNvhHVLkiOYNI6NTZzuTb4oxZE8JSYz3gm7PfHVPe08CYtETXQgBmYbpfgUfGu8q/1IBN7gwGo9OVvs5obiZDgKlU8FWrMavB7OSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323308; c=relaxed/simple;
	bh=9F5FIbDQpURXJ1x90stQR6QbxkhyhyotTGUbPdFKoB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6C2TY9WDWlO3VbfMYkjKwWNF76KpDSkgmG+po8rjoXzKnb6dgOQ0jguyunj+mxVzdk7yQp2G9y7bfMg2w5kNsxgvXfAmD08PWOySXObm9vRMjH+loPgeFVKKdSiocTKXDjnd2MldWUwfBJvV4GzqqFc17wxMSmO4OEUGwLr01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=x7S7psVH; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DvC5hQ1OSCc0FQMMe3JrzERRMI88oW4kxWqQI1dAef8=; b=x7S7psVHR2vuunSxOoxJDv88Yf
	JSZr/QijTV3ofUEZLXW1lVqmHGd7C0Ee2dWVGsqXSh7pP7kg4OK7zveEvUXOZRHn6LM6/eD0TISzV
	+xxGk9NX5iZXOyAS/2l4B7I2GLhuGPR2c0xTZT9QYnkJOE15QuT9LfbWoO0MsiBa0F0GLWByb4nFX
	BeJ6jbUdfhMCaiAkZnbJifZA2Go+ScCFBaCVraUKwL5BrIPgEfZOqhqeIGsqSunvT4aLCxovmKjTz
	PBr1hyc0QgIyTDXOjjAFzngi8YWah7026s0AD0DkI/MZdQFxF/pZGyqQhIrKb6j7oJZeqIvEMjgDX
	G2UNggJg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAS1A-0000iz-61; Mon, 11 Nov 2024 11:51:36 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAS19-000JnT-1h;
	Mon, 11 Nov 2024 11:51:35 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 11 Nov 2024 11:51:24 +0100
Subject: [PATCH 2/3] can: tcan4x5x: add deinit callback to set standby mode
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-tcan-standby-v1-2-f9337ebaceea@geanix.com>
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

At Vsup 12V, standby mode will save 7-8mA, when the interface is
down.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..c8336750cdc276b539dde7555b2510fba0d0da75 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -270,6 +270,17 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	return ret;
 }
 
+static int tcan4x5x_deinit(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+	int ret = 0;
+
+	ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				 TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_STANDBY);
+
+	return ret;
+};
+
 static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
@@ -359,6 +370,7 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 
 static const struct m_can_ops tcan4x5x_ops = {
 	.init = tcan4x5x_init,
+	.deinit = tcan4x5x_deinit,
 	.read_reg = tcan4x5x_read_reg,
 	.write_reg = tcan4x5x_write_reg,
 	.write_fifo = tcan4x5x_write_fifo,

-- 
2.46.2


