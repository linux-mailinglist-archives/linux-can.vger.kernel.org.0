Return-Path: <linux-can+bounces-7307-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPgIGFTMzGlFWwYAu9opvQ
	(envelope-from <linux-can+bounces-7307-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Apr 2026 09:42:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB38376297
	for <lists+linux-can@lfdr.de>; Wed, 01 Apr 2026 09:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB14230B3970
	for <lists+linux-can@lfdr.de>; Wed,  1 Apr 2026 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D66221FBD;
	Wed,  1 Apr 2026 07:33:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D736923B
	for <linux-can@vger.kernel.org>; Wed,  1 Apr 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028835; cv=none; b=HGFaHtDZ5fTOzklh4ezATCi3eNkQZrHJ/3sAAwTAWmG+O2qQTPYNxSV9abjPquxTdlki0TsgGROB7rHvro1lWxC/9uiazYZ5QReDYQhW6T78BG3MwW4GS1/mce/e9Bpkmps+tvCzy3XHRIsOQ7yyiEkVvIPsFLRcJyHPxAgLj+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028835; c=relaxed/simple;
	bh=gZGiGnsfC/d+64wqmpHAt9CUrjDY2JKgCXf5EK8b7Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhBdWRLDsclgdIRddB+KndBASSGpKvKkj4tzEHVLgqCFPTyQz0mbi7Mw6gV2+VfcwncYFYabJnf+f34PJG0EtS/4S9R13onPOPCWHg1YZRl6hcAWihN9YzU9bMNJPsyxX8z6kwqTBp3XK8MgMrpkGE5EJbE1dCf5drE6DHQ7nA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-00076g-TL; Wed, 01 Apr 2026 09:33:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-003Ahd-1X;
	Wed, 01 Apr 2026 09:33:41 +0200
Received: from blackshift.org (unknown [IPv6:2a0a:edc0:0:701:a82f:fdef:12b2:33d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 20390513378;
	Wed, 01 Apr 2026 07:33:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 5/6] can: rcar_can: Convert to FIELD_MODIFY()
Date: Wed,  1 Apr 2026 09:30:13 +0200
Message-ID: <20260401073338.5592-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401073338.5592-1-mkl@pengutronix.de>
References: <20260401073338.5592-1-mkl@pengutronix.de>
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
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7307-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.444];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,glider.be:email,pengutronix.de:email,pengutronix.de:mid,msgid.link:url]
X-Rspamd-Queue-Id: 0BB38376297
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use the FIELD_MODIFY() helper instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/ee2e6aaacd5e061c972716ecaf8a929be7ef5f2e.1772705647.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index fc3df328e877..2727c5ce029c 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -496,8 +496,7 @@ static void rcar_can_start(struct net_device *ndev)
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* Go to operation mode */
-	ctlr &= ~RCAR_CAN_CTLR_CANM;
-	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_OPER);
+	FIELD_MODIFY(RCAR_CAN_CTLR_CANM, &ctlr, RCAR_CAN_CTLR_CANM_OPER);
 	writew(ctlr, &priv->regs->ctlr);
 	for (i = 0; i < MAX_STR_READS; i++) {
 		if (!(readw(&priv->regs->str) & RCAR_CAN_STR_RSTST))
-- 
2.53.0


