Return-Path: <linux-can+bounces-6259-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI4ZHPYZcmnrbwAAu9opvQ
	(envelope-from <linux-can+bounces-6259-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:37:10 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D300A66B7C
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D013A926D68
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 12:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C59143DA47;
	Thu, 22 Jan 2026 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="LBLqWyrc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D217B418;
	Thu, 22 Jan 2026 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083858; cv=none; b=L/VYiJkNI4s+ZMwN+/HBmLFNC1OoSUaQfe/b/Dz1W9o7RXBoLiMEZU9dcWibc/hNO7KkuKtF0epTz/eA73iQkAYOfLCmnPqJv+LJDJpanzRuSopnaG/y9Ee7By2AxoH7ou+kyfrdIPSvaU60ReGdD7aGA0fLIySLtayAqzyU03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083858; c=relaxed/simple;
	bh=FNNZIBsrSgLHj2js+iZmraPJB/UTYKawHLKl2DBMccw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYU+6OK6cc+g/sVjS08yZd6cU3xcJ6QE/v+BsQL3qZg/aiIU4XXIWRFPC65fg0dEktIiALhjCZ1Ir7SyP6RUtIQIEDp1D9hQ2GlWsycrUhxjDz9fAEBhi1I6KCntPewTd/o/wN0OcF1g2Sl3AZecBpz3FpLISxjs4DE1RUqb4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=LBLqWyrc reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzC0X7Cz1DHbk;
	Thu, 22 Jan 2026 13:10:47 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzB4jPwz1Fgd9;
	Thu, 22 Jan 2026 13:10:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083846;
	bh=nSjMvwsSVcamn5+lgzYFxW7/Q79hZjUMP4od70MbxlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBLqWyrc8XgQsPUmfXNpqd3bm7mJM7u8mcO31dM7EJr9Aa+AA2cx1+OKLWSpnx6Od
	 1okXGnyijsaL2UDgjHp4BfFZb/luufiuM+zfFFIIJsGL8i2veI3XoVNeUgarVVujq0
	 XweEh5Lp5tzqTdZqfAWgx1NI4jLyeq3X7GGPGT4pivlsjSxn+Dyj6jRgwgZx0Nz9XK
	 4Tzc0gcygqvQwuLTYIxRZElX9sDxoXxUMUskhvBM72sVg9InwDOHarFSTivClvIZd3
	 H77kK9TXDsnmV1jtSn0OXRXBktk5PdiLYPRItY5+NFMLAU1pKcEkTXTQlhFHpRFiK8
	 pBA0dgBqGp1fQ==
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
Subject: [PATCH v3 05/15] can: grcan: Replace bit timing macros with literal values
Date: Thu, 22 Jan 2026 13:10:28 +0100
Message-ID: <20260122121038.7910-6-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : No valid SPF,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6259-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: D300A66B7C
X-Rspamd-Action: no action

Refactor the bit timing constants in grcan_bittiming_const by replacing
macros with literal values.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/grcan.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 538a9b4f82ab..f34ca558fa5d 100644
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


