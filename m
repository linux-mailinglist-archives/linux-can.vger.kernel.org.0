Return-Path: <linux-can+bounces-7848-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aEELHIoVMWqFbQUAu9opvQ
	(envelope-from <linux-can+bounces-7848-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 11:21:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A2668D78F
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 11:21:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=Q+ZQnjaN;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7848-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7848-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492C2303816D
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48673B4E83;
	Tue, 16 Jun 2026 09:17:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115243451C6
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 09:17:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601444; cv=none; b=Gzn1qytAHu4z3CsWJi7/YrQCmfNk5i4+yiZE7stYtm8s5DYAD8lca+xYAU7wuAT5FWUpbuBJNDasnDO/ZtGy71UTItSmBT2lYjPqBOh8qovdoDZe01plPTXEJAwa+C8r2Ym9n4s+C4+faxcWvxkAJPYxcpfGb8gqNpSjVZFD7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601444; c=relaxed/simple;
	bh=1dpzyOm5MVPnUIKPrLHFxR+H7eT8qMSI/OH6xtJm42A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4KJpMOvYJlJeptCC8v80Ec5r34rRJJk6SKqzp2O+zFEkCwOLfa+DSEo43w3GFc1sTN/YiPNaHh5TdxTZZMrvpVdzAStt17H4MiMB7AOFnxEgeWvr2jF/AemO5xXbmK7zuqdC8qi5Sr8wF3Xv69I8XTVJB2EugF5jmjgg0MyWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q+ZQnjaN; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yw
	z/66YNyoPm79L8m3SWKQCvnWeF0IvPXoHm8ponavE=; b=Q+ZQnjaN67zNgxbsSG
	bddNL4Cz/CTfADGJFe4G8MAKdWet4GuEGKtDjx6lqYeXDRszdMNoClmWUaxzXfU2
	Ug1gvJBSK47PkZ4TChwEvbNGHQm/R8qPkgiIMvbFpZoOxO3KILb/eYCJ04O3P3Ru
	L01j0/x6JD7zMZD/rR0PfmAhk=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHTRd6FDFqkneCDw--.45447S3;
	Tue, 16 Jun 2026 17:16:45 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: sashiko-bot@kernel.org,
	mkl@pengutronix.de
Cc: guoqi0226@163.com,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net
Subject: [PATCH v3 1/1] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 17:16:40 +0800
Message-Id: <20260616091640.93275-2-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616091640.93275-1-guoqi0226@163.com>
References: <20260616090742.E80BE1F000E9@smtp.kernel.org>
 <20260616091640.93275-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHTRd6FDFqkneCDw--.45447S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45tF18urWUJF4kCw48Zwb_yoW8XF1DpF
	4DtF1qyrW5WF4UWw4rC3WUZa4Yg34DAryIgrWYka4YqryfJw1DZrs293W5Ars8JFW5GF13
	Zr93JryDG398u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UU-BiUUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4R4Lc2oxFH5i+AAA3s
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[163.com,vger.kernel.org,kernel.org,pengutronix.de,lists.linux.dev,hartkopp.net];
	TAGGED_FROM(0.00)[bounces-7848-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-bot@kernel.org,m:mkl@pengutronix.de,m:guoqi0226@163.com,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98A2668D78F

This patch adds an ACPI match table for the MCP251XFD CAN controller,
enabling driver binding on ACPI-enumerated SPI platforms.

Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 92a86083c896..0cde98f51f79 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/acpi.h>
 
 #include "mcp251xfd.h"
 
@@ -2212,6 +2213,14 @@ static const struct spi_device_id mcp251xfd_id_table[] = {
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
@@ -2442,6 +2451,7 @@ static struct spi_driver mcp251xfd_driver = {
 		.name = DEVICE_NAME,
 		.pm = &mcp251xfd_pm_ops,
 		.of_match_table = mcp251xfd_of_match,
+		.acpi_match_table = ACPI_PTR(mcp251xfd_acpi_match),
 	},
 	.probe = mcp251xfd_probe,
 	.remove = mcp251xfd_remove,
-- 
2.25.1


