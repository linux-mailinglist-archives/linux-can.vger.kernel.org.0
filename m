Return-Path: <linux-can+bounces-7067-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGhONRz0r2nkdAIAu9opvQ
	(envelope-from <linux-can+bounces-7067-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 11:36:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC6C249730
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 11:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1386A303748B
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D881136EA90;
	Tue, 10 Mar 2026 10:36:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5E3314D2
	for <linux-can@vger.kernel.org>; Tue, 10 Mar 2026 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138964; cv=none; b=iVHPmut9ZLJ09qyAmCgiHoV0Bv5D+T15fynGZxuqrsAr4KVdzLizEL1u+M35Hg3+XWs3OkvABhvWiKd14XfFnibSly6LymEJsrIuaBcx36h0fp7Zg2OaPN+f5OXRqFuGvNqWiZdglsoAJtC5YOfnWb9BIbmjMtkse9H5G/QXPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138964; c=relaxed/simple;
	bh=tN6JaS7gg5JiKDF60xeQwht2M7cFmnKGfq6sCUyl7NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiZeKugD8ITgNd7x33gGDZLEJl91O2obZDJjlOywTbA9I0fkmuOO4ooIThcdQ7tQ5/hDaBwnlEeoKdFoHv/R4eWWgpP0FvPGlVpwN3OvcXMijGPWr8zevwdGDlW4ygA3q1uuXUgkKS4kIhahulXkaIh4+YU2J8sU2DrHgU7fvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzuRO-0001Ko-Mi; Tue, 10 Mar 2026 11:35:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzuRM-004gN5-1D;
	Tue, 10 Mar 2026 11:35:53 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6C50B4FD2B1;
	Tue, 10 Mar 2026 10:35:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Haibo Chen <haibo.chen@nxp.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/2] can: dev: keep the max bitrate error at 5%
Date: Tue, 10 Mar 2026 11:30:34 +0100
Message-ID: <20260310103547.2299403-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310103547.2299403-1-mkl@pengutronix.de>
References: <20260310103547.2299403-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 7BC6C249730
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-7067-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,pengutronix.de:mid,pengutronix.de:email,nxp.com:email]
X-Rspamd-Action: no action

From: Haibo Chen <haibo.chen@nxp.com>

Commit b360a13d44db ("can: dev: print bitrate error with two decimal
digits") changed calculation of the bit rate error from on-tenth of a
percent to on-hundredth of a percent, but forgot to adjust the scale of the
CAN_CALC_MAX_ERROR constant.

Keeping the existing logic unchanged: Only when the bitrate error exceeds
5% should an error be returned. Otherwise, simply output a warning log.

Fixes: b360a13d44db ("can: dev: print bitrate error with two decimal digits")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://patch.msgid.link/20260306-can-fix-v1-1-ac526cec6777@nxp.com
Cc: stable@kernel.org
[mkl: improve commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index cc4022241553..42498e9d3f38 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -8,7 +8,7 @@
 #include <linux/units.h>
 #include <linux/can/dev.h>
 
-#define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
+#define CAN_CALC_MAX_ERROR 500 /* max error 5% */
 
 /* CiA recommended sample points for Non Return to Zero encoding. */
 static int can_calc_sample_point_nrz(const struct can_bittiming *bt)

base-commit: e3f5e0f22cfc2371e7471c9fd5b4da78f9df7c69
-- 
2.51.0


