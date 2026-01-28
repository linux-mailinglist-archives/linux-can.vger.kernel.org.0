Return-Path: <linux-can+bounces-6358-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM2CGx0jemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6358-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:54:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E4DA34CF
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A30430306C3
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88286366547;
	Wed, 28 Jan 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="S6BN+x+B"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3457364E85;
	Wed, 28 Jan 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611775; cv=none; b=p0z+LGiQMo8RzRM5rkIYdffE8erPRYHu2tw9p4L5euWI/qK4oA3K7m2VMiUjyawwhDrPldJJ5bSUejxZSV9YHtKi5OTpk2VGd4OoeOqQKL4vPNIQ2jUisVU2VzSt0pHVHMrokCf+B0rbw6kT7NU5rcPl487Jd81gqauYMo+Q71M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611775; c=relaxed/simple;
	bh=0JeFaaAsquUf7sT9m/pFX5d28x6116D6GvovNNfY5Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY3CzmQngvgcdvrqNw8JpflqTeimxiUvRPVtviDQHh7xaTPjxTbTHbAkmSOvLHBp8xDxPoQabz/TuFEIiiDee9txWwLpSgZFeCIqsCulKPSVgdSJEqieKBx/T33nrSF6RcUpHI6qyPEKmkkmlsS+ntOG5QzGlgx5v2YpCjNtA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=S6BN+x+B reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCb10Byz1FDYD;
	Wed, 28 Jan 2026 15:49:31 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCZ3PJqz1DPkK;
	Wed, 28 Jan 2026 15:49:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611771;
	bh=XhDpIgFvLtKYCf6Xd2LNeTP2TSc4kdJLbKvmX5frO1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S6BN+x+BaszGKMeHN4TFnlevOSvHd/+UZGs0XI/gbTMogr8j+8faomr1WeJYaDCBM
	 ooXE6cvcZcSHWGYBucBqWqDSjGV3bAt6LYoh6g/5y1xWUaApHnZuVJ5ca6DEUQn8eC
	 iYVrRgkhODa2hnv2TxF+u/hgODiYAkVjubh9Qt02tICqRvZ8UVvZZAkoCd6TahwFqx
	 gAfp9s+fzvyPTCAzJC8KXI+B2VbqsPlXEwfrCGMgxhMjE/QpKbDLVZhf5h3j2GpO9+
	 Jm/OF+bglGWvsItznBV/E8g4F5JujLKUkRMorS1hf1BPjEiwB8/pX2RAqfoGD+IEWT
	 b4KcjZjy/8blA==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v4 11/15] can: grcan: Reserve space between cap and next register to align with address layout
Date: Wed, 28 Jan 2026 15:49:17 +0100
Message-ID: <20260128144921.5458-12-arun.muthusamy@gaisler.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6358-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81E4DA34CF
X-Rspamd-Action: no action

From: Daniel Hellstrom <daniel@gaisler.com>

Reserves space between the capability register and the next register
within the GRCAN driver to align with the hardware address layout.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 0ceda12335bc..3104946071dd 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -49,7 +49,8 @@ struct grcan_registers {
 	u32 conf;	/* 0x00 */
 	u32 stat;	/* 0x04 */
 	u32 ctrl;	/* 0x08 */
-	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
+	u32 cap;	/* 0x0c */
+	u32 __reserved1[GRCAN_RESERVE_SIZE(0x0c, 0x18)];
 	u32 smask;	/* 0x18 - CanMASK */
 	u32 scode;	/* 0x1c - CanCODE */
 	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x40)];
--
2.51.0


