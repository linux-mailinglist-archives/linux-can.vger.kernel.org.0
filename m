Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25600580013
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGYNoP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiGYNoM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:44:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7E81571A
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so10445747pff.12
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOu9YUM6Ji0MsJsMIp3h8H8qFcYV0eOWOkGJgGfZD8o=;
        b=evvSYXJtGusrDC9mmHVULGDkT6+kdE9qY5jPQ2BZMQJmmYMEVG6nH/Q0F1tP4Lk+Zp
         OdXeek+iTyV0GvFlKnwP/0TFDH3XpZDwr4/SzfbutO/ZhOMcA3Dh3pMUe72QMcd0b8ng
         +761FS9DiP9gK4JoN5DQRqVwDxf7nwxh90iFv+FDsTg2yHjTjGt5TISZLN9hBiPLDosR
         ddWHiIVkxjHvMr+YXG0FV1rVOaXKCJMvQVr4qL+YX7ut88qZd8VedoFJaD4by6wSt5qn
         8EXMx2GbyEDUfc3g1C4ffAlH3+PO9+0wH6Bt/tcTe8SJzIcm0goAWUYSLgp3o5YT7Yk3
         fmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vOu9YUM6Ji0MsJsMIp3h8H8qFcYV0eOWOkGJgGfZD8o=;
        b=Wuv9h7h+bZXroJNTWbzo5926uVtHD7HyO4Eds5GbtnK8pLHGKS5nd/4WuHfQEOUU92
         zBOrUZr5hyveAwiDVxktlZR37CungX8ecO+C9CsKGsmh4v3npFYjHN6ya5wJbI5JW9uu
         OoKvUkP00YhrWVPpFIU1fD7MbDK15UMHC2CP9by4KkrkYZs1X8qnV60Os4m5690pYs0P
         nzFrwF188PyiBTkuRl2tb92KOujaSnxfNx4xNrJp98qYxQGbc8z28PdaQ6eY115rhLD8
         x7rkuBW0J1w0PMD/nATyOhDAxtzxnY05flv4JRuZ7PszVmbOdvV/u4xdiLMrBq8UyI18
         nFhw==
X-Gm-Message-State: AJIora/RKW0FdUcRmFOR/GpwC1AejG6J4OxZjbWeuSukv2OBhiZlj+Cq
        kLrP9A5eLhiwgFKPNDnSEvy7SzfENmg=
X-Google-Smtp-Source: AGRyM1tiViw82KvZRuUVSh7sZhWDdbb7NxJcc8Esi5KVqWX29ERkF/nGPbhRrRZVAAjg1tmlpZEVmA==
X-Received: by 2002:a63:4b62:0:b0:41a:e5be:fe23 with SMTP id k34-20020a634b62000000b0041ae5befe23mr6458615pgl.140.1658756649993;
        Mon, 25 Jul 2022 06:44:09 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm9579795pfi.89.2022.07.25.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:44:09 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 4/4] can-roundrip-stats: add hardware timestamps information
Date:   Mon, 25 Jul 2022 22:43:45 +0900
Message-Id: <20220725134345.432367-5-mailhol.vincent@wanadoo.fr>
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

In addition, add the feature to report both the RX and TX hardware
timestamps. The RX and TX hardware timestamps are equal. This is
because the TX frame and the RX frame are actually the same thing
because of the loopback feature of socket CAN.

Same as before, the feature is hardcoded, but it can be easily
deactivated by commenting out line 56:
| #define HARDWARE_TIMESTAMP

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 can-roundtrip-stats.c | 128 +++++++++++++++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 33 deletions(-)

diff --git a/can-roundtrip-stats.c b/can-roundtrip-stats.c
index 2e2ff90..877d8f3 100644
--- a/can-roundtrip-stats.c
+++ b/can-roundtrip-stats.c
@@ -53,6 +53,9 @@
 		__LINE__, __func__, ##args);		\
 })
 
+/* Comment out this line to deactivate Hardware timestamps */
+#define HARDWARE_TIMESTAMP
+
 static inline struct timespec
 timespec_sub(const struct timespec a, const struct timespec b)
 {
@@ -275,7 +278,27 @@ bool is_timestamp_zero(struct timespec ts)
 	return !(ts.tv_sec || ts.tv_nsec);
 }
 
-int get_tx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
+enum timestamp_type {
+	NONE = 0x00,
+	SW = 0x01,
+	HW = 0x02
+};
+
+enum timestamp_type get_timestamp_type(struct timespec *sw_ts, struct timespec *hw_ts)
+{
+	enum timestamp_type type = NONE;
+
+	if (!is_timestamp_zero(*sw_ts))
+		type |= SW;
+	if (!is_timestamp_zero(*hw_ts))
+		type |= HW;
+
+
+	return type;
+}
+
+enum timestamp_type get_tx_timestamp(int soc, struct msghdr *msg,
+				     struct timespec *sw_ts, struct timespec *hw_ts)
 {
 	struct cmsghdr *cmsg;
 	int i, ret;
@@ -300,11 +323,14 @@ int get_tx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 		case SCM_TIMESTAMPING:
 			tss = (struct scm_timestamping *)CMSG_DATA(cmsg);
 			for (i = 0;
-			     i < (int)(cmsg->cmsg_len / sizeof(*tss));
+			     i < (int)(cmsg->cmsg_len / sizeof(*tss->ts));
 			     i++)
 				debug(1, "SCM_TIMESTAMPING: tss->ts[%d]: %lu.%lu\n",
 				      i, tss->ts[i].tv_sec, tss->ts[i].tv_nsec);
-			*tspec = tss->ts[0];
+			if (!is_timestamp_zero(tss->ts[0]))
+				*sw_ts = tss->ts[0];
+			if (!is_timestamp_zero(tss->ts[2]))
+				*hw_ts = tss->ts[2];
 			break;
 
 		case PACKET_TX_TIMESTAMP:
@@ -326,10 +352,11 @@ int get_tx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 		}
 	}
 
-	return is_timestamp_zero(*tspec) ? -ENODATA : 0;
+	return get_timestamp_type(sw_ts, hw_ts);
 }
 
-int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
+enum timestamp_type get_rx_timestamp(int soc, struct msghdr *msg,
+				     struct timespec *sw_ts, struct timespec *hw_ts)
 {
 	struct cmsghdr *cmsg;
 	int i, ret;
@@ -360,8 +387,8 @@ int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 			tv = (struct timeval *)CMSG_DATA(cmsg);
 			debug(1, "SO_TIMESTAMP: stamp = %lu.%06lu\n",
 			      tv->tv_sec, tv->tv_usec);
-			tspec->tv_sec = tv->tv_sec;
-			tspec->tv_nsec = tv->tv_usec * 1000;
+			sw_ts->tv_sec = tv->tv_sec;
+			sw_ts->tv_nsec = tv->tv_usec * 1000;
 			break;
 
 		case SO_TIMESTAMPING:
@@ -371,7 +398,8 @@ int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 			     i++)
 				debug(1, "SO_TIMESTAMPING: stamp[%d] = %ld.%09ld\n",
 				      i, stamp[i].tv_sec, stamp[i].tv_nsec);
-			*tspec = stamp[0];
+			*sw_ts = stamp[0];
+			*hw_ts = stamp[2];
 			break;
 
 		default:
@@ -379,7 +407,7 @@ int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 		}
 	}
 
-	return is_timestamp_zero(*tspec) ? -ENODATA : 0;
+	return get_timestamp_type(sw_ts, hw_ts);
 }
 
 void print_stats(const char *timestamp_name, canid_t canid,
@@ -393,36 +421,41 @@ void print_stats(const char *timestamp_name, canid_t canid,
 
 }
 
-void calc_and_print_stats(struct timespec kernel_tx, struct timespec kernel_rx,
-			  struct timespec user_tx, struct timespec user_rx,
-			  canid_t canid)
+void calc_and_print_stats(struct timespec user_tx, struct timespec user_rx,
+			  struct timespec kernel_sw_tx, struct timespec kernel_sw_rx,
+			  struct timespec kernel_hw_tx, struct timespec kernel_hw_rx,
+			  int drop_cnt, canid_t canid)
 {
-	struct timespec kernel_diff, user_diff;
+	struct timespec kernel_sw_diff, kernel_hw_diff, user_diff;
 	struct timespec user_to_kernel_tx, kernel_to_user_rx;
 	static double kernel_time_sum = 0, user_time_sum = 0;
 	static double user_to_kernel_tx_sum = 0, kernel_to_user_rx_sum = 0;
 
 	static int cnt = 0;
 
-	kernel_diff = timespec_sub(kernel_rx, kernel_tx);
-	kernel_time_sum += kernel_diff.tv_sec + kernel_diff.tv_nsec / 1000000000.;
-	user_to_kernel_tx = timespec_sub(kernel_tx, user_tx);
+	kernel_sw_diff = timespec_sub(kernel_sw_rx, kernel_sw_tx);
+	kernel_hw_diff = timespec_sub(kernel_hw_rx, kernel_hw_tx);
+	kernel_time_sum += kernel_sw_diff.tv_sec + kernel_sw_diff.tv_nsec / 1000000000.;
+	user_to_kernel_tx = timespec_sub(kernel_sw_tx, user_tx);
 	user_to_kernel_tx_sum += user_to_kernel_tx.tv_sec + user_to_kernel_tx.tv_nsec / 1000000000.;
-	kernel_to_user_rx = timespec_sub(user_rx, kernel_rx);
+	kernel_to_user_rx = timespec_sub(user_rx, kernel_sw_rx);
 	kernel_to_user_rx_sum += kernel_to_user_rx.tv_sec + kernel_to_user_rx.tv_nsec / 1000000000.;
 	user_diff = timespec_sub(user_rx, user_tx);
 	user_time_sum += user_diff.tv_sec + user_diff.tv_nsec / 1000000000.;
 	cnt++;
 
 	print_stats("User", canid, user_tx, user_rx, user_diff);
-	print_stats("Kernel", canid, kernel_tx, kernel_rx, kernel_diff);
+	print_stats("Kernel Software", canid, kernel_sw_tx, kernel_sw_rx, kernel_sw_diff);
+	if (!(is_timestamp_zero(kernel_hw_tx) || is_timestamp_zero(kernel_hw_rx)))
+		print_stats("Kernel Hardware", canid, kernel_hw_tx, kernel_hw_rx, kernel_hw_diff);
 	printf("User to kernel TX: %ld.%09ld, kernel to user RX:  %ld.%09ld\n",
-	       timespec_sub(kernel_tx, user_tx).tv_sec,
-	       timespec_sub(kernel_tx, user_tx).tv_nsec,
-	       timespec_sub(user_rx, kernel_rx).tv_sec,
-	       timespec_sub(user_rx, kernel_rx).tv_nsec);
-	printf("[Average] Total: %d, user to kernel (tx): %fs, kernel round trip: %fs, kernel to user (rx): %fs, user round trip: %fs\n\n",
-	       cnt, user_to_kernel_tx_sum / cnt,
+	       timespec_sub(kernel_sw_tx, user_tx).tv_sec,
+	       timespec_sub(kernel_sw_tx, user_tx).tv_nsec,
+	       timespec_sub(user_rx, kernel_sw_rx).tv_sec,
+	       timespec_sub(user_rx, kernel_sw_rx).tv_nsec);
+	printf("[Average] Total: %d, drop count: %d, user to kernel (tx): %fs, kernel round trip: %fs, kernel to user (rx): %fs, user round trip: %fs\n\n",
+	       cnt, drop_cnt,
+	       user_to_kernel_tx_sum / cnt,
 	       kernel_time_sum / cnt, kernel_to_user_rx_sum / cnt,
 	       user_time_sum / cnt);
 }
@@ -443,15 +476,26 @@ int main(int argc, char **argv)
 				3 * sizeof(struct timespec) +
 				sizeof(__u32))];
 	const int recv_own_msg = 1;
-	const int timestamping_flags = SOF_TIMESTAMPING_SOFTWARE |
-				       SOF_TIMESTAMPING_TX_SOFTWARE |
-				       SOF_TIMESTAMPING_RX_SOFTWARE |
-				       SOF_TIMESTAMPING_RAW_HARDWARE;
+	const int timestamping_flags_sw = SOF_TIMESTAMPING_SOFTWARE |
+					  SOF_TIMESTAMPING_TX_SOFTWARE |
+					  SOF_TIMESTAMPING_RX_SOFTWARE;
+
+#ifdef HARDWARE_TIMESTAMP
+	const int timestamping_flags_hw = SOF_TIMESTAMPING_TX_HARDWARE |
+					  SOF_TIMESTAMPING_RX_HARDWARE |
+					  SOF_TIMESTAMPING_RAW_HARDWARE |
+					  SOF_TIMESTAMPING_OPT_TX_SWHW;
+
+	const int timestamping_flags = timestamping_flags_sw | timestamping_flags_hw;
+#else
+	const int timestamping_flags = timestamping_flags_sw;
+#endif
 
 	struct canfd_frame frame;
 	int can_id = 0 /* | CAN_EFF_FLAG */;
 
-	struct timespec kernel_tx, kernel_rx;
+	struct timespec kernel_sw_tx, kernel_sw_rx;
+	struct timespec kernel_hw_tx, kernel_hw_rx;
 	struct timespec user_tx, user_rx;
 
 	if (argc != 2)
@@ -497,6 +541,8 @@ int main(int argc, char **argv)
 	msg.msg_control = &ctrlmsg;
 
 	while (true) {
+		static int drop_cnt = 0;
+		enum timestamp_type tx_type = NONE, rx_type = NONE;
 		int ret;
 
 		/* these settings may be modified by recvmsg() */
@@ -510,23 +556,39 @@ int main(int argc, char **argv)
 		clock_gettime(CLOCK_REALTIME, &user_tx);
 		send_canfd_frame_str(soc, can_id++, "", CANFD_BRS);
 
-
 		/* Reading from the error queue is always a
 		   non-blocking operation. c.f.:
 		   https://docs.kernel.org/networking/timestamping.html#blocking-read
 		   Read first from the "normal" queue to leave time
 		   for the error queue to be ready.*/
-		get_rx_timestamp(soc, &msg, &kernel_rx);
+		rx_type |= get_rx_timestamp(soc, &msg, &kernel_sw_rx, &kernel_hw_rx);
 
 		/* Empirical tests show that the error queue is always
 		   ready after the "normal" one. This while loop is
 		   just a failsafe.
 		   Yet, TODO: use poll() or select() instead of this
 		   dirty while loop. */
-		while ((ret = get_tx_timestamp(soc, &msg, &kernel_tx)) == -ENODATA);
+		while ((ret = get_tx_timestamp(soc, &msg, &kernel_sw_tx, &kernel_hw_tx)) < 0);
+		tx_type |= ret;
+
+		if (timestamping_flags & SOF_TIMESTAMPING_OPT_TX_SWHW) {
+			/* Need to unqueue the error queue twice: once for
+			  software and once for hardware timesptamps */
+			while ((ret = get_tx_timestamp(soc, &msg, &kernel_sw_tx, &kernel_hw_tx)) < 0);
+			tx_type |= ret;
+		}
+
+		/* Assert that we got at least the software timestamp
+		   for TX and RX */
+		if (!(rx_type & tx_type & SW)) {
+			drop_cnt++;
+			continue;
+		}
 
 		clock_gettime(CLOCK_REALTIME, &user_rx);
-		calc_and_print_stats(kernel_tx, kernel_rx, user_tx, user_rx,
+		calc_and_print_stats(user_tx, user_rx,
+				     kernel_sw_tx, kernel_sw_rx,
+				     kernel_hw_tx, kernel_hw_rx, drop_cnt,
 				     ((struct canfd_frame *)msg.msg_iov->iov_base)->can_id);
 	}
 
-- 
2.35.1

