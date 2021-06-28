Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61C3B65FF
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhF1PrD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:47:03 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:25062 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbhF1Pqq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:46:46 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfjq2501T0zjR6y03fkJfx; Mon, 28 Jun 2021 17:44:19 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:44:19 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v4 3/4] iplink_can: print brp and dbrp bittiming variables
Date:   Tue, 29 Jun 2021 00:44:01 +0900
Message-Id: <20210628154402.1176099-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
References: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Report the value of the bit-rate prescaler (brp) for both the nominal
and the data bittiming.

Currently, only the constant brp values (brp_{min,max,inc}) are being
reported. Also, brp is the only member of struct can_bittiming not
being reported.

Although brp is not used as an input for bittiming calculation, it
makes sense to output it.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 9dbe6afd..00f585c6 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -347,6 +347,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "phase_seg2", "phase-seg2 %u ",
 			   bt->phase_seg2);
 		print_uint(PRINT_ANY, "sjw", " sjw %u", bt->sjw);
+		print_uint(PRINT_ANY, "brp", " brp %u", bt->brp);
 		close_json_object();
 	}
 
@@ -421,6 +422,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "phase_seg2", " dphase-seg2 %u",
 			   dbt->phase_seg2);
 		print_uint(PRINT_ANY, "sjw", " dsjw %u", dbt->sjw);
+		print_uint(PRINT_ANY, "brp", " dbrp %u", dbt->brp);
 		close_json_object();
 	}
 
-- 
2.31.1

