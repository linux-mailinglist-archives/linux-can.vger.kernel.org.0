Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A83B2567
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 05:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFXDXi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Jun 2021 23:23:38 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:39332 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFXDXe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Jun 2021 23:23:34 -0400
X-ASG-Debug-ID: 1624504873-15c4355b136e3020001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.164.dyn.edpnet.net [94.105.105.164]) by relay-b03.edpnet.be with ESMTP id KJbxXPVaSaKQreCx for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 05:21:13 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Apparent-Source-IP: 94.105.105.164
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id CD3771503ADE;
        Thu, 24 Jun 2021 05:21:13 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 1/2] canbusload: count full payload for CANFD frames
Date:   Thu, 24 Jun 2021 05:21:10 +0200
X-ASG-Orig-Subj: [PATCH 1/2] canbusload: count full payload for CANFD frames
Message-Id: <20210624032111.26272-1-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Start-Time: 1624504873
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1318
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.90858
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 canbusload.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/canbusload.c b/canbusload.c
index d6bfd78..bd74cb5 100644
--- a/canbusload.c
+++ b/canbusload.c
@@ -237,7 +237,7 @@ int main(int argc, char **argv)
 	int opt;
 	char *ptr, *nptr;
 	struct sockaddr_can addr;
-	struct can_frame frame;
+	struct canfd_frame frame;
 	int nbytes, i;
 	struct ifreq ifr;
 	sigset_t sigmask, savesigmask;
@@ -351,6 +351,9 @@ int main(int argc, char **argv)
 #ifdef DEBUG
 		printf("using interface name '%s'.\n", ifr.ifr_name);
 #endif
+		/* try to switch the socket into CAN FD mode */
+		const int canfd_on = 1;
+		setsockopt(s[i], SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfd_on, sizeof(canfd_on));
 
 		if (ioctl(s[i], SIOCGIFINDEX, &ifr) < 0) {
 			perror("SIOCGIFINDEX");
@@ -402,9 +405,9 @@ int main(int argc, char **argv)
 				}
 
 				stat[i].recv_frames++;
-				stat[i].recv_bits_payload += frame.can_dlc*8;
-				stat[i].recv_bits_total += can_frame_length((struct canfd_frame*)&frame,
-									    mode, sizeof(frame));
+				stat[i].recv_bits_payload += frame.len*8;
+				stat[i].recv_bits_total += can_frame_length(&frame,
+									    mode, nbytes);
 			}
 		}
 	}
-- 
2.25.0

