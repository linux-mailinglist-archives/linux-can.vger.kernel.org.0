Return-Path: <linux-can+bounces-7849-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ahBACqkUMWpLbQUAu9opvQ
	(envelope-from <linux-can+bounces-7849-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 11:17:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AFC68D710
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 11:17:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=JSGFe2uk;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7849-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7849-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC4A23006003
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47D03ABDA4;
	Tue, 16 Jun 2026 09:17:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C735D615
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 09:17:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601444; cv=none; b=NxA6+uE9uN49yWr1QXj5N3tAezVIDDTY5GVDyu+TaA2Qyd4t93NlUmX0NsV+OibPGD5v0U8wC1we43u7FhqRjY3gbwxeXtMt2r86sleIp06VCQaRiyYzVAncqpAM0XTJ0oMLhaPC2NfpbjkJ0JdN8Qj5l7DqxWUW4KoCfcZKQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601444; c=relaxed/simple;
	bh=v8qUlZlYL5EDEonR7yZrumedOGixVc88sqh74qva4To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiQXgcNAtfwD1/D5vKRS7Pc4WnCguQgUYxznyP/bxpfYx0DyAUPEVfFVGeVbWeakouX9NV29HpjFRLG6MzU0sCsK9vmLBPaQtBTp7GXF5zs/bdR82ZuSrUQ5VOk7W8oWsvFnNmaxygIqYgwJrani3UL3UsRAtzePTdP2ewfAD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JSGFe2uk; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4X
	OZLI3YNNOUnqxkS6rCc5AqvKbHZvIEqbeNN07qW2A=; b=JSGFe2uk0e6JWqeyQO
	cLWOSNZDhrIamRGU2HFsaTVaeRq1ijdcbSNpuqZZCZWxMQXF9/OlG3ehPABg1q+e
	18TeD+0ab++okDuK17J2qx76Mo82NtYeST5KCtIkq4TjDJhGCSaQmLLlV0hwu5US
	sROpYIrJACSSMUCjh3veGiobE=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHTRd6FDFqkneCDw--.45447S2;
	Tue, 16 Jun 2026 17:16:43 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: sashiko-bot@kernel.org,
	mkl@pengutronix.de
Cc: guoqi0226@163.com,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net
Subject: [PATCH v3 0/1] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 17:16:39 +0800
Message-Id: <20260616091640.93275-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616090742.E80BE1F000E9@smtp.kernel.org>
References: <20260616090742.E80BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHTRd6FDFqkneCDw--.45447S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RgJ5FUUUUU
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4RsKcmoxFHtivwAA3r
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[163.com,vger.kernel.org,kernel.org,pengutronix.de,lists.linux.dev,hartkopp.net];
	TAGGED_FROM(0.00)[bounces-7849-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-bot@kernel.org,m:mkl@pengutronix.de,m:guoqi0226@163.com,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54AFC68D710

Sent incorrect patch accidentally, fixed in this version

changed v3
Recover accidentally deleted netdev_info log line with __func__
-	netdev_info(priv->ndev, "%s\n", __func__);

guoqi0226 (1):
  can: mcp251xfd: Add ACPI device ID table for MCP251XFD

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.25.1


