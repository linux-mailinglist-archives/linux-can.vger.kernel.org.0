Return-Path: <linux-can+bounces-6355-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMbAC+4jemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6355-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:57:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC0A35F0
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75DE730D9A91
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01914365A19;
	Wed, 28 Jan 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="XIlJ/wpC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434E364026;
	Wed, 28 Jan 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611774; cv=none; b=CrI1AY1sXRQhFssm+X+MjxbNyKObvQhoVgy0NZLTnfWKBzuMAgmQfQkUTp0aN3Fxl35KGh+uuTHPfLtJRjqykC0Ki/fnSsh+5Z5YezM0du/TCuW5NPQG99Y62gQZYhamUwXsMK7CPCSjoqu0GDxHeXpXOoctlBdJoQKHOB53NDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611774; c=relaxed/simple;
	bh=L/rLTS5nZPe+MmfZKsbNjowyZgFPne1GMZzhSMt64rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tp49kGCGFY6Ip/DgY0MzUYBv44djqBf+9soTYQwtlSJrmiSZBmm36K8Lc+IneTkoioAjAY2EcGXHoVx4qjHYka3EkUS8RoSrUjUCOeKSIvAYeqD+W2wrhlPo7NStGwG9crDtrsH5g/pXgQVksZbgRk4b/2QQur33w8MQdR1IWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=XIlJ/wpC reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCX1mwzz1FQVQ;
	Wed, 28 Jan 2026 15:49:28 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCW6tJkz1DQsp;
	Wed, 28 Jan 2026 15:49:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611768;
	bh=p+KzDx4M2gcKRYgJHx+u+LHbuSg09/20zOFN0HOSdwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XIlJ/wpCWWU20nwpPr5L4iMCDf6nSotuqGa4jncM+N/WzaVfGLVqhBWOAkGA1aYhk
	 HuEykKjY3Qod8LyHZOS+LkPBqnwla4jM7ZJi63LQiKYKq2np7G2+Fc2d48YeF84bat
	 kWz0zZEODRF9okEp2sZzi5qT/GiwKCprw5cJQ4PRZOabshh5PVFBfI3SEMTvnxVM7v
	 7LNkoNGRAO3QiE8TfhFzqxrvlUu885H86O24Bpa56XxJ5bt32swICKXW99R65HI9B3
	 wTZqMI2ArTROk1i71TV/zqLp7opvCmzMjdhvZ6w590t1niW7+2wKy2Y3iRN4iZUjgD
	 GxDVZpO0Yo4iA==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>,
	Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH v4 05/15] can: grcan: Replace bit timing macros with literal values
Date: Wed, 28 Jan 2026 15:49:11 +0100
Message-ID: <20260128144921.5458-6-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
References: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6355-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EDC0A35F0
X-Rspamd-Action: no action

Refactor the bit timing constants in grcan_bittiming_const by replacing
macros with literal values.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/grcan.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index f3821e224f4f..12fd4911add2 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -36,6 +36,7 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/bitfield.h>

 #define DRV_NAME	"grcan"

@@ -93,16 +94,6 @@ struct grcan_registers {
 	(GRCAN_CONF_BPR | GRCAN_CONF_RSJ | GRCAN_CONF_PS1		\
 	 | GRCAN_CONF_PS2 | GRCAN_CONF_SCALER)

-#define GRCAN_CONF_RSJ_MIN	1
-#define GRCAN_CONF_RSJ_MAX	4
-#define GRCAN_CONF_PS1_MIN	1
-#define GRCAN_CONF_PS1_MAX	15
-#define GRCAN_CONF_PS2_MIN	2
-#define GRCAN_CONF_PS2_MAX	8
-#define GRCAN_CONF_SCALER_MIN	0
-#define GRCAN_CONF_SCALER_MAX	255
-#define GRCAN_CONF_SCALER_INC	1
-
 #define GRCAN_CONF_BPR_BIT	8
 #define GRCAN_CONF_RSJ_BIT	12
 #define GRCAN_CONF_PS1_BIT	20
@@ -392,14 +383,14 @@ static struct grcan_device_config grcan_module_config =

 static const struct can_bittiming_const grcan_bittiming_const = {
 	.name		= DRV_NAME,
-	.tseg1_min	= GRCAN_CONF_PS1_MIN + 1,
-	.tseg1_max	= GRCAN_CONF_PS1_MAX + 1,
-	.tseg2_min	= GRCAN_CONF_PS2_MIN,
-	.tseg2_max	= GRCAN_CONF_PS2_MAX,
-	.sjw_max	= GRCAN_CONF_RSJ_MAX,
-	.brp_min	= GRCAN_CONF_SCALER_MIN + 1,
-	.brp_max	= GRCAN_CONF_SCALER_MAX + 1,
-	.brp_inc	= GRCAN_CONF_SCALER_INC,
+	.tseg1_min	= 2,
+	.tseg1_max	= 16,
+	.tseg2_min	= 2,
+	.tseg2_max	= 8,
+	.sjw_max	= 4,
+	.brp_min	= 1,
+	.brp_max	= 256,
+	.brp_inc	= 1,
 };

 static int grcan_set_bittiming(struct net_device *dev)
--
2.51.0


