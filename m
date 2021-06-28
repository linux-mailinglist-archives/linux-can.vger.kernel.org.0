Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5F3B65FD
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhF1Pq7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:46:59 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:28761 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbhF1Pqe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:46:34 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfjq2501T0zjR6y03fk6eD; Mon, 28 Jun 2021 17:44:08 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:44:08 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v4 1/4] iplink_can: fix configuration ranges in print_usage()
Date:   Tue, 29 Jun 2021 00:43:59 +0900
Message-Id: <20210628154402.1176099-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
References: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The configuration ranges in print_usage() are taken from "Table 8 -
Time segments' minimum configuration ranges" in section 11.3.1.2
"Configuration of the bit time parameters" of ISO 11898-1.

The standard clearly specifies that "implementations may allow time
segments that exceed the minimum required configuration ranges
specified in Table 8".

Because no maximum ranges are given, all given ranges { a..b } are
simply replaced with { NUMBER }.

The actual ranges are specific to earch device and should be confirmed
doing:

$ ip --details link show can0
1: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0
    can state STOPPED restart-ms 0
	  ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
	  ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-inc 1
	  clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 6a26f3ff..2736f3ab 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -44,13 +44,13 @@ static void print_usage(FILE *f)
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
 		"\n"
-		"\tWhere: BITRATE	:= { 1..1000000 }\n"
+		"\tWhere: BITRATE	:= { NUMBER }\n"
 		"\t	  SAMPLE-POINT	:= { 0.000..0.999 }\n"
 		"\t	  TQ		:= { NUMBER }\n"
-		"\t	  PROP-SEG	:= { 1..8 }\n"
-		"\t	  PHASE-SEG1	:= { 1..8 }\n"
-		"\t	  PHASE-SEG2	:= { 1..8 }\n"
-		"\t	  SJW		:= { 1..4 }\n"
+		"\t	  PROP-SEG	:= { NUMBER }\n"
+		"\t	  PHASE-SEG1	:= { NUMBER }\n"
+		"\t	  PHASE-SEG2	:= { NUMBER }\n"
+		"\t	  SJW		:= { NUMBER }\n"
 		"\t	  RESTART-MS	:= { 0 | NUMBER }\n"
 		);
 }
-- 
2.31.1

