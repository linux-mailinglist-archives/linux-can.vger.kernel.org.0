Return-Path: <linux-can+bounces-6939-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NqzAOZXqWkh5wAAu9opvQ
	(envelope-from <linux-can+bounces-6939-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 11:16:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD11F20F8A7
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 11:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D013300B044
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2B137AA98;
	Thu,  5 Mar 2026 10:14:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BF331204;
	Thu,  5 Mar 2026 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705681; cv=none; b=njPy28LoCmJzZMUrc7c3u7hlcC8dg2vah6p4Krf1pCfcgog0r8zaAviCdfrfu6GDVY7JwNpHke6WeElvYb1hOcLj5KBlWd2VAKCrq+psJuVyFK/lXQAKUSIeeZCInEzGkIzQ3DUCxxnfzZZ6PqMp5aDLKXrto8BF2QJA1EIMTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705681; c=relaxed/simple;
	bh=Cg5jlckxE+jiFn7UU/ZRLKLTjztD8U+AW3q6wydO9Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOBBWYtqnzWYJJmpFzVOtvryQAJs922Wom4JdCd/HMncQJQvpIOlU9fPKGHCKIlNIMkkujLYnOeXZ28hGhJm2Y1q/uhvL6UCPteDZ60V6cAq3/4aUHqUpYtqjjQtCaBpbdUsbCKFnAiGFUlo5HqN2rpmtkCarxfNLIrjrWTeVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2EAC116C6;
	Thu,  5 Mar 2026 10:14:39 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] can: rcar_can: Convert to FIELD_MODIFY()
Date: Thu,  5 Mar 2026 11:14:37 +0100
Message-ID: <ee2e6aaacd5e061c972716ecaf8a929be7ef5f2e.1772705647.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD11F20F8A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6939-lists,linux-can=lfdr.de,renesas];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:mid,glider.be:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use the FIELD_MODIFY() helper instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
No changes in generated code.
---
 drivers/net/can/rcar/rcar_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index fc3df328e877c8fe..2727c5ce029c1baa 100644
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
2.43.0


