Return-Path: <linux-can+bounces-6363-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EApNL4kkemkO3QEAu9opvQ
	(envelope-from <linux-can+bounces-6363-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 16:00:25 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0A1A36A9
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 16:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48338309A25E
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53E2369205;
	Wed, 28 Jan 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Cg5ZeKQO"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B7350A2C;
	Wed, 28 Jan 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611777; cv=none; b=cAVD+z3brPRRgrpEpEQx5elpDI6sT7LdeH9HYYkAQXxPcJ5xsrTtjYLQ+JhgLYuUYundTObZ5XBTFKc1Wn2k+cjMi+RsYtOq2b0b4ZSsqUsT0PRfvTv1CnxDYGlsu+Dcbap67LpfchAlN8ewTO7ZwWW1CZJHVkF6+2yEMSaTA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611777; c=relaxed/simple;
	bh=2XI+kEnL0TlyTyqFkt/kZCVxZGcDhK23q6AphLO89ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI2jvhwgBIlYxHD6EQe1jS3us9xORhyBBhc0b0Vtz7VOU8orGmLqPXeaI3rI3Qotxia6tFT0w+514WsGDFZmnfSMBth1oQRmK//h8P1jQpUg8lH7O4dgRRXh15hEP3nqV7KoqrYn3/Sj1nFjKaylFcj98icB4NVVrkJosaF25UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Cg5ZeKQO reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCc3LZcz1FDXb;
	Wed, 28 Jan 2026 15:49:32 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCb6gzGz1FQVl;
	Wed, 28 Jan 2026 15:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611772;
	bh=bWrGRAw1Ymt+kLMgEE+iCVDAba/QTAuev1cp5/ho8Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cg5ZeKQO8JfCKsw83clxCkxnu9n8jmENAfuLZ+LaTduQ8tIrIklq75G7GAhAQAyyk
	 KJBVbU2yUDn8beBHnEWHA25qw6KlGHddnIBAPC9TqJ3rKTT00UakIjhkG6P+Vl/X1o
	 Hu0bdTGD0gM2YjfF6sezo1QEIRb62RWCXDMJUNBzkOYKSXkyz5BdRihXerwQ78VvPI
	 ZClOKpreh0T/jjk/7z/LUGlu+9YSOL+R2Ku2yolZKcU5eperG+n0Z40tJJhPNEyHeH
	 o+oBB+uJYVbs/jFLtaN6gNzrIlYVlxTKcbavzelktFrQBlol00gMuTkP6uO7xVUhPK
	 H5GhiFbKLrs0g==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v4 15/15] can: grcan: Advertise CANFD capability
Date: Wed, 28 Jan 2026 15:49:21 +0100
Message-ID: <20260128144921.5458-16-arun.muthusamy@gaisler.com>
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
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6363-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: 2E0A1A36A9
X-Rspamd-Action: no action

Advertise CANFD capability for GRCANFD hardware by enabling
CAN_CTRLMODE_FD flag and providing CANFD timing operations.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index e6f3cd36ea66..120e722cc59e 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1749,11 +1749,14 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
 	priv->can.bittiming_const = hwcap->bt_const;
+	priv->can.fd.data_bittiming_const = hwcap->bt_const;
 	priv->can.do_set_mode = grcan_set_mode;
 	priv->can.do_get_berr_counter = grcan_get_berr_counter;
 	priv->can.clock.freq = ambafreq;
 	priv->can.ctrlmode_supported =
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
+	if (hwcap->fd)
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->need_txbug_workaround = txbug;
 	priv->hwcap = hwcap;

--
2.51.0


