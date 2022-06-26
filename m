Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817655B010
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiFZHxk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiFZHxk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 03:53:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D9412AD4
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 00:53:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t21so6288406pfq.1
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qgx3SLir3D+rM2mDeZLWXW+LvDmdzVToGseY5N7nS9c=;
        b=d/D8r3OIJNfani/fj1vaRxvSEb7IYi1i8l7ELjNHnnNVUCm/YDOSydFK+euUpSwFHh
         eF+UrNJbnU3O+vAPUx4Ez1zEVuImTdRYjWr7qzCwJ9+CEJTzMrPo0SZZ0ZSClW2p3M/w
         pAgAVbhdiBqGLQQZCiFHMatPzLQLY7eeTkmV1TMJZTBX7/9l44Rr/8QlP4NeHTc8v1Qp
         IS3uPo/GTPVaaxWRCgGbqayFcidskgNLgckaYGmBEntn2Z30H33AMe3ekXdY28R01S6x
         IECdHIct6WVZ3WgmvlSCy9fMUz2Tz1G3XCuLfpcsul+R4LJC/wwhlOP7iTAKYqrTY6jm
         samw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Qgx3SLir3D+rM2mDeZLWXW+LvDmdzVToGseY5N7nS9c=;
        b=KkDHkA/Uw26ib7skXg4/fd1lmn1yuD8epCXeKSpxxuIXC2ZIDvXVpJPWgp9oZVla2E
         QMswNFxctRQGv1UN5DLeqhoxbBvPGMUsK43liby6LrvxTbzcqT5kROVPF+7rEOQzsLYN
         rs0AMcIFtOuA7fIwuqzonCrOe1Zr/qGaM1ANYgeZ/UNv56ZI1Ba6iQzkj3zOIqCe90oa
         E++LL8U4Sm6xrtq1jFizTw1BvCI9mFYHcrYNMX/rKenl+irxXJ3h8e9LSpFpx+wRqC/w
         H4npHSARTtH7b0BMWrUBzGlD6CxhXUqXz7Fqyr53oeKlF/zuvE6WaFIqIafGYp75zbhN
         UUVg==
X-Gm-Message-State: AJIora+Tfbvp7MPyv9AjsirjBd/TxcbL0vQgOa7ADE+OB+vULWQVVoSM
        L6J/sO+lbWEszqSTtdy7mV+BEAiItcM=
X-Google-Smtp-Source: AGRyM1v4VugOhYj9isIBwjMD9BByh7UHYO3qvK/AcYYjdls6Ky0+Dzz5+53WA5aa+GYjMv/O6GSk7g==
X-Received: by 2002:a05:6a00:a06:b0:51e:47f5:79ad with SMTP id p6-20020a056a000a0600b0051e47f579admr8180323pfh.53.1656230017354;
        Sun, 26 Jun 2022 00:53:37 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id bx23-20020a056a00429700b005251f4596f0sm4719502pfb.107.2022.06.26.00.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 00:53:36 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Rhett Aultman <rhett.aultman@samsara.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH] can-roundtrip-stats: a tool to benchmark transmission time
Date:   Sun, 26 Jun 2022 16:53:17 +0900
Message-Id: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a simple tool I wrote in the past. It will report the time
need for a packet to travel from:
  * application TX path to kernel TX path
  * kernel TX path to kernel RX path (i.e. kernel round trip)
  * kernel RX path to application RX path
  * application TX path to application RX path (i.e application round
    trip)

This tool is useful to benchmark latency on software and hardware. It
can be used to, for example:
  * compare performances of two CAN controllers (by using the kernel
    round trip information)
  * compare the different CAN queue disciplines (by using the
    application TX path to kernel TX path information)

I am sharing it as-is. Please see this message as an FYI. I do not
consider this mature enough and I am not expecting anyone to pick that
patch. Everything is hard coded, I did not put effort to make it
configurable.

The tool requires the TX timestamps (which I previously added to the
kernel in [1] and [2]).

To use it:
| $make
| ./can-roundtrip-stats

My ultimate goal was to add the TX timestamp feature to candump from
can-utils [3], however, I faced a blocker: the TX timestamps are sent
to the error queue of the sender's socket meaning that a listener
(such as candump) will not see those TX timestamp on his error queue
because this is a different socket as the sender. If anyone knows a
method to access the error queue of another process's socket, let me
know (I guess that you need to be root, but did not find how to do
it).

Because I did not manage to add the feature to candump, I am sharing
instead this standalone tool, hoping someone might find it useful.

At the moment, I am not planning to invest more time in the
foreseeable future. If someone want to take over and make is a bit
more sexy so that it can reach can-utils, go ahead. I think that it
basically misses a command line interface in the same fashion of
cangen to make is configurable.

Else, you can also tweak the hard coded information to easily adjust
it to your needs.

[1] commit eb88531bdbfa ("can: raw: add missing error queue support")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb88531bdbfaafb827192d1fc6c5a3fcc4fadd96

[2] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

[3] candump.c
Link: https://github.com/linux-can/can-utils/blob/master/candump.c

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 Makefile              |   1 +
 can-roundtrip-stats.c | 497 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 498 insertions(+)
 create mode 100644 Makefile
 create mode 100644 can-roundtrip-stats.c

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..fa4be40
--- /dev/null
+++ b/Makefile
@@ -0,0 +1 @@
+can-roundtrip-stats: can-roundtrip-stats.o
diff --git a/can-roundtrip-stats.c b/can-roundtrip-stats.c
new file mode 100644
index 0000000..8597199
--- /dev/null
+++ b/can-roundtrip-stats.c
@@ -0,0 +1,497 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/* Copyright (c) 2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr> */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <ctype.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <errno.h>
+
+#include <time.h>
+
+#include <byteswap.h>
+
+#include <net/if.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <fcntl.h>
+#include <sys/select.h>
+
+#include <limits.h>
+
+#include <linux/can.h>
+#include <linux/can/raw.h>
+#include <linux/net_tstamp.h>
+#include <linux/errqueue.h>
+#include <linux/if_packet.h>
+
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define debug(debug_level, fmt, args...)		\
+({							\
+	if (DEBUG >= debug_level)			\
+		printf("%s:%d:%s(): " fmt, __FILE__,	\
+		       __LINE__, __func__, ##args);	\
+ })
+
+#define debug_no_header(debug_level, fmt, args...)	\
+({							\
+	if (DEBUG >= debug_level)			\
+		printf(fmt, ##args);			\
+})
+
+#define error(fmt, args...)				\
+({							\
+	fprintf(stderr, "%s:%d:%s(): " fmt, __FILE__,	\
+		__LINE__, __func__, ##args);		\
+})
+
+static inline struct timespec
+timespec_sub(const struct timespec a, const struct timespec b)
+{
+	struct timespec diff;
+
+	diff.tv_sec  = a.tv_sec - b.tv_sec;
+	diff.tv_nsec = a.tv_nsec - b.tv_nsec;
+	if (diff.tv_nsec < 0) {
+		diff.tv_sec--;
+		diff.tv_nsec += 1000000000;
+	}
+	if (diff.tv_sec < 0)
+		memset(&diff, 0, sizeof(diff));
+
+	return diff;
+}
+
+/* Convert ascii hexadecimal value to int. */
+int nibble_to_int(char hex)
+{
+	if (!isxdigit(hex)) {
+		error("Expected ascii hexadecimal value but got %c (0x%x).\n", hex, hex);
+		exit(EXIT_FAILURE);
+	}
+
+	switch (hex) {
+
+	case '0': return 0x0;
+	case '1': return 0x1;
+	case '2': return 0x2;
+	case '3': return 0x3;
+	case '4': return 0x4;
+	case '5': return 0x5;
+	case '6': return 0x6;
+	case '7': return 0x7;
+	case '8': return 0x8;
+	case '9': return 0x9;
+	case 'a': case 'A': return 0xa;
+	case 'b': case 'B': return 0xb;
+	case 'c': case 'C': return 0xc;
+	case 'd': case 'D': return 0xd;
+	case 'e': case 'E': return 0xe;
+	case 'f': case 'F': return 0xf;
+
+	default:
+		error("This portion of code should not be reached.\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Convert the first two hexadecimal charater of the string to an int. */
+uint8_t byte_to_int(char *hex)
+{
+	uint8_t res;
+
+	res = nibble_to_int(hex[0]);
+	res <<= 4;
+	res += nibble_to_int(hex[1]);
+
+	return res;
+}
+
+/* Convert the 64 bits (8 bytes) payload into an integer. */
+uint64_t data_to_int(uint8_t *data)
+{
+	uint64_t res;
+
+	res  = (uint64_t)data[0] << 56;
+	res += (uint64_t)data[1] << 48;
+	res += (uint64_t)data[2] << 40;
+	res += (uint64_t)data[3] << 32;
+	res += (uint64_t)data[4] << 24;
+	res += (uint64_t)data[5] << 16;
+	res += (uint64_t)data[6] <<  8;
+	res += (uint64_t)data[7];
+
+	return res;
+}
+
+void make_can_frame(struct can_frame *frame, int can_id, char *data)
+{
+	size_t data_length;
+	size_t can_dlc;
+	size_t i;
+
+	data_length = strlen(data);
+	if (data_length % 2 == 1)
+		error("Payload contains some half bytes.\n");
+
+	can_dlc = data_length / 2;
+	if (can_dlc > CAN_MAX_DLEN)
+		error("Maximum payload length is 8 bytes.\n");
+	
+	frame->can_id = can_id;
+	frame->can_dlc = can_dlc;
+
+	for (i=0; i<can_dlc; i++)
+		frame->data[i] = byte_to_int(data + 2 * i);
+}
+
+void make_canfd_frame(struct canfd_frame *frame, int can_id, char *data, uint8_t flags)
+{
+	size_t data_length;
+	size_t can_len;
+	size_t i;
+
+	data_length = strlen(data);
+	if (data_length % 2 == 1)
+		error("Payload contains some half bytes.\n");
+
+	can_len = data_length / 2;
+	if (can_len > CANFD_MAX_DLEN)
+		error("Maximum payload length is 8 bytes.\n");
+	
+	frame->can_id = can_id;
+	frame->len = can_len;
+	frame->flags = flags;
+
+	for (i=0; i<can_len; i++)
+		frame->data[i] = byte_to_int(data + 2 * i);
+}
+
+void send_can_frame(int soc, int can_id, size_t len, uint64_t data)
+{
+	struct can_frame frame;
+	ssize_t sentbytes;
+
+	frame.can_id = can_id;
+	frame.can_dlc = (len > 8 ? 8 : len);
+	memcpy(frame.data, &data, frame.can_dlc);
+	sentbytes = write(soc, &frame, sizeof(struct can_frame));
+
+	if (sentbytes != sizeof(struct can_frame))
+		debug(1, "Wrote %zd bytes instead of %zd.\n", sentbytes, sizeof(struct can_frame));
+	else
+		debug(2, "Wrote %zd bytes.\n", sentbytes);
+	
+	debug(1, "Send: %03X [%d] %0*zX.\n",
+	      frame.can_id, frame.can_dlc, frame.can_dlc * 2, data_to_int(frame.data));
+}
+
+void send_can_frame_str(int soc, int can_id, char *data)
+{
+	struct can_frame frame;
+	ssize_t sentbytes;
+
+	make_can_frame(&frame, can_id, data);
+	sentbytes = write(soc, &frame, sizeof(frame));
+
+	if (sentbytes != sizeof(frame))
+		debug(1, "Wrote %zd bytes instead of %zd.\n", sentbytes, sizeof(struct can_frame));
+	else
+		debug(2, "Wrote %zd bytes.\n", sentbytes);
+	
+	debug(1, "Send: %03X [%d] %0*zX.\n",
+	      frame.can_id, frame.can_dlc, frame.can_dlc * 2, data_to_int(frame.data));
+}
+
+void send_canfd_frame_str(int soc, int can_id, char *data, uint8_t flags)
+{
+	struct canfd_frame frame;
+	ssize_t sentbytes;
+
+	make_canfd_frame(&frame, can_id, data, flags);
+	sentbytes = write(soc, &frame, sizeof(frame));
+
+	if (sentbytes != sizeof(frame))
+		debug(1, "Wrote %zd bytes instead of %zd.\n", sentbytes, sizeof(struct can_frame));
+	else
+		debug(2, "Wrote %zd bytes.\n", sentbytes);
+	
+	debug(1, "Send: %03X [%d] %0*zX.\n",
+	      frame.can_id, frame.len, frame.len * 2, data_to_int(frame.data));
+}
+
+int read_can_frame(int soc, struct canfd_frame *frame, int ms_timeout)
+{
+	int recvbytes = 0;
+	fd_set readSet;
+	struct timeval timeout = {ms_timeout / 1000, (ms_timeout % 1000) * 1000};
+	
+	FD_ZERO(&readSet);
+	FD_SET(soc, &readSet);
+
+	if (select(soc + 1, &readSet, NULL, NULL, &timeout) >= 0) {
+		if (FD_ISSET(soc, &readSet)) {
+			int i;
+
+			recvbytes = read(soc, frame, sizeof(struct canfd_frame));
+			if(!recvbytes)
+				error("This portion of code should not be reached.\n");
+
+			debug(1, "Receive: %03X [%d] ",
+			       frame->can_id, frame->len);
+			for (i = 0; i < frame->len; i++)
+				debug_no_header(1, "%02X", frame->data[i]);
+			debug_no_header(1, ".\n");
+			return 1;
+		} else {
+			debug(3, "Select timed out.\n");
+			return 0;
+		}
+	} else {
+		perror("Select error");
+	}
+
+	return -1;
+}
+
+int get_tx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
+{
+	struct cmsghdr *cmsg;
+	static bool warn_once = false;
+	int ret;
+
+	ret = recvmsg(soc, msg, MSG_ERRQUEUE);
+	if (ret <= 0) {
+		if (!warn_once)
+			perror("recvmsg");
+		warn_once = true;
+		return ret;
+	}
+	else {
+		struct canfd_frame *frame = msg->msg_iov->iov_base;
+		debug(1, "Receive (errqueue): %03X [%d], data: %"PRIu64,
+		      frame->can_id, frame->len, data_to_int(frame->data));
+	}
+
+	for (cmsg = CMSG_FIRSTHDR(msg);
+			 cmsg /* && (cmsg->cmsg_level == SOL_SOCKET) */;
+			 cmsg = CMSG_NXTHDR(msg, cmsg)) {
+		struct scm_timestamping *tss;
+		struct sock_extended_err *serr;
+
+		switch (cmsg->cmsg_type) {
+	case SCM_TIMESTAMPING:
+		tss = (struct scm_timestamping *)CMSG_DATA(cmsg);
+		debug(1, "SCM_TIMESTAMPING: tss->ts[0]: %lu.%lu\n",
+		      tss->ts[0].tv_sec, tss->ts[0].tv_nsec);
+		*tspec = tss->ts[0];
+		break;
+
+	case PACKET_TX_TIMESTAMP:
+		serr = (struct sock_extended_err *)CMSG_DATA(cmsg);
+		if (serr->ee_errno != ENOMSG ||
+		    serr->ee_origin != SO_EE_ORIGIN_TIMESTAMPING) {
+			fprintf(stderr, "unknown ip error %d %d\n",
+				serr->ee_errno,
+				serr->ee_origin);
+			serr = NULL;
+		} else {
+			debug(1, "PACKET_TX_TIMESTAMP: ee_info: %d, ee_data: %d\n",
+			      serr->ee_info, serr->ee_data);
+		}
+		break;
+
+		default:
+			debug(1, "Unknown cmsg_type: %d\n", cmsg->cmsg_type);
+		}
+	}
+
+	return 1;
+}
+
+int get_rx_timestamp(int soc, struct msghdr *msg, struct timespec *tspec)
+{
+	struct cmsghdr *cmsg;
+	static bool warn_once = false;
+	int i, ret;
+
+	ret = recvmsg(soc, msg, 0);
+	if (ret <= 0) {
+		if (!warn_once)
+			perror("recvmsg");
+		warn_once = true;
+		return ret;
+	}
+	else {
+		struct canfd_frame *frame = msg->msg_iov->iov_base;
+		debug(1, "Receive (errqueue): %03X [%d], data: %"PRIu64,
+		       frame->can_id, frame->len, data_to_int(frame->data));
+	}
+		
+	for (cmsg = CMSG_FIRSTHDR(msg);
+			 cmsg /* && (cmsg->cmsg_level == SOL_SOCKET) */;
+			 cmsg = CMSG_NXTHDR(msg, cmsg)) {
+		struct timeval *tv;
+		struct timespec *stamp;
+
+		switch (cmsg->cmsg_type) {
+		case SO_TIMESTAMP:
+			tv = (struct timeval *)CMSG_DATA(cmsg);
+			debug(1, "SO_TIMESTAMP: stamp = %lu.%06lu\n", tv->tv_sec, tv->tv_usec);
+			tspec->tv_sec = tv->tv_sec;
+			tspec->tv_nsec = tv->tv_usec * 1000;
+			break;
+
+		case SO_TIMESTAMPING:
+			stamp = (struct timespec *)CMSG_DATA(cmsg);
+			for (i = 0; i < (int)(cmsg->cmsg_len / sizeof(struct timespec)); i++)
+				debug(1, "SO_TIMESTAMPING: stamp[%d] = %ld.%09ld\n", i, stamp[i].tv_sec, stamp[i].tv_nsec);
+			*tspec = stamp[0];
+			break;
+
+		default:
+			debug(1, "Unknown cmsg_type: %d\n", cmsg->cmsg_type);
+		}
+	}
+
+	return 1;
+}
+
+int main(int argc, char **argv)
+{
+	int soc;
+	struct sockaddr_can addr = {0};
+	struct ifreq ifr = {0};
+
+	const char *default_ifname = "can0";
+	const char *ifname;
+	const int canfd_on = 1;
+
+	struct iovec iov;
+	struct msghdr msg;
+	char ctrlmsg[CMSG_SPACE(sizeof(struct timeval) +
+				3 * sizeof(struct timespec) +
+				sizeof(__u32))];
+	const int recv_own_msg = 1;
+	const int timestamping_flags = SOF_TIMESTAMPING_SOFTWARE |
+				       SOF_TIMESTAMPING_TX_SOFTWARE |
+				       SOF_TIMESTAMPING_RX_SOFTWARE |
+				       SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	struct canfd_frame frame;
+	int can_id = 0 /* | CAN_EFF_FLAG */;
+
+	struct timespec kernel_tx, kernel_rx, kernel_diff;
+	struct timespec user_tx, user_rx, user_diff;
+	struct timespec user_to_kernel_tx, kernel_to_user_rx;
+	int cnt = 0;
+	double kernel_time_sum = 0, user_time_sum = 0;
+	double user_to_kernel_tx_sum = 0, kernel_to_user_rx_sum = 0;
+	
+	if (argc != 2)
+		ifname = default_ifname;
+	else
+		ifname = argv[1];
+	
+	if((soc = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
+			perror("Error while opening CAN socket");
+			exit(EXIT_FAILURE);
+	}
+
+	strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
+	ifr.ifr_name[IFNAMSIZ-1] = '\0';
+	ioctl(soc, SIOCGIFINDEX, &ifr);
+
+	
+	addr.can_family  = AF_CAN;
+	addr.can_ifindex = ifr.ifr_ifindex;
+	fcntl(soc, F_SETFL, O_NONBLOCK);
+
+	/* try to switch the socket into CAN FD mode */
+	setsockopt(soc, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfd_on, sizeof(canfd_on));
+	setsockopt(soc, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, &recv_own_msg, sizeof(recv_own_msg));
+
+	if (setsockopt(soc, SOL_SOCKET, SO_TIMESTAMPING,
+		       &timestamping_flags, sizeof(timestamping_flags)) < 0) {
+		perror("setsockopt SO_TIMESTAMPING is not supported by your Linux kernel");
+		return EXIT_FAILURE;
+	}
+
+	printf("%s at index %d\n", ifname, ifr.ifr_ifindex);
+
+	if (bind(soc, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		{
+			perror("Error in socket bind");
+			exit(EXIT_FAILURE);
+		}
+
+	frame.can_id = 0;
+	/* these settings are static and can be held out of the hot path */
+	iov.iov_base = &frame;
+	msg.msg_name = &addr;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = &ctrlmsg;
+
+	while (true) {
+		static bool got_tx_timestamp = false;
+
+		/* these settings may be modified by recvmsg() */
+		iov.iov_len = sizeof(frame);
+		msg.msg_namelen = sizeof(addr);
+		msg.msg_controllen = sizeof(ctrlmsg);  
+		msg.msg_flags = 0;
+
+		if (!got_tx_timestamp) {
+			if (get_tx_timestamp(soc, &msg, &kernel_tx) == 1) {
+				got_tx_timestamp = true;
+				continue;
+			} else {
+				usleep(100000);
+				clock_gettime(CLOCK_REALTIME, &user_tx);
+				send_canfd_frame_str(soc, can_id++, "", CANFD_BRS);
+			}
+		} else if (get_rx_timestamp(soc, &msg, &kernel_rx) == 1) {
+			got_tx_timestamp = false;
+			clock_gettime(CLOCK_REALTIME, &user_rx);
+			kernel_diff = timespec_sub(kernel_rx, kernel_tx);
+			kernel_time_sum += kernel_diff.tv_sec + kernel_diff.tv_nsec / 1000000000.;
+			user_to_kernel_tx = timespec_sub(kernel_tx, user_tx);
+			user_to_kernel_tx_sum += user_to_kernel_tx.tv_sec + user_to_kernel_tx.tv_nsec / 1000000000.;
+			kernel_to_user_rx = timespec_sub(user_rx, kernel_rx);
+			kernel_to_user_rx_sum += kernel_to_user_rx.tv_sec + kernel_to_user_rx.tv_nsec / 1000000000.;
+			user_diff = timespec_sub(user_rx, user_tx);
+			user_time_sum += user_diff.tv_sec + user_diff.tv_nsec / 1000000000.;
+			cnt++;
+			printf("[User] ID: 0x%x, TX: %ld.%09ld, RX: %ld.%09ld, diff: %ld.%09ld\n",
+			       ((struct canfd_frame *)msg.msg_iov->iov_base)->can_id,
+			       user_tx.tv_sec, user_tx.tv_nsec,
+			       user_rx.tv_sec, user_rx.tv_nsec,
+			       user_diff.tv_sec, user_diff.tv_nsec);
+			printf("[Kernel] ID: 0x%x, TX: %ld.%09ld, RX: %ld.%09ld, diff: %ld.%09ld\n",
+			       ((struct canfd_frame *)msg.msg_iov->iov_base)->can_id,
+			       kernel_tx.tv_sec, kernel_tx.tv_nsec,
+			       kernel_rx.tv_sec, kernel_rx.tv_nsec,
+			       kernel_diff.tv_sec, kernel_diff.tv_nsec);
+			printf("User to kernel TX: %ld.%09ld, kernel to user RX:  %ld.%09ld\n",
+			       timespec_sub(kernel_tx, user_tx).tv_sec,
+			       timespec_sub(kernel_tx, user_tx).tv_nsec,
+			       timespec_sub(user_rx, kernel_rx).tv_sec,
+			       timespec_sub(user_rx, kernel_rx).tv_nsec);
+			printf("[Average] Total: %d, user to kernel (tx): %fs, kernel round trip: %fs, kernel to user (rx): %fs, user round trip: %fs\n\n",
+			       cnt, user_to_kernel_tx_sum / cnt, kernel_time_sum / cnt, kernel_to_user_rx_sum / cnt, user_time_sum / cnt);
+		}
+	}
+
+	close(soc);
+
+	return EXIT_SUCCESS;
+}
-- 
2.35.1

