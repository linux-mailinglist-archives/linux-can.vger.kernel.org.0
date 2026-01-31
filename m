Return-Path: <linux-can+bounces-6424-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPXsA2HWfWn/TwIAu9opvQ
	(envelope-from <linux-can+bounces-6424-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 11:16:01 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC36C1857
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A97CE3013A94
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFE333FE0A;
	Sat, 31 Jan 2026 10:15:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63533BBD1
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854533; cv=none; b=HWXxZ8RqddQc4IUXASoMdLXMtwPT6tYJK6+pDe4DMYi5wWhv/GM+AEJVJUVvrSE+q47lH4R/deeDnyB7P2SnVrZ2Q0pGaeHIVsSB484lhSDYGo48i49b4+IQdW5W6LQ6iZuKG5qnK54HDBJVSYWYpPvzLcjvs42A0AGXdr59eyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854533; c=relaxed/simple;
	bh=Vv4IiphQbKguM28KLcNoTFbFQdKsFQXjOWT6P8dxtDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha4Tf09i1AWoLriSW8or8gONawrjxidVPcRiLuLV6cqCIELqtlM8Jz9fLBoLfclrYAhg4tcIG/8UKV6qiXAW8NEGRphmYkJocpumMq6ZZD9s/eHZwDUacKdisJM9jmnFhGUs/D+7LC4C39ZDoV5zkKnoDI13B2rjRMdMGktq1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80b-0002Q0-VE; Sat, 31 Jan 2026 11:15:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80c-003OWK-1D;
	Sat, 31 Jan 2026 11:15:17 +0100
Received: from blackshift.org (unknown [IPv6:2001:67c:1810:f051:d04a:1c63:e2:421c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 37EE94DC56E;
	Sat, 31 Jan 2026 10:15:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/8] can: rcar_canfd: Add support for FD-Only mode
Date: Sat, 31 Jan 2026 11:11:43 +0100
Message-ID: <20260131101512.1958907-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131101512.1958907-1-mkl@pengutronix.de>
References: <20260131101512.1958907-1-mkl@pengutronix.de>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-6424-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 7BC36C1857
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode called
FD-only mode. In this mode, communication in Classical CAN frame format is
disabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251126155911.320563-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7895e1fdea1c..4a653d8978ba 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -472,6 +472,7 @@ struct rcar_canfd_global {
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
+	bool fd_only_mode;		/* FD-Only mode for CAN-FD */
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
 	const struct rcar_canfd_hw_info *info;
@@ -829,12 +830,20 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 							 RCANFD_GEN4_FDCFG_FDOE);
 				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 						       RCANFD_GEN4_FDCFG_CLOE);
+			} else if (gpriv->fd_only_mode) {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_CLOE);
+				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+						       RCANFD_GEN4_FDCFG_FDOE);
 			} else {
 				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 							 RCANFD_GEN4_FDCFG_FDOE);
 				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 							 RCANFD_GEN4_FDCFG_CLOE);
 			}
+		} else if (gpriv->fd_only_mode) {
+			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+					       RCANFD_GEN4_FDCFG_FDOE);
 		}
 	}
 
@@ -2140,6 +2149,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->fdmode = fdmode;
 	gpriv->info = info;
 
+	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
+		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */
+
 	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
 	if (IS_ERR(gpriv->rstc1))
 		return dev_err_probe(dev, PTR_ERR(gpriv->rstc1),
@@ -2239,7 +2251,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
 		 gpriv->extclk ? "ext" : "canfd",
-		 gpriv->fdmode ? "fd" : "classical");
+		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
 	return 0;
 
 fail_channel:
-- 
2.51.0


