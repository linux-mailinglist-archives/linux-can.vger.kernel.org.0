Return-Path: <linux-can+bounces-8448-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f4hDKjpzVmo85wAAu9opvQ
	(envelope-from <linux-can+bounces-8448-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:34:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351A7577F7
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:34:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8448-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8448-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 646C13044E5C
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0694657D0;
	Tue, 14 Jul 2026 17:33:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2230214B;
	Tue, 14 Jul 2026 17:33:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050432; cv=none; b=Fw5Skaj6CA/dM3p9VykygiJeOOWxYL5SUF4fflcZFJC1702vSGBfuCpFiwUjRy7Axwu/mbX5qMuj9V/dsnMuv6ISd8RS6EdtIkPtC3tidxEk2X8TkdSQw8VXSMoKsw3JnJr/fY6RRdfRXaRS8vUbLosfY/wUyU0rKXvUzRa7OhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050432; c=relaxed/simple;
	bh=cyreKOa5S4fRT0pSZLRECO69cQw7bxhM+Z2w0N+B8jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxBIgJ6SzU8zT368apbSB7m2MO7OulOmDXXddFAGSgZR+PYb1/DSSYevtskjAe8kSwuu03EgLL2vVezp+oYeCVJYI8/2mlIQC2WRMJVD3CR1SJLMJbec49VQf3r/QKhqr6viTwtBRP5SJCIZQoCbQB9MNBWnOToMEAJh7eBFpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5416E1F00A3A;
	Tue, 14 Jul 2026 17:33:47 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 5/8] can: rcar_canfd: Do not set registers selecting the CAN mode
Date: Tue, 14 Jul 2026 20:33:12 +0300
Message-ID: <20260714173315.1981708-6-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8448-lists,linux-can=lfdr.de,renesas];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,vger.kernel.org:server fail,renesas.com:server fail,tuxon.dev:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,baylibre.com,redhat.com,bp.renesas.com,renesas.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tuxon.dev:from_mime,tuxon.dev:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5351A7577F7

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The bits 30 (classical CAN-only mode) and 28 (FD-only enable) of the
Channel n CAN-FD Configuration Register of the Renesas RZ/G3S SoC are not
available. The IP supports only CAN-FD mode. RZ/G3S HW manual (revision
1.30) specify the bits are read as zero and the write value should always
be zero.

Add the mode_select_na flag in struct rcar_canfd_hw_info to cover RZ/G3S
and avoid writing to unavailable bits.

The existing struct rcar_canfd_hw_info instances were updated to address
the request in the Link discussion.

Commit prepares for the addition of the Renesas RZ/G3S SoC.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- collected the tags
- updated patch description to reflect this is a preparatory commit

 drivers/net/can/rcar/rcar_canfd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7fa9cbbf8dde..8ba8905c965a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -445,6 +445,7 @@ struct rcar_canfd_hw_info {
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
 	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
+	unsigned mode_select_na:1;	/* Has no bits for selecting the mode. */
 };
 
 /* Channel priv data */
@@ -619,6 +620,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.shared_can_regs = 0,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -637,6 +639,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -655,6 +658,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.shared_can_regs = 0,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -673,6 +677,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 0,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
@@ -691,6 +696,7 @@ static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
 	.shared_can_regs = 1,
 	.external_clk = 1,
 	.fcan_pclk = 0,
+	.mode_select_na = 0,
 };
 
 /* Helper functions */
@@ -846,6 +852,9 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 		}
 
 		/* Set the controller into appropriate mode */
+		if (gpriv->info->mode_select_na)
+			continue;
+
 		if (gpriv->info->ch_interface_mode) {
 			/* Do not set CLOE and FDOE simultaneously */
 			if (!gpriv->fdmode) {
-- 
2.43.0


