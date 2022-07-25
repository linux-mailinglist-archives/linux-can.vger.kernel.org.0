Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681C4580012
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiGYNoO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiGYNoM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:44:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A0515710
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso10331081pjq.1
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGtwfpPcfL9iN3S8XcwK02mfbKUPAkwKcqgzdWPDBLs=;
        b=Xk0ucDnQffVw3yTXmtFq83RWu5F/+wXH2yxSK+lJNg2mTwXASeWYP5hO73eTCtPb6y
         RoXu8XMozz8qIwcLIpzI/3dZtJnT2cD6gGg04Z8bPRBaK6OQaXU3ASJBZmztNTR7yOlx
         N9yjwqa3NsVWt3glWGUTIv14IYqMepeVVXLBSHtHYwUYNfGiEHiSMNXaw+D3rIWUy4hH
         kH85aNnQGDsbD5eoK+U6OnnlV856gXcgcq3pp5u7m8QG/iJcXEzeoG5wfG0wjHQ2LYSY
         KLq75AvzfZpTmIxxxTrHYe5onDYbkPzegGByUme3ebmIWtROYvSsgZ9YBqqMPrCuhTNn
         +nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qGtwfpPcfL9iN3S8XcwK02mfbKUPAkwKcqgzdWPDBLs=;
        b=Szh98qwDhSSXSRp2lqczLE68lF8Ezh5K0DTom0ZrxMc2yXAy0mDwTsoqOvVzc/M52D
         MN6/2bcm1RIfQi1gtbPDEFGYJYMNhnDNOVP8Q2VmV5PG5Mw0sTd3cQurt31afy1WKXMY
         2baYYyEZwrF4OjcbviWvqECZCIPKjt9Vtf/rUd+vR4OZgrD9c3zSak5YAPs7zGjeYNwk
         +CUsMq3uNV9IR8bBQHzAUHQp1di678j9b9URXhGnYInzLD1aFGG1AoPOV27NLNABDpu9
         A1RYr1lb76KRkoWo+fOWf0LRRkbINnyrkhB516/G/nalUOx1zm3OUGnSRWZN1Kh7672J
         dZ0g==
X-Gm-Message-State: AJIora+c58579Wjbz0nGzraJkPKUXWUrZiigAqYOHMqq7KOPvLCw/yT0
        mRFf3aXY6isNIpItmgng5RoIKSwOwlA=
X-Google-Smtp-Source: AGRyM1vfEplJ6eVvxbwzpEnLtney6Vsog9KVVK9k2m5Yhlw+Gwv8pm1jgdZPGoA0DGeDz7g46Xk5jQ==
X-Received: by 2002:a17:902:f80b:b0:16d:8d61:f13b with SMTP id ix11-20020a170902f80b00b0016d8d61f13bmr1249172plb.91.1658756648556;
        Mon, 25 Jul 2022 06:44:08 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm9579795pfi.89.2022.07.25.06.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:44:08 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 3/4] can-roundtrip-stats: rewrite the logic of the main loop to make it more robust
Date:   Mon, 25 Jul 2022 22:43:44 +0900
Message-Id: <20220725134345.432367-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725134345.432367-1-mailhol.vincent@wanadoo.fr>
References: <20220725134345.432367-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The initial version was poorly writen and relied on some dirty hacks
using flags to wait for messages on the socket. Instead, make the
socket blocking (i.e. go back to default and remove O_NONBLOCK flag).

N.B.: error queue is always non-blocking [1]. For this reason, first
check the normal queue. This gives enough time for TX timestamps to
reach the error queue. Use a dirty while loop as a fail-safe in case
the TX timestamps still arrive too late. Would be cleaner to use
poll() or select(). There is room for improvement.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 can-roundtrip-stats.c | 77 ++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/can-roundtrip-stats.c b/can-roundtrip-stats.c
index 9d828d1..2e2ff90 100644
--- a/can-roundtrip-stats.c
+++ b/can-roundtrip-stats.c
@@ -270,17 +270,19 @@ int read_can_frame(int soc, struct canfd_frame *frame, int ms_timeout)
 	return -1;
 }
 
+bool is_timestamp_zero(struct timespec ts)
+{
+	return !(ts.tv_sec || ts.tv_nsec);
+}
+
 int get_tx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 {
 	struct cmsghdr *cmsg;
-	static bool warn_once = false;
-	int ret;
+	int i, ret;
 
-	ret = recvmsg(soc, msg, MSG_ERRQUEUE);
+	ret = recvmsg(soc, msg, MSG_ERRQUEUE | 0);
 	if (ret <= 0) {
-		if (!warn_once)
-			perror("recvmsg");
-		warn_once = true;
+		perror("get_tx_timestamp:recvmsg");
 		return ret;
 	} else {
 		struct canfd_frame *frame = msg->msg_iov->iov_base;
@@ -297,8 +299,11 @@ int get_tx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 		switch (cmsg->cmsg_type) {
 		case SCM_TIMESTAMPING:
 			tss = (struct scm_timestamping *)CMSG_DATA(cmsg);
-			debug(1, "SCM_TIMESTAMPING: tss->ts[0]: %lu.%lu\n",
-			      tss->ts[0].tv_sec, tss->ts[0].tv_nsec);
+			for (i = 0;
+			     i < (int)(cmsg->cmsg_len / sizeof(*tss));
+			     i++)
+				debug(1, "SCM_TIMESTAMPING: tss->ts[%d]: %lu.%lu\n",
+				      i, tss->ts[i].tv_sec, tss->ts[i].tv_nsec);
 			*tspec = tss->ts[0];
 			break;
 
@@ -321,20 +326,17 @@ int get_tx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 		}
 	}
 
-	return 1;
+	return is_timestamp_zero(*tspec) ? -ENODATA : 0;
 }
 
 int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 {
 	struct cmsghdr *cmsg;
-	static bool warn_once = false;
 	int i, ret;
 
 	ret = recvmsg(soc, msg, 0);
 	if (ret <= 0) {
-		if (!warn_once)
-			perror("recvmsg");
-		warn_once = true;
+		perror("get_rx_timestamp:recvmsg");
 		return ret;
 	} else {
 		struct canfd_frame *frame = msg->msg_iov->iov_base;
@@ -342,6 +344,11 @@ int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 		      frame->can_id, frame->len, data_to_int(frame->data));
 	}
 
+	if (!(msg->msg_flags & MSG_DONTROUTE)) {
+		debug(0, "We are not the sender, ignore the frame");
+		return -ENODATA;
+	}
+
 	for (cmsg = CMSG_FIRSTHDR(msg);
 	     cmsg /* && (cmsg->cmsg_level == SOL_SOCKET) */;
 	     cmsg = CMSG_NXTHDR(msg, cmsg)) {
@@ -360,7 +367,7 @@ int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 		case SO_TIMESTAMPING:
 			stamp = (struct timespec *)CMSG_DATA(cmsg);
 			for (i = 0;
-			     i < (int)(cmsg->cmsg_len / sizeof(struct timespec));
+			     i < (int)(cmsg->cmsg_len / sizeof(*stamp));
 			     i++)
 				debug(1, "SO_TIMESTAMPING: stamp[%d] = %ld.%09ld\n",
 				      i, stamp[i].tv_sec, stamp[i].tv_nsec);
@@ -372,7 +379,7 @@ int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 		}
 	}
 
-	return 1;
+	return is_timestamp_zero(*tspec) ? -ENODATA : 0;
 }
 
 void print_stats(const char *timestamp_name, canid_t canid,
@@ -463,7 +470,6 @@ int main(int argc, char **argv)
 
 	addr.can_family = AF_CAN;
 	addr.can_ifindex = ifr.ifr_ifindex;
-	fcntl(soc, F_SETFL, O_NONBLOCK);
 
 	/* try to switch the socket into CAN FD mode */
 	setsockopt(soc, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfd_on, sizeof(canfd_on));
@@ -491,7 +497,7 @@ int main(int argc, char **argv)
 	msg.msg_control = &ctrlmsg;
 
 	while (true) {
-		static bool got_tx_timestamp = false;
+		int ret;
 
 		/* these settings may be modified by recvmsg() */
 		iov.iov_len = sizeof(frame);
@@ -499,20 +505,29 @@ int main(int argc, char **argv)
 		msg.msg_controllen = sizeof(ctrlmsg);
 		msg.msg_flags = 0;
 
-		if (!got_tx_timestamp) {
-			if (get_tx_timestamp(soc, &msg, &kernel_tx) == 1) {
-				got_tx_timestamp = true;
-				continue;
-			}
-			usleep(100000);
-			clock_gettime(CLOCK_REALTIME, &user_tx);
-			send_canfd_frame_str(soc, can_id++, "", CANFD_BRS);
-		} else if (get_rx_timestamp(soc, &msg, &kernel_rx) == 1) {
-			got_tx_timestamp = false;
-			clock_gettime(CLOCK_REALTIME, &user_rx);
-			calc_and_print_stats(kernel_tx, kernel_rx, user_tx, user_rx,
-					     ((struct canfd_frame *)msg.msg_iov->iov_base)->can_id);
-		}
+		/* send new frame */
+		usleep(100000);
+		clock_gettime(CLOCK_REALTIME, &user_tx);
+		send_canfd_frame_str(soc, can_id++, "", CANFD_BRS);
+
+
+		/* Reading from the error queue is always a
+		   non-blocking operation. c.f.:
+		   https://docs.kernel.org/networking/timestamping.html#blocking-read
+		   Read first from the "normal" queue to leave time
+		   for the error queue to be ready.*/
+		get_rx_timestamp(soc, &msg, &kernel_rx);
+
+		/* Empirical tests show that the error queue is always
+		   ready after the "normal" one. This while loop is
+		   just a failsafe.
+		   Yet, TODO: use poll() or select() instead of this
+		   dirty while loop. */
+		while ((ret = get_tx_timestamp(soc, &msg, &kernel_tx)) == -ENODATA);
+
+		clock_gettime(CLOCK_REALTIME, &user_rx);
+		calc_and_print_stats(kernel_tx, kernel_rx, user_tx, user_rx,
+				     ((struct canfd_frame *)msg.msg_iov->iov_base)->can_id);
 	}
 
 	close(soc);
-- 
2.35.1

