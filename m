Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537C33B2566
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 05:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFXDXh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Jun 2021 23:23:37 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:58484 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFXDXe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Jun 2021 23:23:34 -0400
X-ASG-Debug-ID: 1624504873-15c43444e47e7f00001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.164.dyn.edpnet.net [94.105.105.164]) by relay-b01.edpnet.be with ESMTP id juFHVHMCAX15KCEK for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 05:21:13 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Apparent-Source-IP: 94.105.105.164
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D36BA1503AE0;
        Thu, 24 Jun 2021 05:21:13 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 2/2] canbusload: count databitrate seperately
Date:   Thu, 24 Jun 2021 05:21:11 +0200
X-ASG-Orig-Subj: [PATCH 2/2] canbusload: count databitrate seperately
Message-Id: <20210624032111.26272-2-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210624032111.26272-1-dev.kurt@vandijck-laurijssen.be>
References: <20210624032111.26272-1-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Start-Time: 1624504873
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 5003
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
 canbusload.c  | 20 ++++++++++++++++----
 canframelen.c | 28 ++++++++++++++++++++++++++++
 canframelen.h |  1 +
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/canbusload.c b/canbusload.c
index bd74cb5..1bbfc72 100644
--- a/canbusload.c
+++ b/canbusload.c
@@ -74,9 +74,11 @@ extern int optind, opterr, optopt;
 static struct {
 	char devname[IFNAMSIZ+1];
 	unsigned int bitrate;
+	unsigned int dbitrate;
 	unsigned int recv_frames;
 	unsigned int recv_bits_total;
 	unsigned int recv_bits_payload;
+	unsigned int recv_bits_dbitrate;
 } stat[MAXSOCK+1];
 
 static int  max_devname_len; /* to prevent frazzled device name output */ 
@@ -103,7 +105,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -e  (exact calculation of stuffed bits)\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Up to %d CAN interfaces with mandatory bitrate can be specified on the \n", MAXSOCK);
-	fprintf(stderr, "commandline in the form: <ifname>@<bitrate>\n\n");
+	fprintf(stderr, "commandline in the form: <ifname>@<bitrate>[,<dbitrate>]\n\n");
 	fprintf(stderr, "The bitrate is mandatory as it is needed to know the CAN bus bitrate to\n");
 	fprintf(stderr, "calculate the bus load percentage based on the received CAN frames.\n");
 	fprintf(stderr, "Due to the bitstuffing estimation the calculated busload may exceed 100%%.\n");
@@ -184,16 +186,18 @@ void printstats(int signo)
 		}
 
 		if (stat[i].bitrate)
-			percent = (stat[i].recv_bits_total*100)/stat[i].bitrate;
+			percent = ((stat[i].recv_bits_total-stat[i].recv_bits_dbitrate)*100)/stat[i].bitrate
+				+ (stat[i].recv_bits_dbitrate*100)/stat[i].dbitrate;
 		else
 			percent = 0;
 
-		printf(" %*s@%-*d %5d %7d %6d %3d%%",
+		printf(" %*s@%-*d %5d %7d %6d %6d %3d%%",
 		       max_devname_len, stat[i].devname,
 		       max_bitrate_len, stat[i].bitrate,
 		       stat[i].recv_frames,
 		       stat[i].recv_bits_total,
 		       stat[i].recv_bits_payload,
+		       stat[i].recv_bits_dbitrate,
 		       percent);
 
 		if (bargraph) {
@@ -220,6 +224,7 @@ void printstats(int signo)
 
 		stat[i].recv_frames = 0;
 		stat[i].recv_bits_total = 0;
+		stat[i].recv_bits_dbitrate = 0;
 		stat[i].recv_bits_payload = 0;
 	}
 
@@ -336,7 +341,12 @@ int main(int argc, char **argv)
 		if (nbytes > max_devname_len)
 			max_devname_len = nbytes; /* for nice printing */
 
-		stat[i].bitrate = atoi(nptr+1); /* bitrate is placed behind the '@' */
+		char *endp;
+		stat[i].bitrate = strtol(nptr+1, &endp, 0); /* bitrate is placed behind the '@' */
+		if (*endp == ',')
+			stat[i].dbitrate = strtol(endp+1, &endp, 0); /* bitrate is placed behind the ',' */
+		else
+			stat[i].dbitrate = stat[i].bitrate;
 
 		if (!stat[i].bitrate || stat[i].bitrate > 1000000) {
 			printf("invalid bitrate for CAN device '%s'!\n", ptr);
@@ -406,6 +416,8 @@ int main(int argc, char **argv)
 
 				stat[i].recv_frames++;
 				stat[i].recv_bits_payload += frame.len*8;
+				stat[i].recv_bits_dbitrate += can_frame_dbitrate_length(
+						&frame, mode, sizeof(frame));
 				stat[i].recv_bits_total += can_frame_length(&frame,
 									    mode, nbytes);
 			}
diff --git a/canframelen.c b/canframelen.c
index b708691..1a3584a 100644
--- a/canframelen.c
+++ b/canframelen.c
@@ -236,11 +236,39 @@ static unsigned cfl_exact(struct can_frame *frame)
 		3;		/* IFS */
 }
 
+unsigned can_frame_dbitrate_length(struct canfd_frame *frame, enum cfl_mode mode, int mtu)
+{
+	if (mtu != CANFD_MTU || !(frame->flags & CANFD_BRS))
+		return 0;
+	switch (mode) {
+	case CFL_NO_BITSTUFFING:
+		return 1 /* brs/crcdel */ + 1 /* esi */ + 4 /* dlc */
+			+ ((frame->len >= 16) ? 21 : 17)
+			+ frame->len*8;
+	case CFL_WORSTCASE:
+		return can_frame_dbitrate_length(frame, CFL_NO_BITSTUFFING, mtu) * 5 / 4;
+	default:
+		return 0;
+	}
+}
 
 unsigned can_frame_length(struct canfd_frame *frame, enum cfl_mode mode, int mtu)
 {
 	int eff = (frame->can_id & CAN_EFF_FLAG);
 
+	if (mtu == CANFD_MTU)
+		/* not correct, but close ? */
+		switch (mode) {
+		case CFL_NO_BITSTUFFING:
+			return 1+(eff ? 29 : 11) + ((frame->len >= 16) ? 21 : 17) +
+				+ 5 /* r1, ide, edl, r0, brs/crcdel, */ + 12 /* trail */
+				+ frame->len*8;
+		case CFL_WORSTCASE:
+			return can_frame_length(frame, CFL_NO_BITSTUFFING, mtu) * 5 / 4;
+		case CFL_EXACT:
+			return 0;	/* CANFD is not supported yet */
+		}
+	else
 	if (mtu != CAN_MTU)
 		return 0;	/* CANFD is not supported yet */
 
diff --git a/canframelen.h b/canframelen.h
index 641119d..47739b2 100644
--- a/canframelen.h
+++ b/canframelen.h
@@ -80,5 +80,6 @@ enum cfl_mode {
  * Mode determines how to deal with stuffed bits.
  */
 unsigned can_frame_length(struct canfd_frame *frame, enum cfl_mode mode, int mtu);
+unsigned can_frame_dbitrate_length(struct canfd_frame *frame, enum cfl_mode mode, int mtu);
 
 #endif
-- 
2.25.0

