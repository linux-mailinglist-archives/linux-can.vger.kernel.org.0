Return-Path: <linux-can+bounces-3179-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79746A6A23A
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 10:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7513A6D83
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5F214A97;
	Thu, 20 Mar 2025 09:12:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFB1A238C;
	Thu, 20 Mar 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461935; cv=none; b=nohwcKtD5eguopLr/wf8Hq//QgsFGUa86Y3JS6sXKQjwWnVVi3eMwp3yZjfNvOxsRPuG/YlgXeC/E0tSnlyVtwHG/SaQVFEwL51ALZl93yukp/bBs44zuScRiHqPSm3+UCC+XRl1lCYiHtNQW6Ln/oo07uJo8+P9ulg/ljGUgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461935; c=relaxed/simple;
	bh=vColSZ5WT5gEfrUrsFBb6QQq65WX6Nent8DQr7358gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol8xSmIC1zw+wh7/jsqGOraY/i1Z0/xZyecHUY82nVbxfrgO8iPNAi69jG3yVyhRXHb3LLOG9zLv7IQemoC1hMl8lZK8stFyP7FgJVAYdXn3aUK5carlyoV1wghSbhdabuXoAUVLp/Hz084z+Dod+Lis3HeGPAjdUbj/HV+ldUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: MvxBWiW0TR62Bn5l3fQnvw==
X-CSE-MsgGUID: HMP//zZ5SUu8on+zqgWhHQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2025 18:12:13 +0900
Received: from localhost.localdomain (unknown [10.226.93.24])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E30EB4005B59;
	Thu, 20 Mar 2025 18:12:10 +0900 (JST)
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
Subject: [PATCH v6 17/18] can: rcar_canfd: Enhance multi_channel_irqs handling
Date: Thu, 20 Mar 2025 09:10:48 +0000
Message-ID: <20250320091101.33637-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
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
v5->v6:
 * No change.
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
index 7ad27087a176..91f5649078c6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1851,16 +1851,19 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
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


