Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E8580010
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiGYNoN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiGYNoM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:44:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F1E14D35
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d3so2553281pls.4
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LH66J8mYFU9/zTNT6L0IkZVf8NEI/rzcGhB6rB4Qnhg=;
        b=HqFJqFlMPuelkubYrNsrn5lNRby44pQ4JNpdLeN0k2RF+Yosgf9nHSQgJdpt0/WDuX
         xTlkArLsjZTxtMLFhcEUAgrFm80ChLonitOx5y2zoMQyXTc7LmrirjVBQJzrKa4/7llH
         4vwiX1NHJcNrrU+0bULFlICyZacGK8Yjjizg4abKbb69rhzCTEsGMKzPDFFQJlCU0MDX
         KAw50gxPUcQYvXLzUBjvNogG7+oIkcZwfQ3ED1hSg9whe9L1EREybwtMBedN8uHqDh6p
         ZdM+kVi2RGIicHN7VxIJcxKUyJrjBplvRYjxh/u2Sdqk5TMMfbqNa657pI4wwfYbeUi9
         9OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LH66J8mYFU9/zTNT6L0IkZVf8NEI/rzcGhB6rB4Qnhg=;
        b=vAIHFGalw7RAyyDKy+8qRGBgJQiZ/hDcoxYEI2RZLXIVCkrufGjCQyG52hdPRWwnQC
         AOx53mRhzGCQjarz3++v55U0ZaiBjTIAx57xuI90wYlquviGLM6BuAUe3iBH++7m9wIK
         iJY7q40tYSaNfZYY95bbOZM9d9JR66aJQS9F0OXT9+SGuGg/2mooSHhJu75CdpF3t02i
         qCMSejob00bnMXJsYU4VxwHfzIBS6Q6ctXUn26sIiJ2VIJ4l82DkZZWrq9dBPHZPXlAV
         OY2UfomWNcobQE2d8UfKhw940sywHa6QG+DBDyYnNFWTTq2wXacgSujEgmLOJXQEfU/w
         mu5Q==
X-Gm-Message-State: AJIora8mkxtVaW8oCcLQyVNLmqIBEBeOgxsbJXM4KPl6lrKvTL7iTPNp
        gnOz1AcE6T6QzwDGOuXU7LwX18ZTiB4=
X-Google-Smtp-Source: AGRyM1t0MivkMT07PKahHqb+aKZlWsKgQTGsEApGWdKnKAR1E4akE5FwPLwg8xflnMI+AFvAwMQYHg==
X-Received: by 2002:a17:903:11d2:b0:167:8a0f:8d33 with SMTP id q18-20020a17090311d200b001678a0f8d33mr12599102plh.95.1658756645698;
        Mon, 25 Jul 2022 06:44:05 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm9579795pfi.89.2022.07.25.06.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:44:05 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/4] can-roundtrip-stats: add print_stats() and calc_and_print_stats()
Date:   Mon, 25 Jul 2022 22:43:42 +0900
Message-Id: <20220725134345.432367-2-mailhol.vincent@wanadoo.fr>
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

Split the main() into sub functions to increase readability.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 can-roundtrip-stats.c | 83 +++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 34 deletions(-)

diff --git a/can-roundtrip-stats.c b/can-roundtrip-stats.c
index b261404..1eaed35 100644
--- a/can-roundtrip-stats.c
+++ b/can-roundtrip-stats.c
@@ -375,6 +375,51 @@ int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
 	return 1;
 }
 
+void print_stats(const char *timestamp_name, canid_t canid,
+		 struct timespec tx, struct timespec rx, struct timespec diff)
+{
+	printf("[%s] ID: 0x%x, TX: %ld.%09ld, RX: %ld.%09ld, diff: %ld.%09ld\n",
+	       timestamp_name, canid,
+	       tx.tv_sec, tx.tv_nsec,
+	       rx.tv_sec, rx.tv_nsec,
+	       diff.tv_sec, diff.tv_nsec);
+
+}
+
+void calc_and_print_stats(struct timespec kernel_tx, struct timespec kernel_rx,
+			  struct timespec user_tx, struct timespec user_rx,
+			  canid_t canid)
+{
+	struct timespec kernel_diff, user_diff;
+	struct timespec user_to_kernel_tx, kernel_to_user_rx;
+	static double kernel_time_sum = 0, user_time_sum = 0;
+	static double user_to_kernel_tx_sum = 0, kernel_to_user_rx_sum = 0;
+
+	static int cnt = 0;
+
+	kernel_diff = timespec_sub(kernel_rx, kernel_tx);
+	kernel_time_sum += kernel_diff.tv_sec + kernel_diff.tv_nsec / 1000000000.;
+	user_to_kernel_tx = timespec_sub(kernel_tx, user_tx);
+	user_to_kernel_tx_sum += user_to_kernel_tx.tv_sec + user_to_kernel_tx.tv_nsec / 1000000000.;
+	kernel_to_user_rx = timespec_sub(user_rx, kernel_rx);
+	kernel_to_user_rx_sum += kernel_to_user_rx.tv_sec + kernel_to_user_rx.tv_nsec / 1000000000.;
+	user_diff = timespec_sub(user_rx, user_tx);
+	user_time_sum += user_diff.tv_sec + user_diff.tv_nsec / 1000000000.;
+	cnt++;
+
+	print_stats("User", canid, user_tx, user_rx, user_diff);
+	print_stats("Kernel", canid, kernel_tx, kernel_rx, kernel_diff);
+	printf("User to kernel TX: %ld.%09ld, kernel to user RX:  %ld.%09ld\n",
+	       timespec_sub(kernel_tx, user_tx).tv_sec,
+	       timespec_sub(kernel_tx, user_tx).tv_nsec,
+	       timespec_sub(user_rx, kernel_rx).tv_sec,
+	       timespec_sub(user_rx, kernel_rx).tv_nsec);
+	printf("[Average] Total: %d, user to kernel (tx): %fs, kernel round trip: %fs, kernel to user (rx): %fs, user round trip: %fs\n\n",
+	       cnt, user_to_kernel_tx_sum / cnt,
+	       kernel_time_sum / cnt, kernel_to_user_rx_sum / cnt,
+	       user_time_sum / cnt);
+}
+
 int main(int argc, char **argv)
 {
 	int soc;
@@ -399,12 +444,8 @@ int main(int argc, char **argv)
 	struct canfd_frame frame;
 	int can_id = 0 /* | CAN_EFF_FLAG */;
 
-	struct timespec kernel_tx, kernel_rx, kernel_diff;
-	struct timespec user_tx, user_rx, user_diff;
-	struct timespec user_to_kernel_tx, kernel_to_user_rx;
-	int cnt = 0;
-	double kernel_time_sum = 0, user_time_sum = 0;
-	double user_to_kernel_tx_sum = 0, kernel_to_user_rx_sum = 0;
+	struct timespec kernel_tx, kernel_rx;
+	struct timespec user_tx, user_rx;
 
 	if (argc != 2)
 		ifname = default_ifname;
@@ -470,34 +511,8 @@ int main(int argc, char **argv)
 		} else if (get_rx_timestamp(soc, &msg, &kernel_rx) == 1) {
 			got_tx_timestamp = false;
 			clock_gettime(CLOCK_REALTIME, &user_rx);
-			kernel_diff = timespec_sub(kernel_rx, kernel_tx);
-			kernel_time_sum += kernel_diff.tv_sec + kernel_diff.tv_nsec / 1000000000.;
-			user_to_kernel_tx = timespec_sub(kernel_tx, user_tx);
-			user_to_kernel_tx_sum += user_to_kernel_tx.tv_sec + user_to_kernel_tx.tv_nsec / 1000000000.;
-			kernel_to_user_rx = timespec_sub(user_rx, kernel_rx);
-			kernel_to_user_rx_sum += kernel_to_user_rx.tv_sec + kernel_to_user_rx.tv_nsec / 1000000000.;
-			user_diff = timespec_sub(user_rx, user_tx);
-			user_time_sum += user_diff.tv_sec + user_diff.tv_nsec / 1000000000.;
-			cnt++;
-			printf("[User] ID: 0x%x, TX: %ld.%09ld, RX: %ld.%09ld, diff: %ld.%09ld\n",
-			       ((struct canfd_frame *)msg.msg_iov->iov_base)->can_id,
-			       user_tx.tv_sec, user_tx.tv_nsec,
-			       user_rx.tv_sec, user_rx.tv_nsec,
-			       user_diff.tv_sec, user_diff.tv_nsec);
-			printf("[Kernel] ID: 0x%x, TX: %ld.%09ld, RX: %ld.%09ld, diff: %ld.%09ld\n",
-			       ((struct canfd_frame *)msg.msg_iov->iov_base)->can_id,
-			       kernel_tx.tv_sec, kernel_tx.tv_nsec,
-			       kernel_rx.tv_sec, kernel_rx.tv_nsec,
-			       kernel_diff.tv_sec, kernel_diff.tv_nsec);
-			printf("User to kernel TX: %ld.%09ld, kernel to user RX:  %ld.%09ld\n",
-			       timespec_sub(kernel_tx, user_tx).tv_sec,
-			       timespec_sub(kernel_tx, user_tx).tv_nsec,
-			       timespec_sub(user_rx, kernel_rx).tv_sec,
-			       timespec_sub(user_rx, kernel_rx).tv_nsec);
-			printf("[Average] Total: %d, user to kernel (tx): %fs, kernel round trip: %fs, kernel to user (rx): %fs, user round trip: %fs\n\n",
-			       cnt, user_to_kernel_tx_sum / cnt,
-			       kernel_time_sum / cnt, kernel_to_user_rx_sum / cnt,
-			       user_time_sum / cnt);
+			calc_and_print_stats(kernel_tx, kernel_rx, user_tx, user_rx,
+					     ((struct canfd_frame *)msg.msg_iov->iov_base)->can_id);
 		}
 	}
 
-- 
2.35.1

