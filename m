Return-Path: <linux-can+bounces-2833-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D194A399AA
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FE23AB853
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2084239083;
	Tue, 18 Feb 2025 10:50:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DD13D51E;
	Tue, 18 Feb 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875849; cv=none; b=pZyH3Fgc9Ixvx5fZnLYPsLf2dfkJmU7MtIg58KlDoLRSa61W42soYYs2gr2TkLyu8CKu25qKP0uwJAqFzKfUITToG4pRI8q0D6EYwoR9Vm4oVWQBH8xtSZ+iI1iFKbGrUDunKz4RM8HdABBBMhdUqpfLlSQN98TGIiKQ2KMcr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875849; c=relaxed/simple;
	bh=tuxrSiINKHJxqxnuqzHxiWQPSXS8HfXB1Hz8KBozSx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVBPw/8wQRTBBwWbMICxS/05sAU4rAmZWcl45cRPY9j0N7Oo7fG7uOAv1jh5fQshRdpR48VX0JLsaOcAh8k+2ucKS7ePCs9orG8buAV8B9CguPhFe7tVpk/T+qcssuCv+PAT/2PO7uS7aKmBBOPeOD6IBFn2GeftOIDlk/0pv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: WkgEsz/hRUGFnnDn3YXJ5w==
X-CSE-MsgGUID: aiP7UtORSqWObKQVl9tLfg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Feb 2025 19:50:48 +0900
Received: from localhost.localdomain (unknown [10.226.92.208])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F3EEA42A5EA4;
	Tue, 18 Feb 2025 19:50:44 +0900 (JST)
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
Subject: [PATCH 08/11] can: rcar_canfd: Enhance multi_channel_irqs handling
Date: Tue, 18 Feb 2025 10:49:58 +0000
Message-ID: <20250218105007.66358-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
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
 drivers/net/can/rcar/rcar_canfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index d19044f07cb9..d6d7ba3e9ca1 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1748,16 +1748,19 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
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


