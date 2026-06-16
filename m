Return-Path: <linux-can+bounces-7841-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 89NxN3i8MGopWwUAu9opvQ
	(envelope-from <linux-can+bounces-7841-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 05:01:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344768B971
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 05:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=LOoq44HT;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7841-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7841-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7CE33014255
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 03:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA99DDCD;
	Tue, 16 Jun 2026 03:01:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B522F1FEA
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 03:01:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578868; cv=none; b=Q2x8QyIFpRMNuBtGBuNx3zQfjm1Mj67fhRZmGAjsigmLA0J++qKaJs7Tpfhu/D25XhBzDzaiXWSxlXtPffBHjIRRRBE62DP+/bi2mt31CScBN2inmrIwehyj52Ki5PI0WCao5QRS0803qnuy5xkKule4MTJSI4JMY6A6hC6spT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578868; c=relaxed/simple;
	bh=JTS9jzSzmwrNKK4GONHKNSpuShRFEl61SD4nI3NPkjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4CYuzjAr5mlNmFzQOcxMzRzQfFXE0TOxYtDZzeMhJC3adfBHfSo8zkoukp8Rup7+NvGNTYZMwaLe1Uo5UkjZ06D5uhROGvUe72yB7z7ByJf/lNCTvPTqugTUsmRM0t5Z4OZKJIYAgN6ZvUMKB95/+6WWy8TfqT6AWqJ3UA96KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LOoq44HT; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ej
	87C8QEfq0kmjNw3b5CfhZpIDPUP+zYDRZZCxV1kAI=; b=LOoq44HTPBJq38oLfy
	oD3jKeHngExbXHWTGrwXa4PBDfp65FJsfizEcVoYEX0gvU/NWgW1zDRU+A3niwsP
	6PwQLtSoDscP6LKzK2tigesfDNgPG5WXQy/HUyBcHcY61IoX8hmTYM3sxaQ1p3j5
	CH3b0NMtnghDiVkFcEOeYEg3g=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD319lKvDBq7apADw--.36791S3;
	Tue, 16 Jun 2026 11:00:39 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Kopp <thomas.kopp@microchip.com>,
	linux-can@vger.kernel.org,
	guoqi0226 <guoqi0226@163.com>
Subject: [PATCH 2/2] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 11:00:19 +0800
Message-Id: <20260616030019.35845-2-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616030019.35845-1-guoqi0226@163.com>
References: <20260616030019.35845-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD319lKvDBq7apADw--.36791S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45tF18urWUJF4kCw48Zwb_yoW8XF1kpF
	4DtF1qyrWUWF4UWw4rC3WUZa4Yg34DAryIgrWYka42qryfJw1DZrs293W5Ars5JFW5GF13
	Zr93JryDG398u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziloGdUUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4hjrVGowvFhJxQAA33
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:mani@kernel.org,m:thomas.kopp@microchip.com,m:linux-can@vger.kernel.org,m:guoqi0226@163.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7841-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7344768B971

This patch adds an ACPI match table for the MCP251XFD CAN controller,
enabling driver binding on ACPI-enumerated SPI platforms.

Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 92a86083c896..3fc6e82abe4e 100644
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
+	{ "MCP251XFD", (kernel_ulong_t)&mcp251xfd_devtype_data_mcp251xfd},
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


