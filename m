Return-Path: <linux-can+bounces-7898-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sU59Bp0yPWpfywgAu9opvQ
	(envelope-from <linux-can+bounces-7898-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 15:52:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9996C644F
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 15:52:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ue36AlMF;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7898-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7898-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BA7430166C5
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EEE2571B8;
	Thu, 25 Jun 2026 13:52:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5E31C56D
	for <linux-can@vger.kernel.org>; Thu, 25 Jun 2026 13:52:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395543; cv=none; b=LfI8+IQMYTBQzApSJwSAT2u1/jCi6ed1NFv5aDERhs9Ieugh0Ro1Jh3MWo+MPCBETLSYNYOM6lSG4I440JWBTCeIX2mUCAOaqm8W3uVudS/qshAmR+mHCnnhEvp76QLGfCpEh868vRgZ8NZh7+eQ0qw+gc8KTFrSXnKigEufKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395543; c=relaxed/simple;
	bh=n6yh2+/rWeQQNi4qwoTckvozslY49WtUu670X1OjJOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsI6Q3+5FRuxMu6oUlWPatl0aSIYxjtHhwz1gxslo3VFonX65uv68PMtYskFNPNoDto45rsrsJHnJiwjOMjE1z0/XYPgRdKAEe36RkGJd5hXsMmq/dglkMPG0kKruxx6+ac4Gss86k7zCHy4SA+VVYyOs5AW+az5jUIndOFNEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue36AlMF; arc=none smtp.client-ip=209.85.218.53
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c07c67ad9f2so239107666b.0
        for <linux-can@vger.kernel.org>; Thu, 25 Jun 2026 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782395540; x=1783000340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0QUpR3Lk1Tb8lP5JkSe8nEXPKpbfyPrEqlp9QtaxbSk=;
        b=Ue36AlMFZEzIIeBkYm0VFaRBIriBsCb/t/GvSJf8upf8bQw4SkZvboWYhw8+2lqPfg
         1T/XUKrMsBO43MzjPInUM201Z7z9cJRcbOeki5BbVPC0LdIBl4k943pJAlzsRXp+MoMO
         37rO5uA+xopeq+rhQOa/JDoHIFskab6753Zs6KHQnk+pgWAOqpBnj7stvhRloIyV8Jd9
         /uJPgEAwZilYRUYHP8cXHwojCciu9EjW5l135zB4NZImly4pGwm59unBy5K+veZqPc/6
         1f1H2IDaX/JQwjGrKYJYfxVeN6aNUjFgTCViwKW/GrZCJHGhAVGnV7PJukVYncG4aCUd
         /DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395540; x=1783000340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QUpR3Lk1Tb8lP5JkSe8nEXPKpbfyPrEqlp9QtaxbSk=;
        b=sXts6yB1+9Dc2939cAroJS6wckGmKJe/slB9efKlX3W3lcx+k6SDfVTFWM/wT+NjDE
         OGKdOKskPrayAiJcQ7F7ibaBn6t5fdlQl828fejNxJMtJ/ptr91ZOEXMdkFrApt71U3T
         8soypLxC7r+DT3nw/h7bNY5R/x2ILRx5MqxczJLoo2huw+eh+ePA4BU1EZP8kHd+ZG0H
         8mkPcZA9CIfvPQgXwLhe0jCyLYE5RDyV5n4RoEaworsmrTsCH3lUSByAq2U+U3pHr6KJ
         WgTn+YsEaTOHRLsU87Ys4ew5rgBTBP7uS+qog5UNEdkcLxl7gX5pWZv1wynLTEf8F3tX
         8KnA==
X-Forwarded-Encrypted: i=1; AHgh+RrKdUhvEAlLAlTm78SodeNUSCmJeUAtWz9JRDx/PsEla252I4XAEgLMFdE+G6CPCd+Qu95pqiL3m+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOjkv1ODwNYahLsGDQEcTLDhCcgRKusrh16zHHt/vlpMDd7dV
	DmRQjWVgizSJuE770yFpyF7gSBdjhNtbFOq9qD+K4m+7p9n6Hup96RI9
X-Gm-Gg: AfdE7cmsqfoWZNlUcpvsMZZXQs8IYPVotbn604XZWwW2wcHS4ndSGZgDH4UQpKg4Ncu
	Pns7WvC5xPoVQGRsbWdLUmsj1Yr8vrYGA4iDf3IPoWtnxhVhkVv0gC+S96vFaa1zQ8ecSGl029x
	lprDF2tsljwcoO7/QKi2fFEKS1Jt6xkRKaRRo/ogMXjjDQl4hpmGyXXzKMzeMfpyHuCfV3hayV2
	lpmwzcUdpaJYPmVohU2omd+xKe+pmJkQaff1bsB2OMPlCe1aOOPJuRm0exeAtZ4RP+mIxwvbAgH
	+YQb8fSt9oGrDcJkj7et0MjPQP7zx9co2O8jEyJiogObUonxkjpjBWWJALZO56mG2wWsGA5U/MO
	f53QRGjv9rjGorc+VaaN6HLADraRK3XPIDkW26vLME6BbTObsDY9P2HtSfn1U4CkUfYowsyQ96o
	OVX0bxE4ktTnbP+NrG5zYsLDtolq1uvS6H+WRr
X-Received: by 2002:a17:906:5a56:b0:bd4:f3bc:c4b3 with SMTP id a640c23a62f3a-c10309ba16emr556111166b.18.1782395540038;
        Thu, 25 Jun 2026 06:52:20 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:6aa7:b2d:3460:b689])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12024deb90sm171139166b.18.2026.06.25.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:52:19 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tu Nguyen <tu.nguyen.xg@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] can: rcar_canfd: Change the initializing flow for clocks and resets
Date: Thu, 25 Jun 2026 14:51:51 +0100
Message-ID: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7898-lists,linux-can=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:p.zabel@pengutronix.de,m:tu.nguyen.xg@renesas.com,m:biju.das.jz@bp.renesas.com,m:duy.nguyen.rh@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:biju.das.au@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com];
	FREEMAIL_CC(0.00)[renesas.com,bp.renesas.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F9996C644F

From: Tu Nguyen <tu.nguyen.xg@renesas.com>

Testing CANFD on RZ/G3E shows that many registers do not reset to their
initial values with the current flow of deasserting resets first and then
enabling clocks.

Based on the HW manual, clocks should be supplied first and the
resets deasserted afterward.

 section 7.4.3 Procedure for Activating Modules: RZ/G2L
 section 4.4.9.3 Procedure for Starting up Units: RZ/G3E

So, update the order of the initializing flow for resets and clocks
to match the hardware manual, resetting all CANFD registers to their
initial values. Also update rcar_canfd_global_deinit() to assert
resets before disabling clocks, so the teardown path mirrors the new
init ordering.

Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
Signed-off-by: Tu Nguyen <tu.nguyen.xg@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index eaf8cac78038..fcc37b73ed43 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2003,20 +2003,12 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	u32 ch, sts;
 	int err;
 
-	err = reset_control_reset(gpriv->rstc1);
-	if (err)
-		return err;
-
-	err = reset_control_reset(gpriv->rstc2);
-	if (err)
-		goto fail_reset1;
-
 	/* Enable peripheral clock for register access */
 	err = clk_prepare_enable(gpriv->clkp);
 	if (err) {
 		dev_err(dev, "failed to enable peripheral clock: %pe\n",
 			ERR_PTR(err));
-		goto fail_reset2;
+		return err;
 	}
 
 	/* Enable RAM clock */
@@ -2027,10 +2019,18 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 		goto fail_clk;
 	}
 
+	err = reset_control_reset(gpriv->rstc1);
+	if (err)
+		goto fail_ram_clk;
+
+	err = reset_control_reset(gpriv->rstc2);
+	if (err)
+		goto fail_reset1;
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_ram_clk;
+		goto fail_reset2;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2068,14 +2068,14 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
-fail_ram_clk:
-	clk_disable_unprepare(gpriv->clk_ram);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
 fail_reset2:
 	reset_control_assert(gpriv->rstc2);
 fail_reset1:
 	reset_control_assert(gpriv->rstc1);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
+fail_clk:
+	clk_disable_unprepare(gpriv->clkp);
 	return err;
 }
 
@@ -2090,10 +2090,10 @@ static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
 		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	}
 
-	clk_disable_unprepare(gpriv->clk_ram);
-	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
+	clk_disable_unprepare(gpriv->clk_ram);
+	clk_disable_unprepare(gpriv->clkp);
 }
 
 static int rcar_canfd_probe(struct platform_device *pdev)
-- 
2.43.0


