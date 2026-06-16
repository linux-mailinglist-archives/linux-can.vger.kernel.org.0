Return-Path: <linux-can+bounces-7853-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id opDfI7ImMWoucwUAu9opvQ
	(envelope-from <linux-can+bounces-7853-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:34:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFCE68E57A
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:34:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=bzJ+gpiU;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7853-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7853-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D43A03049664
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162DC42B733;
	Tue, 16 Jun 2026 10:31:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D64183BF;
	Tue, 16 Jun 2026 10:31:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605863; cv=none; b=c5Uz0x+GJl2lAtYopHpIFXuV9r+VpNCKyjHkon+vORx6WhdUczLvJeAGy6vCcc/Cvy+xqbOMIqrzERJfRjD4KN4L3ymLugihqUeVR6iZSvwNEfOXIaprFdwBoNfINW1SR2Q67nWg2RIjNplo11saQFL5r/gOjwGbDJ8O/5NGkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605863; c=relaxed/simple;
	bh=lz0upy1ozAHLjEioZiVu8IKLDD/aIWO9Rav3gfvMdok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rgMs0h0MYCgo1O57ZnxISN+XEcYTS3SjYQQe8GgmpejYk0IODX1jzNa6+ra7LB8ca09RXXJIuXLMJHyAzjZDLzmWRhvt4nxXZBAOzGEJZLM6FuDD9JVFPx0/H8zs3qyxqbDm6/rUKbxZk+j0Vnb1jvl4275UYILwEU/srg1AZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bzJ+gpiU; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mp
	YEmMzQjkMDVQ9CnZxjY2Ww8HQjucdF8VqO8IyIqwg=; b=bzJ+gpiU+8OALhDGK4
	hSt0WZTHZeTSOovtcCid6kvQZ2kFBXWZ4Dca4etMajvHj5yls+DkYTRjrLc/H6tn
	yt+kaW+3ROcdiZo4AW8UIDjAOiCu2WmJ68wS4uAiczUhkhB2RIaxyE5SbsuW6P8v
	bqwUuO5RF06gQrs6Cn85lQ9vI=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnrK69JTFqGSqCDw--.29972S3;
	Tue, 16 Jun 2026 18:30:24 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: sashiko-bot@kernel.org,
	mkl@pengutronix.de,
	Mark Brown <broonie@kernel.org>
Cc: guoqi0226@163.com,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net,
	linux-spi@vger.kernel.org
Subject: [PATCH v4 1/2] can: mcp251xfd: mcp251xfd: Cache and validate match data pointer in probe
Date: Tue, 16 Jun 2026 18:30:17 +0800
Message-Id: <20260616103018.105612-2-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616103018.105612-1-guoqi0226@163.com>
References: <20260616092614.00ED51F00A3D@smtp.kernel.org>
 <20260616103018.105612-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnrK69JTFqGSqCDw--.29972S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1xtw43ArWDWw4DXFW7CFg_yoW8AF45pF
	4DGF1qyrWDXF47Kws8CayUZa45Ww4qyry8WFZIk34jgr4fAw1DAr1I93W5Zws2yFWrGF13
	Arn3Xr18WasFgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWv3nUUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-gBgyGoxJcBaSAAA36
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[163.com,vger.kernel.org,kernel.org,pengutronix.de,lists.linux.dev,hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7853-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-bot@kernel.org,m:mkl@pengutronix.de,m:broonie@kernel.org,m:guoqi0226@163.com,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,m:linux-spi@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BFCE68E57A

Cache the result of spi_get_device_match_data() to avoid duplicate calls.
Add NULL check before dereferencing to eliminate unsafe raw pointer access.

Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 0cde98f51f79..7b50228602f4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2231,6 +2231,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	bool pll_enable = false;
 	u32 freq = 0;
 	int err;
+	const struct mcp251xfd_devtype_data *match_data;
 
 	if (!spi->irq)
 		return dev_err_probe(&spi->dev, -ENXIO,
@@ -2282,6 +2283,11 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	if (freq <= MCP251XFD_SYSCLOCK_HZ_MAX / MCP251XFD_OSC_PLL_MULTIPLIER)
 		pll_enable = true;
 
+	match_data = spi_get_device_match_data(spi);
+	if (!match_data)
+		return dev_err_probe(&spi->dev, -ENODEV,
+				     "Failed to retrieve device match data\n");
+
 	ndev = alloc_candev(sizeof(struct mcp251xfd_priv),
 			    MCP251XFD_TX_OBJ_NUM_MAX);
 	if (!ndev)
@@ -2317,7 +2323,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
 	priv->xstbyen = device_property_present(&spi->dev, "microchip,xstbyen");
-	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
+	priv->devtype_data = *match_data;
 
 	/* Errata Reference:
 	 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789E 4.,
-- 
2.25.1


