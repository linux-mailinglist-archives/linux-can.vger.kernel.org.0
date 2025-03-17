Return-Path: <linux-can+bounces-3134-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70982A64F27
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA09189019D
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0323BCE9;
	Mon, 17 Mar 2025 12:37:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD323A98E;
	Mon, 17 Mar 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215045; cv=none; b=PsexyhZkBb+A91M0k1omaZONnbrTiXgpwo5C/tne2N/pXRcGwff8dqntJnXbqqxbvG8UCGWMUK34kpaFiR5OxYQqjNfPVK+kGUNXBp5LetMDTp0sNB8fgUYO3xzkVpynKyPkQ7lpKQ+R4B22rWCxsUoxPJjhAaZ02s1NsbX1E4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215045; c=relaxed/simple;
	bh=LVRxuIyu+dv1FnfmthV06drIi+xwjJ2rc9eeJsO8jCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyklw7gjZ9nsDDiVddRrk9WDqn5x6DsI12phhi0oNck9SIfjM8rkQnOlpZ0DaXvzAnoYphm29O5CudzjtsZeHSR/+Hn6qX94RNnQng8zhRKEQ3YZmGXyBaamI4A1sjYDp+nl+2tCcZUzraMD6ItAgZ8qxRlUvi7XHKMMs2xY9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: kx4GOmfDSwKmCGsxSSNXcw==
X-CSE-MsgGUID: uBmNQ2gKT/iAYTCaFExfyA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2025 21:37:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C496C400618A;
	Mon, 17 Mar 2025 21:37:20 +0900 (JST)
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
Subject: [PATCH v5 15/16] can: rcar_canfd: Enhance multi_channel_irqs handling
Date: Mon, 17 Mar 2025 12:36:09 +0000
Message-ID: <20250317123619.70988-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Collected tag.
v3->v4:
 * No change.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 5b07e3724fff..166c8377f67b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1846,16 +1846,19 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
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


