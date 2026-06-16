Return-Path: <linux-can+bounces-7845-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +Pw3OF4PMWrkawUAu9opvQ
	(envelope-from <linux-can+bounces-7845-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:54:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 399E168D52F
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:54:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=OW1MJ9So;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7845-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7845-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96AC6303DAB8
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E340E8EF;
	Tue, 16 Jun 2026 08:54:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E714183DE
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 08:54:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600085; cv=none; b=OLbKp75PHsf8YwSN13KNfDoSo0l2UVrZQtPjjb6KlCW9PFz8qQSkpoL3rtwpsLBhzkhivQTEi+v6ZzF6TknmWzSMkgI2w/JWiuMp9qZ65NPJmAK2nqA42UOeG3EWPE28VrHfJGQJBDgnOLaF3EBdlrr9d3vjxOlz9o4QLnVaVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600085; c=relaxed/simple;
	bh=jY2iMCSOh2cMOiEI8qWkxyY9tdmhfIpJYUvoK4sW0Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLcHmoXCYVUQNWtZUX+tzP9GQlFZ4D36yFcp0JXYe+0o36qLCIHnuzvmUMcMg9U2bmLha7d9ul1qtkZvijyLhwLqHr6eNrWmNWeELdgFuWSDJ1rTYTMCTp/A4pt5G0lzBJSSkM7riemAoZGhERwG8iPMTYA+9iKTOUZfGCxGlUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OW1MJ9So; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=44
	SW/x8wXDaBWMGB26VUDUNVEBqTyRGs4639vhQHD8E=; b=OW1MJ9SoFmBXa54Qcm
	Z3Cgi4oc8mi351S1tbVSa2uVrJdXChtOmLsTDZbdbPrb/zOEBf96gHl9iO8NsNj+
	JAmiqx0ZHc6+fUPUMbM2Hkx+Bc+3QdoMh+mfTkuh68+L/7PX0s7JVYgWiXyLp+3N
	SGE+81TkHmPZiTroLNQD0sIRU=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnEpYsDzFqEuHvDg--.40923S3;
	Tue, 16 Jun 2026 16:54:08 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: mkl@pengutronix.de,
	sashiko-bot@kernel.org
Cc: cuiguoqi@kylinos.cn,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	mani@kernel.org,
	thomas.kopp@microchip.com,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net,
	guoqi0226 <guoqi0226@163.com>
Subject: [PATCH v2] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 16:53:59 +0800
Message-Id: <20260616085359.89406-2-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616085359.89406-1-guoqi0226@163.com>
References: <20260616031332.0F34C1F000E9@smtp.kernel.org 20260616-teal-wrasse-of-conversion-348af0-mkl@pengutronix.de>
 <20260616085359.89406-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnEpYsDzFqEuHvDg--.40923S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45tF18urWUJF4kCw48Zwb_yoW8AF1fpF
	4DtF1qyrWUGF4UWa15C3WDZ345X34DAry0grWaka4jqryfAw1UZFs293W5Ars5JFW5GF13
	Zr93AryDG3y5W37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0LvNUUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-hC2H2oxDzCohQAA3O
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,vger.kernel.org,kernel.org,microchip.com,pengutronix.de,lists.linux.dev,hartkopp.net,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7845-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:sashiko-bot@kernel.org,m:cuiguoqi@kylinos.cn,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:mani@kernel.org,m:thomas.kopp@microchip.com,m:o.rempel@pengutronix.de,m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,m:guoqi0226@163.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 399E168D52F

This patch adds an ACPI match table for the MCP251XFD CAN controller,
enabling driver binding on ACPI-enumerated SPI platforms.

Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 92a86083c896..031967370728 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/acpi.h>
 
 #include "mcp251xfd.h"
 
@@ -982,7 +983,6 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 
 static int mcp251xfd_handle_txatif(struct mcp251xfd_priv *priv)
 {
-	netdev_info(priv->ndev, "%s\n", __func__);
 
 	return 0;
 }
@@ -2212,6 +2212,14 @@ static const struct spi_device_id mcp251xfd_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id mcp251xfd_acpi_match[] = {
+	{ "MCHP15FD", (kernel_ulong_t)&mcp251xfd_devtype_data_mcp251xfd},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_match);
+#endif
+
 static int mcp251xfd_probe(struct spi_device *spi)
 {
 	struct net_device *ndev;
@@ -2442,6 +2450,7 @@ static struct spi_driver mcp251xfd_driver = {
 		.name = DEVICE_NAME,
 		.pm = &mcp251xfd_pm_ops,
 		.of_match_table = mcp251xfd_of_match,
+		.acpi_match_table = ACPI_PTR(mcp251xfd_acpi_match),
 	},
 	.probe = mcp251xfd_probe,
 	.remove = mcp251xfd_remove,
-- 
2.25.1


