Return-Path: <linux-can+bounces-7920-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lb//BF7KQ2o9iAoAu9opvQ
	(envelope-from <linux-can+bounces-7920-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 15:53:34 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B8F6E515B
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 15:53:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ARi0YgVd;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7920-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7920-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 778A130D4C28
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DBA3655CF;
	Tue, 30 Jun 2026 13:51:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95EE419303
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 13:51:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827489; cv=none; b=BJxxCsK6GZqvUlzLQU8jFbSGiYS97qD46gZ94lC4PiW+zX2J3mu2ota6m4velhUm5ckc0dp1NVkYghKTb7JDf3ZxAi/ImhaGkHh4po8PQhEUy0CDfcAkue8VF68+z7lL71sWMjRBcjSqFH4o189FAtQm6/GuOXqssDcxAQdbEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827489; c=relaxed/simple;
	bh=N+KcMg3YdW3ZGEXV2ewZVcvhA1hOWZZyP9K83y3H7iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rfe6RrXUzR7+rYCagzH5wi+E0mnqigFe3XUOtODVVTUlGo/g4IhYeU//G+hU/7Xh2N4yc8+Y9Iyuh+VSYW779UlHANU3aF1ME2C0u5BBX4LvvHizdNDzYsmKtL6YoD/kICQcIZMrr4F7HaYcih/lmYZoonp9mARfFZsys2KbU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARi0YgVd; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-473dc4cf238so1374818f8f.3
        for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782827486; x=1783432286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWvTJIR6MW/9Fk0B89sOeEZGZXWK7HW1VK3cCDHNi6Y=;
        b=ARi0YgVdWvXZVy5FnRbpjSXlkhj954J4nCIiPgGl5bHeQ3vqYc6eYRLP4WRMBdShZv
         G/2U8e5yQPN9zzjexD9Shvq51mOKQIKphXWvY9baELy7cPEAt1sWNp/cM7xQ2P6RO87h
         7/UM4V+qUvkzeqPRib3qaPNC8HkGioab7CpA4ftYfKpu93z08QBhIg8Jeg6wt0gCVsD7
         Iwte2xBbOl2IOa5bYr6ziLe0PzGZMDGZDywVIXQTLxBCT446VGTIAZ4Rr+5dXlmsSTCH
         SeDFrKH3It/OtF9AiP/RS6/aVbTkW7W3j8TaMoY+0hvuch+UsedIFVzfFh2qQnGrYoIk
         PXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827486; x=1783432286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWvTJIR6MW/9Fk0B89sOeEZGZXWK7HW1VK3cCDHNi6Y=;
        b=B0ILkMA0b9IhwBAOP+yp+8IjzWlCUWChyO/q4qQiZlW+oe7jU8oNUDFF3wgYdd0+P0
         NkmuRKz8jBQQCGSsYWBF+gZvYRZG5kUUWgfKYjiolpfQZTlEbkdCL3JoLIMVXO9FVAnU
         eF2/KoEgpuV92TYWyUajgb8cL4MUs433RecmpfQmVlKvzaN721tKD/pSXzGpYmDnxzdD
         me3qen5zVrQCaGvQ+bSrzD2y44pOaIFZeN4JGEI34TDbDDdTMm40BdFnjb0ZlnZt7QKu
         Z4kvkreCQNX5hze66qdXjUVFfEcx6GmzvrX6Xs46ckbNtBbBoENVIbUXHJeg2r8CNK6n
         zZwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiEn/LcCfVItY1OjIFiRg24pV5jVonNkznweebG/4SkEfdY/5TNyCxBZjYHmYVB1N8xex6yepo6uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4C5b7e9mz0vUbW4B6iqacnjX+XVx19Rr2mL94x635Mqcvp1s
	4YsqZRl2mzcdQOKcMuS3Dg0YQaWZ50JV2RliQ+mHIIUKWUjledccf0IZ
X-Gm-Gg: AfdE7ckrEGp0JQy/+KigIoNMgOWv5BlipBURlS2ETtwjFVQ2dASqmn3kNiowDph6QSG
	TkmZOhFpW3D32Z7KryPT4MoD/el7CFUoE1MDy0cJrH+vZI4uP4+5BMLsIxhqqGZ6Fdy3bdJjvC4
	m4t9bQpLnKEB4VP2HTvRa5sIG3ZrcvgyCWJMfJYfPDGzTlR/ckN8sUfTk5ekKaJfG/jcHWTlzA2
	oofeM9XeMinIPj5Z67rnFq5RpVBIJopFxhzTDtB1IlU1QHjZVzbV21HlmugfrpT8k/3JBxNyjgg
	O2me/B8cw4WZXymfR5c52DIDvWRAOvUwH1mWoLGIK8464SOhitdUNJIGRIuFLdSmaPH6qC+Fn8b
	pIRjl+/5dsrBlsEHcmrO8+Z+UgFF6fzKraP6RAYGM/Fuo88mDE8SA7EC5xUWJ+yDY8IqPAAAXba
	MEi8O00s0XqFsXhQ/zjDjn0U8jbosOLQClp6v9Z72cYJqGsqGr
X-Received: by 2002:a05:6000:2304:b0:46d:8695:f49d with SMTP id ffacd0b85a97d-47552789722mr5212640f8f.34.1782827485983;
        Tue, 30 Jun 2026 06:51:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm7216964f8f.19.2026.06.30.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:51:25 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>,
	Rob Herring <robh@kernel.org>,
	Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 3/3] can: rcar_canfd: Fix interrupt registration order
Date: Tue, 30 Jun 2026 14:51:16 +0100
Message-ID: <20260630135119.104774-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630135119.104774-1-biju.das.jz@bp.renesas.com>
References: <20260630135119.104774-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7920-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:wsa+renesas@sang-engineering.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:biju.das.jz@bp.renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:tu.nguyen.xg@renesas.com,m:robh@kernel.org,m:ulrich.hecht+renesas@gmail.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:biju.das.au@gmail.com,m:wsa@sang-engineering.com,m:geert@glider.be,m:magnusdamm@gmail.com,m:ulrichhecht@gmail.com,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-can@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,sang-engineering.com,glider.be,gmail.com];
	FREEMAIL_CC(0.00)[bp.renesas.com,renesas.com,kernel.org,gmail.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4B8F6E515B

From: Biju Das <biju.das.jz@bp.renesas.com>

In rcar_canfd_probe(), global interrupts are requested via
devm_request_irq() before rcar_canfd_global_init() enables the clocks
and before the per-channel structures in gpriv->ch[] are allocated.

If the interrupt is shared and fires immediately, the handler
rcar_canfd_global_err_interrupt() will invoke
rcar_canfd_handle_global_err(), leading to a NULL pointer
dereference.

Move the rcar_canfd_global_init() and per-channel probe calls ahead
of the devm_request_irq() calls so that clocks are enabled and
gpriv->ch[] is fully populated before any global interrupt can be
delivered. The IRQ failure paths now jump to fail_channel instead of
fail_dev, since channels are allocated earlier and must be torn down
on this path too.

Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e88554388553..4ee108abffb8 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2216,6 +2216,17 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->base = addr;
 	gpriv->fcbase = addr + gpriv->info->regs->coffset;
 
+	err = rcar_canfd_global_init(gpriv);
+	if (err)
+		goto fail_dev;
+
+	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
+		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
+					       transceivers[ch]);
+		if (err)
+			goto fail_channel;
+	}
+
 	/* Request IRQ that's common for both channels */
 	if (info->shared_global_irqs) {
 		err = devm_request_irq(dev, ch_irq,
@@ -2224,7 +2235,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(dev, "devm_request_irq %d failed: %pe\n",
 				ch_irq, ERR_PTR(err));
-			goto fail_dev;
+			goto fail_channel;
 		}
 
 		err = devm_request_irq(dev, g_irq, rcar_canfd_global_interrupt,
@@ -2232,7 +2243,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(dev, "devm_request_irq %d failed: %pe\n",
 				g_irq, ERR_PTR(err));
-			goto fail_dev;
+			goto fail_channel;
 		}
 	} else {
 		err = devm_request_irq(dev, g_recc_irq,
@@ -2242,7 +2253,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(dev, "devm_request_irq %d failed: %pe\n",
 				g_recc_irq, ERR_PTR(err));
-			goto fail_dev;
+			goto fail_channel;
 		}
 
 		err = devm_request_irq(dev, g_err_irq,
@@ -2251,19 +2262,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(dev, "devm_request_irq %d failed: %pe\n",
 				g_err_irq, ERR_PTR(err));
-			goto fail_dev;
-		}
-	}
-
-	err = rcar_canfd_global_init(gpriv);
-	if (err)
-		goto fail_dev;
-
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
-		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
-					       transceivers[ch]);
-		if (err)
 			goto fail_channel;
+		}
 	}
 
 	platform_set_drvdata(pdev, gpriv);
-- 
2.43.0


