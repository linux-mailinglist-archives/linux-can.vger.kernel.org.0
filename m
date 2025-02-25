Return-Path: <linux-can+bounces-2962-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1903BA444BA
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1463919C2D19
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167015383D;
	Tue, 25 Feb 2025 15:41:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342EF140E3C;
	Tue, 25 Feb 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498105; cv=none; b=TcuwPT8fC5XdQ8MqDo67afw26h8WtHG4ktz8sscLUSfFCsuCrmGfg8KS5sSlnQDt6I5X94C21UDuHcPRWjpSxdn0AvnK8ynSUWB9/9GBCLE7hnBxY5y+vLiAKCgj40fbi00gSnut5DjInreTn64G6DYymdtOWthlYaaQgAMq0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498105; c=relaxed/simple;
	bh=eU4vZqTQg2tRPSp213j9RytWa9qzgT1JRfh4TZMEgS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3Ei75zh/FcL90m8cRlmUYIsHM/mhVw8DxPUryk5o4LtbFWGXIBXpd5ntiHSnotwJWl+FGfOwSWPea3xWsHWoP7YuWUzNHRtRAKLECpoKETnhHagsiQC4U4XpdS6NZ5uJsMnp7XciGVSEtJybZJqrO4WscRmZ7+qACdqTXz6d8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: s7s+JxVxQleySeVb8OU8wQ==
X-CSE-MsgGUID: edcMaNuwS/6ahjVCloCGEA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2025 00:41:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 06DFD400FC34;
	Wed, 26 Feb 2025 00:41:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-can@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 10/11] can: rcar_canfd: Enhance multi_channel_irqs handling
Date: Tue, 25 Feb 2025 15:40:49 +0000
Message-ID: <20250225154058.59116-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently multi_channel_irqs has only 2 channels. But RZ/G3E has six
channels. Enhance multi_channel_irqs handling to support more than two
channels.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7ae06e3c4d85..48fead44556c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1860,16 +1860,19 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	if (info->multi_channel_irqs) {
 		char *irq_name;
+		char name[10];
 		int err_irq;
 		int tx_irq;
 
-		err_irq = platform_get_irq_byname(pdev, ch == 0 ? "ch0_err" : "ch1_err");
+		scnprintf(name, 10, "ch%u_err", ch);
+		err_irq = platform_get_irq_byname(pdev, name);
 		if (err_irq < 0) {
 			err = err_irq;
 			goto fail;
 		}
 
-		tx_irq = platform_get_irq_byname(pdev, ch == 0 ? "ch0_trx" : "ch1_trx");
+		scnprintf(name, 10, "ch%u_trx", ch);
+		tx_irq = platform_get_irq_byname(pdev, name);
 		if (tx_irq < 0) {
 			err = tx_irq;
 			goto fail;
-- 
2.43.0


