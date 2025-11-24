Return-Path: <linux-can+bounces-5631-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6EBC7FE38
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 11:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939A03A795F
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096A2FB60E;
	Mon, 24 Nov 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYAPVDiS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3122F99BD
	for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980128; cv=none; b=LY90hNE00tKZ+Fkr73yB2AAqFsDEdJaT5z7toU1mdmKUJfwa9XQ5fCAvoCjZjim8VbA2u6Uc0Zm6f7GhHgBvdoqm6xQYzYZrpkT0FpULEjJ0z4soKGCQLxI/amiQDVyNQDh5KpW3RJ4LBhlyB51rua63ASSYE5sCq5HbTzVYPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980128; c=relaxed/simple;
	bh=25AN4XiGc6CZ1SMIZ0IBj9ec9hPtrhDC/hZ+f8Nm1lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiCYg+8HcMV3Bo7MwDj4gX0426KaaE2bGWNOYCJZiSNey1alPhLlYi4eSDawl6DFNQ+oON9awc8hYRVEEjx+hP0kba/ntLaQgjjx8Etpj0RwkjB5ZiPWGzldlyObfDKB0l23WFEoItNvQz3EWlpqyXFPOQC9EFFOxoYV6tzPjXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYAPVDiS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so34726575e9.1
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763980123; x=1764584923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VPGo5U/iXGFhSlRJsPXDRX32fruUCYMsM5nvll/4Kw=;
        b=nYAPVDiSTAIK+quKuIvU/mHI4U3/TKAogrZ3Upc+SzJSgIrHZNg5s1Q42FA/tovaDQ
         bQvpzZeszYW/Qrky3+43PaMtBaW/TfTAezz5DtsuYTTP/s4ajrnhbVr4EAFcgCc4OTFN
         lanpazHKpRh+8+5zj1Vl4it2GnsAj0OARnyFBdDpteWMLkXIKkWvegZTpd68wbg/A6vI
         DAg8DDjzJXaoafwxPbRBxUD5ttBNN0s9xIcl+V+dzQjX4LiEcE6RTyOGmIduytqXF1/S
         zhNaNrGSYifFAyGKDceCR1HvtVRNDc94g9KCelyeAvNcd0MybM8UhTl86ylYHbvPOZrB
         Aoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980123; x=1764584923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5VPGo5U/iXGFhSlRJsPXDRX32fruUCYMsM5nvll/4Kw=;
        b=ZZiI0VIfugjQFUb+BpLA11z07KIbUj+8CdarZEjmxcVrL4Q45+bqw3xSS6UODO52aB
         chuHEpN5NUsQNkhvYOrjA00OcblVzMjuRXJZN1U5Ys9v0tLjasVwGvRLeSIp7zRjuXfB
         VVkeDUjPsefBz7V+1KjU4VjlVSVqOY5MoNKgYdJxL5+eKmH7Egkran5ExgczZiroF+Qg
         CMY1vW0RwCMy6fGkGu8Sjf6TF/R4S8kEZ0tLqcpZeGU+i1cDC6yWcoXs0utdin7Fgb3p
         5FpJfpKUZ27jIBPP9HvLH8ZQxvVGOqSBUHWseb/ybpxXVvDu/jVH0TuT1CvOkPK94iGR
         VnYw==
X-Forwarded-Encrypted: i=1; AJvYcCWb2oyxsdnXarxgz194M+LSPmLyp/ajas3ACti3XDO5zZ7xq3UadEfs+rq0hiLi3xCMjVpM2E+jkpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9pRoAvhcTUuukpz6W5Ip4u1lsvZvSUE4vc6IlejkKRY/4fAe
	Qnxvs1ZcCtxrelidjPMwwmBcwe/uezoCSBKLrz7XJZA41q5i/W+z801Q
X-Gm-Gg: ASbGncujVXxJ2CUhKGH6jg5uzNAEcLWNxmcIc/UUjqJL946dP/EddCb9iLoWxlUJT/F
	ZAise/25gFIabon3NxC6UTsqNZSrYs0eeiccKphiBO85vu6tKhC9preancClUKI863Gs5cce3dC
	8P0E1iYDTF6GVd5alIUYbhH6ekTeQ3XZEzUofqYDRTrXv+2NL0Sq+2wPT2s2WGU/D8xQd63PnqD
	hji/MEsKjCSZdjCkPcB7shIROaJ0jwZ8P6glRuhsC5OxDKraQTUhmmEygIgyY3MRqni5QcQhEaz
	tF7zmn7VygGTq6oNrCxWlhAL14ISUp4fZQLCggimJUikSgiOmdb31n33fYRu+O1QghdkRC0MYZD
	kRNPzBgfwnqKQEU4twFM4cLJ+fHBOOj0a8+wgWg46+Y30CPftnHO1xCo0qIY9atO5k56ldynav9
	pTqSZWOIP/XQAHIZXW8KGgS2o+bnWIaIywWlCjCuBetMujycgqsFfDTh4lVjzeFR35gvYNVzwQE
	5ZppTXBnE92So7V
X-Google-Smtp-Source: AGHT+IGPyNSAkUnNNLh90REio7RQidDo1QlxOrR1JlpAc2ox428h/ljqAzuZmEq2S0sQiaTFD1UHMA==
X-Received: by 2002:a05:600c:1c24:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-477c01be2b2mr148615015e9.16.1763980123429;
        Mon, 24 Nov 2025 02:28:43 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1df334sm186753945e9.3.2025.11.24.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:28:43 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 5/7] can: rcar_canfd: Invert CAN clock and close_candev() order
Date: Mon, 24 Nov 2025 10:28:30 +0000
Message-ID: <20251124102837.106973-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124102837.106973-1-biju.das.jz@bp.renesas.com>
References: <20251124102837.106973-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

The CAN clock is enabled before calling open_candev(), and disabled
before calling close_candev().  Invert the order of the latter, to
restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tag
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index d77d28d0ca6b..2f9fc0da2d1b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1588,8 +1588,8 @@ static int rcar_canfd_close(struct net_device *ndev)
 	netif_stop_queue(ndev);
 	rcar_canfd_stop(ndev);
 	napi_disable(&priv->napi);
-	clk_disable_unprepare(gpriv->can_clk);
 	close_candev(ndev);
+	clk_disable_unprepare(gpriv->can_clk);
 	phy_power_off(priv->transceiver);
 	return 0;
 }
-- 
2.43.0


