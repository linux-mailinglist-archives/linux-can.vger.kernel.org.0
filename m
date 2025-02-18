Return-Path: <linux-can+bounces-2831-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C69A39991
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772EC188A4C7
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E39023770D;
	Tue, 18 Feb 2025 10:50:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A123717F;
	Tue, 18 Feb 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875843; cv=none; b=cpPzbrBt08qPnmuNdCzxdYWWZdI+4aFeW21m3ukOLQ3RiTEcRjkFMLb6+CyEdJP6EKtLt6Fv/cXNAYkpL4AxPICHU3zMPM7tHyPoPYY981kIoEyduWj/hEcOu4GvRSeKJbOEuGiEBu/XBQ0hBN3eUY1bJ9/eAfVPjNmKqIHIbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875843; c=relaxed/simple;
	bh=8bqXeGQg5cQmQAUWBxx8DmWhp4cCShpAbZPvu1+iNl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5pTeX9/8148Ak0q3MRzCmGthHIAk95V179m+TTJEOH3W0TVpI4nxEn5O1Di63W9NS9O6L/KGK0Hag3t+oKu15P1KbYemoLOiyID4HaPqHv+CzOQ+cculrDtb6zRA5Xgp5da6uidYrXbWaSXX9Ni32aR+Vuv4WmcAi22hbSQEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: t7CFKSMMTHOB0HKeTCHkDQ==
X-CSE-MsgGUID: 8Y7iFDp3Ra6sVWggPn1PHw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Feb 2025 19:50:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.208])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E35BA42A47AC;
	Tue, 18 Feb 2025 19:50:37 +0900 (JST)
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
Subject: [PATCH 06/11] can: rcar_canfd: Add gen4_type variable to struct rcar_canfd_hw_info
Date: Tue, 18 Feb 2025 10:49:56 +0000
Message-ID: <20250218105007.66358-7-biju.das.jz@bp.renesas.com>
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

Both R-Car Gen4 and RZ/G3E SoCs have similar register layout. Introduce
gen4_type variable to struct rcar_canfd_hw_info for the preparation of
adding RZ/G3E driver support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 270f50d836f5..c49cb25da94f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -516,6 +516,7 @@ struct rcar_canfd_hw_info {
 	/* hardware features */
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
+	unsigned gen4_type:1;		/* Has gen4 type reg layout */
 };
 
 /* Channel priv data */
@@ -596,6 +597,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
+	.gen4_type = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -607,7 +609,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 /* Helper functions */
 static inline bool is_gen4(struct rcar_canfd_global *gpriv)
 {
-	return gpriv->info == &rcar_gen4_hw_info;
+	return gpriv->info->gen4_type;
 }
 
 static inline u32 reg_gen4(struct rcar_canfd_global *gpriv,
-- 
2.43.0


