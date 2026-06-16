Return-Path: <linux-can+bounces-7840-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jSCUMHi8MGonWwUAu9opvQ
	(envelope-from <linux-can+bounces-7840-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 05:01:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C35BA68B970
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 05:01:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=O4b8lmSL;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7840-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7840-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB1B3015A7A
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 03:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C7A37A498;
	Tue, 16 Jun 2026 03:01:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F555DDCD
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 03:01:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578868; cv=none; b=g79Z8bfmv8aaKduLtn+0/VFqa7RnLkurHDCGnj6Bl3fwdmINrn4ki8oyUwAkCe82l5tJRw+K1wNCtRjx4Weq2rufdWW6ryTGhnkvPPkAjWV9RLzEylGv/uRmbWhbFHaK64yX1hohej1d/O7PiMb2CiZHJfqhVOPy1bBwx278MY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578868; c=relaxed/simple;
	bh=rJKFaIFofheaOWbiicYKQwQg80/bnxLcxkMPmb7qwIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xklm0mH1B4SXgnxNBjCG4Tpjdy9qE/n0W+sBvsJ+ti/bempUazMRNtteJaUO7q+QUl2sKqhJs5lAd1AiOoBHw4IN4q0gTpwnJuIYkOjTAUyB687aN2evvpJDsYtGzCzj4uQah0y0SByFBozooHcCIVyp75K/XMOPc3jmufw32GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O4b8lmSL; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1f
	AY+znJ5mW+Y74xezKFKE9HYJ9hz0Htpjn1G98NNDU=; b=O4b8lmSLVH3koA3la5
	0hEN0dusyWkFC2Qrs8gNAdN+21nInlA7g/CiM9RLdQITylldjed1mTcZTGOcudZV
	Gl7enm+n+NufR3jIYaTRacR9MABFbV3IeaYs8mwmQyj41Ny+9/xs1V/voY25flJH
	1k/Bt873IzPo0u8RhtNFzfVhE=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD319lKvDBq7apADw--.36791S2;
	Tue, 16 Jun 2026 11:00:28 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Kopp <thomas.kopp@microchip.com>,
	linux-can@vger.kernel.org,
	guoqi0226 <guoqi0226@163.com>,
	cuiguoqi <cuiguoqi@kylinos.cn>
Subject: [PATCH 1/2] can: mcp251x: Add ACPI device ID table for MCP2515
Date: Tue, 16 Jun 2026 11:00:18 +0800
Message-Id: <20260616030019.35845-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD319lKvDBq7apADw--.36791S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45trWkCr4xGryxGryxGrg_yoW8Xr1rpF
	sFyFy0krZ5WF4UGa13G3Wjva4Yg3WkZryIgrW7Ka4a9asrAw1DZFZ29Fyayrs3XrW5Gw13
	ZrWftryUCrZ8C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziFdg_UUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4g3oUWowvE1IEgAA3n
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,163.com,kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7840-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:mani@kernel.org,m:thomas.kopp@microchip.com,m:linux-can@vger.kernel.org,m:guoqi0226@163.com,m:cuiguoqi@kylinos.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C35BA68B970

This patch adds an ACPI match table for the MCP2515 CAN controller,
enabling driver binding on ACPI-enumerated SPI platforms.

Signed-off-by: cuiguoqi <cuiguoqi@kylinos.cn>
Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 drivers/net/can/spi/mcp251x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 0d0190ae094a..58495d7639b4 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -41,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
+#include <linux/acpi.h>
 
 /* SPI interface instruction set */
 #define INSTRUCTION_WRITE	0x02
@@ -1328,6 +1329,15 @@ static const struct spi_device_id mcp251x_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id mcp251x_acpi_match[] = {
+	{ "MCP2515", (kernel_ulong_t)CAN_MCP251X_MCP2515 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, mcp251x_acpi_match);
+#endif
+
 static int mcp251x_can_probe(struct spi_device *spi)
 {
 	struct net_device *net;
@@ -1558,6 +1568,7 @@ static struct spi_driver mcp251x_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
 		.of_match_table = mcp251x_of_match,
+		.acpi_match_table = ACPI_PTR(mcp251x_acpi_match),
 		.pm = &mcp251x_can_pm_ops,
 	},
 	.id_table = mcp251x_id_table,
-- 
2.25.1


