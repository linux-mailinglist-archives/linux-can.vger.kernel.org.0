Return-Path: <linux-can+bounces-3647-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F57AC076B
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0313BDA0C
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA43D2882B9;
	Thu, 22 May 2025 08:41:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9A2874F7
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903303; cv=none; b=iGT4ZCpRa2ja88YvPT2Y1voFOpAckm0g0B7tcKo4xOLZX0gO1IznmKlx09vtZ9KJSw+NUBMzIMcPM5Bv+vDgesbg0dz5uaG/pyJyMBJdAM3epSKr56dwb7VvhDqqQXho1lhVGALUlgc0/CmfvkaXJetrwNvP3SS1iylo7KRIc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903303; c=relaxed/simple;
	bh=a/DmCN9p8wZtMLmmQB0QmA0rl2OCxnssYVuibJjJ6Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE6APr1Tjw8EyI7QjoMli1RLNAMPEhsdgM5/zdHBsIqD4BhJLoMC6x+Q01bKh/GKVaQbjl6Q8ujpQ05M1HRddA/Ao/mGE16F0t859znmLzlBM1Ecg4wRGmsLSJAq9B3SP4xZfTcgqyJvsxxsLMMSzXZGSCxto0VqT6lhdG52jC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ui-0006Aa-94
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ug-000hm1-0N
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BD2D041730E
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9040F4172DC;
	Thu, 22 May 2025 08:41:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id aa27a029;
	Thu, 22 May 2025 08:41:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/22] can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw_info
Date: Thu, 22 May 2025 10:36:37 +0200
Message-ID: <20250522084128.501049-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

The shift and w value in rcar_canfd_setrnc() are dictated by the
field width:
  - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
    of 16 bits,
  - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
    width of 8 bits.

Add rnc_field_width variable to struct rcar_canfd_hw_info to handle this
difference. The rnc_stride is 32 / rnc_field_width and the index parameter
w is calculated by ch / rnc_stride. The shift value in rcar_canfd_setrnc()
is computed by using (32 - (ch % rnc_stride + 1) * rnc_field_width).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-10-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fded4da50103..558291a36043 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -503,6 +503,7 @@
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	u8 rnc_field_width;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -579,18 +580,21 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.rnc_field_width = 8,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.rnc_field_width = 16,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.rnc_field_width = 8,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
@@ -676,9 +680,10 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 			      unsigned int num_rules)
 {
-	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
+	unsigned int rnc_stride = 32 / gpriv->info->rnc_field_width;
+	unsigned int shift = 32 - (ch % rnc_stride + 1) * gpriv->info->rnc_field_width;
+	unsigned int w = ch / rnc_stride;
 	u32 rnc = num_rules << shift;
-	unsigned int w = ch / 2;
 
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
 }
-- 
2.47.2



