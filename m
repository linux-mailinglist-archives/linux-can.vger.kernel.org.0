Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1522A4BF9
	for <lists+linux-can@lfdr.de>; Tue,  3 Nov 2020 17:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgKCQvz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Nov 2020 11:51:55 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:49662 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCQvz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 11:51:55 -0500
Received: from tomoyo.flets-east.jp ([153.230.197.127])
        by mwinf5d58 with ME
        id nsrh230062lQRaH03srqTB; Tue, 03 Nov 2020 17:51:52 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 03 Nov 2020 17:51:52 +0100
X-ME-IP: 153.230.197.127
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] cangen: allow DLC > 8 in increment generation mode if -8 option is given
Date:   Wed,  4 Nov 2020 01:51:30 +0900
Message-Id: <20201103165130.1907-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Currently, the -8 option allows DLCs greater than 8 in mix mode only.

Add the option to also generate such DLCs in increment
mode. e.g.: 'cangen -8 -Li can0'

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 cangen.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/cangen.c b/cangen.c
index 5c86f26..06a1931 100644
--- a/cangen.c
+++ b/cangen.c
@@ -171,7 +171,7 @@ int main(int argc, char **argv)
 	struct pollfd fds;
 
 	struct sockaddr_can addr;
-	static struct canfd_frame frame;
+	static struct canfd_frame frame = { 0 };
 	struct can_frame *ccf = (struct can_frame *)&frame;
 	int nbytes;
 	int i;
@@ -386,7 +386,6 @@ int main(int argc, char **argv)
 
 	while (running) {
 		frame.flags = 0;
-		ccf->len8_dlc = 0;
 
 		if (count && (--count == 0))
 			running = 0;
@@ -428,7 +427,8 @@ int main(int argc, char **argv)
 						ccf->len8_dlc = frame.len;
 
 					frame.len = 8; /* for about 50% of the frames */
-				}
+				} else
+					ccf->len8_dlc = 0;
 			}
 		}
 
@@ -507,12 +507,20 @@ resend:
 		if (dlc_mode == MODE_INCREMENT) {
 
 			incdlc++;
+			incdlc %= CAN_MAX_RAW_DLC + 1;
 
-			if (canfd && !mix) {
-				incdlc &= 0xF;
+			if (canfd && !mix)
 				frame.len = can_dlc2len(incdlc);
+			else if (len8_dlc) {
+				if (incdlc > CAN_MAX_DLEN) {
+					frame.len = CAN_MAX_DLEN;
+					ccf->len8_dlc = incdlc;
+				} else {
+					frame.len = incdlc;
+					ccf->len8_dlc = 0;
+				}
 			} else {
-				incdlc %= 9;
+				incdlc %= CAN_MAX_DLEN + 1;
 				frame.len = incdlc;
 			}
 		}
-- 
2.26.2

