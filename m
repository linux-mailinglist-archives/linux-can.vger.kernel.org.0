Return-Path: <linux-can+bounces-7859-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BCFxJccrMWqRdAUAu9opvQ
	(envelope-from <linux-can+bounces-7859-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:56:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8196968E868
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:56:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=J3q2xuKn;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7859-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7859-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F683162B47
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781C436355;
	Tue, 16 Jun 2026 10:53:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33742EEC7;
	Tue, 16 Jun 2026 10:52:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607180; cv=none; b=LvwJ2fL/ngcx3y6FkSQlhV+CGFFwe7Uwzp4S4FV4DaZLO/8JaaEL4boT5+lBN0NWnjom6ZcBZjZHmNgcx00zvnR8DnfM9zdv750a4N9ecDAg67uLZOYeCiBjxAaO1QpRsZPWkQR+tx3/MZXetnSEVihAsFOZHJXiJxjOtQjKEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607180; c=relaxed/simple;
	bh=Z5LSD7vYP5onXf7YoiAJPpPZXCSado6hBcvPjxlIXfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfOcMk1Mz9FUbdLrFhDWmLZ2cpjBN8hReAcvKglB1sjWwqYIJSfv2kUJVmxI+jJTuQS9kMZ0B0bRaex1ftKN8MHU1f2DXLfqNbZAPl3MTN/+5E45Y+RQ2PKvcp7FI+6L4fN4C7DBpT8a+ndQoYbTq8mBdnbyglrPtsEtY/gDtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J3q2xuKn; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/f
	NuUMlCAps98ctZ2uZPHbDjC+ymBw4KmZ3nK8pyl7Q=; b=J3q2xuKn+KIuwbBOtZ
	1WCkcUJi71gDGqBpunhWZHYBI81E1+zmEfnX/yW2Svovapnb+zJN7W6ygaExLF59
	Jf+d7wWRSSRu8tVcdPHd8HXsQFs3+ns+vVhFi/zuHOylbAzkQt/bqrCGM7I/gcXM
	uM8BNtl3u+I73wjo6XQAAjKDE=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wA3YpXsKjFqzSQCDw--.28086S2;
	Tue, 16 Jun 2026 18:52:28 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: broonie@kernel.org
Cc: guoqi0226@163.com,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	o.rempel@pengutronix.de,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net
Subject: Re: [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 18:52:27 +0800
Message-Id: <20260616105227.109352-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <997991e6-0e09-47eb-a6ac-5f455ddc250a@sirena.org.uk>
References: <997991e6-0e09-47eb-a6ac-5f455ddc250a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3YpXsKjFqzSQCDw--.28086S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRIPfqDUUUU
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-g2sFWoxKu2jZwAA3S
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
	TAGGED_FROM(0.00)[bounces-7859-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[guoqi0226@163.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:guoqi0226@163.com,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:sashiko-bot@kernel.org,m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8196968E868

While fixing the mcp251xfd driver, I found a latent flaw in spi_get_device_match_data(), 
so I sent both fixes as one patch series for unified review.
There is no hard build or runtime dependency between the two patches. 
They can be merged separately into the SPI and CAN subsystem trees respectively.

Thanks,
guoqi


