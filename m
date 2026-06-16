Return-Path: <linux-can+bounces-7854-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g9mbHj4nMWpUcwUAu9opvQ
	(envelope-from <linux-can+bounces-7854-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:36:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF068E5F4
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:36:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=dChSsKnw;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7854-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7854-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2402130F0682
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682FF42EED9;
	Tue, 16 Jun 2026 10:31:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784EB42EEA2;
	Tue, 16 Jun 2026 10:31:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605866; cv=none; b=B+3YF4FAp400qKBXDsj8BH3gW7MjQx5C9LUEomZevsfSJxKBqkrBOnz7k/wmgg51uNUqMVCQ413acGaDHTVmq1ElY4qm5ddhjhw9YpWxHDYYkcx7xKt6vGkRmiqYE54YBoYmUGzYCHEKKrgFbJVlU9/DpsVTw9XVSmr+lFLM/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605866; c=relaxed/simple;
	bh=cqOjxDGzVeBxs6zy8kgxNbggYoD47iaMB4/f2gHj0QY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4NO9yFtkTXIPnHgeL013unZjJub4HBPc9efgKMUA0CPv41rmPWxgzuR+fr6Oxc7FlOY8bzyTGY11PEwwS+SxDcBuqk+I6k5nlUDHOZlAhLb/yO9B3JAQfvLZQ5o3o32SrU6Ihe24HccxGw/C1gX1k01hryNllyO9nwXm/h+6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dChSsKnw; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uB
	iz5AeQPmYg1Yr33SDLUeePjjMYfAg/rzpbrEhs8HQ=; b=dChSsKnwx3VwTIpIvr
	v6nLYHg1ZwlNfmyuyj27IOAiGmO5h2Akq9qV/1gDnHInW5DhGjJo0botCKYYiEDe
	tM2VsVRuZ+PEG2dIq4D5+pU2LRxPvDxLN3P9mRQz7dTR3kJ7yDmRsxeyujGtMNu3
	Y9cu9EIVCxdNo597qQtQ47fJA=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnrK69JTFqGSqCDw--.29972S2;
	Tue, 16 Jun 2026 18:30:22 +0800 (CST)
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
Subject: [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 18:30:16 +0800
Message-Id: <20260616103018.105612-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616092614.00ED51F00A3D@smtp.kernel.org>
References: <20260616092614.00ED51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnrK69JTFqGSqCDw--.29972S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RuXdbDUUUU
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-h5fx2oxJb5aGgAA34
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
	FREEMAIL_CC(0.00)[163.com,vger.kernel.org,kernel.org,pengutronix.de,lists.linux.dev,hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7854-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1BF068E5F4

hanges in v4:
- Split into two separate patches:
  1. SPI core: add internal NULL guard for spi_get_device_match_data()
  2. mcp251xfd driver: cache and validate match data pointer in probe
- Remove duplicate spi_get_device_match_data() invocation and unsafe dereference

guoqi0226 (2):
  can: mcp251xfd: mcp251xfd: Cache and validate match data pointer in
    probe
  spi: Add NULL check for spi_get_device_id() in
    spi_get_device_match_data()

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 8 +++++++-
 drivers/spi/spi.c                              | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.25.1


