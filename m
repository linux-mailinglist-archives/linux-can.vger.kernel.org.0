Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB26A60B4
	for <lists+linux-can@lfdr.de>; Tue, 28 Feb 2023 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjB1Uuo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Feb 2023 15:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB1Uun (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Feb 2023 15:50:43 -0500
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C84680
        for <linux-can@vger.kernel.org>; Tue, 28 Feb 2023 12:50:40 -0800 (PST)
Received: from localhost (styx2022 [192.168.200.17])
        by smtpx.fel.cvut.cz (Postfix) with ESMTP id 853033BD29;
        Tue, 28 Feb 2023 21:50:39 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
        by localhost (styx2.feld.cvut.cz [192.168.200.17]) (amavisd-new, port 10060)
        with ESMTP id nFGWMevT9_tx; Tue, 28 Feb 2023 21:50:37 +0100 (CET)
Received: from steelpick.2x.cz (ip-94-112-196-33.bb.vodafone.cz [94.112.196.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sojkam1)
        by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 564303BD28;
        Tue, 28 Feb 2023 21:50:37 +0100 (CET)
Received: (nullmailer pid 323005 invoked by uid 1000);
        Tue, 28 Feb 2023 20:50:36 -0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Michal Sojka <michal.sojka@cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Subject: [PATCH] can: isotp: fix poll() to not report false positive EPOLLOUT events
Date:   Tue, 28 Feb 2023 21:50:14 +0100
Message-Id: <20230228205014.322988-1-michal.sojka@cvut.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When using select/poll/epoll() with a non-blocking ISOTP socket to
wait for when non-blocking write is possible, false EPOLLOUT event is
sometimes returned. This can happen at least after sending a message
which must be split to multiple CAN frames.

The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
not equal to ISOTP_IDLE and this behavior is not reflected in
datagram_poll(), which is used in isotp_ops.

This is fixed by introducing ISOTP-specific poll function, which
suppresses the EPOLLOUT events in that case.

Below is a program that can trigger the problem on a vcan interface.
When running the program as:

    ./isotp-poll-test -s 123 -d 321 -o

it starts sending ISOTP messages that include increasing ASCII
numbers. poll() is used to wait before next transmission.

With current mainline Linux, once the message length is greater than 7
bytes, write() returns -EAGAIN and the program terminates. This should
not happen, because the previous poll() reported that the write()
would not block.

After applying this patch, the above command doesn't fail - if one
runs some ISOTP reader such as:

    isotprecv -l -s 321 -d 123 vcan0

This test program can also show another problem. When running:

    ./isotp-poll-test -s 321 -d 123 -i -a

and then in another terminal:

    ./isotp-poll-test -s 123 -d 321 -o

The first program receives the messages and uses the counter values to
check for lost messages. After a random number of iterations a lost
message is always detected. I believe that ISOTP should be reliable
protocol, at least on vcan, shouldn't it?

Anyway, this patch doesn't try to address this problem.

 --8<---------------cut here---------------start------------->8---
 #include <net/if.h>
 #include <sys/socket.h>
 #include <sys/types.h>

 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <poll.h>
 #include <stdbool.h>
 #include <err.h>

 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/types.h>

 #include <linux/can.h>
 #include <linux/can/isotp.h>

 #define CHECK(expr) ({ int ret = (expr); if (ret == -1) err(EXIT_FAILURE, "%s", #expr); ret; })

 int main(int argc, char *argv[])
 {
     int sock;
     struct sockaddr_can addr;
     char opt;
     bool in = false, out = false;
     bool validate_seq = false;
     int buf_size = 0;
     unsigned cnt = 1, max_msgs = 0;

     /* These default can be overridden with -s and -d */
     addr.can_addr.tp.tx_id = 0x123;
     addr.can_addr.tp.rx_id = 0x321;

     while ((opt = getopt(argc, argv, "ac:d:ios:")) != -1) {
         switch (opt) {
         case 'a':
             validate_seq = true;
             break;
         case 'c':
             max_msgs = atol(optarg);
             break;
         case 'i':
             in = true;
             break;
         case 'o':
             out = true;
             break;
         case 's':
             addr.can_addr.tp.tx_id = strtoul(optarg, NULL, 16);
             if (strlen(optarg) > 7)
                 addr.can_addr.tp.tx_id |= CAN_EFF_FLAG;
             break;
         case 'd':
             addr.can_addr.tp.rx_id = strtoul(optarg, NULL, 16);
             if (strlen(optarg) > 7)
                 addr.can_addr.tp.rx_id |= CAN_EFF_FLAG;
             break;
         default: /* '?' */
             err(EXIT_FAILURE, "Usage: %s [-i] [-o]", argv[0]);
         }
     }

     sock = CHECK(socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP));

     const char *ifname = "vcan0";
     addr.can_family = AF_CAN;
     addr.can_ifindex = if_nametoindex(ifname);
     if (!addr.can_ifindex)
         err(EXIT_FAILURE, "%s", ifname);

     CHECK(bind(sock, (struct sockaddr *)&addr, sizeof(addr)));

     int flags = CHECK(fcntl(sock, F_GETFL, 0));
     CHECK(fcntl(sock, F_SETFL, flags | O_NONBLOCK));

     struct pollfd pollfd = {
         .fd = sock,
         .events = ((in ? POLLIN : 0) | ((out & !in) ? POLLOUT : 0))
     };

     do {
         char buf[100];
         int ret;

         CHECK(poll(&pollfd, 1, -1)); /* Wait with infinite timeout */

         if (pollfd.revents & POLLIN) {
             buf_size = CHECK(read(sock, buf, sizeof(buf) - 1));
             printf("#%u: Read %d bytes\n", cnt, buf_size);
             if (validate_seq) {
                 unsigned cnt_rcvd = 0;
                 buf[buf_size] = 0;
                 sscanf(buf, "Hello%u", &cnt_rcvd);
                 if (cnt != cnt_rcvd)
                     errx(EXIT_FAILURE, "Lost messages. Expected: #%u, received #%u", cnt, cnt_rcvd);
             }
             if (out)
                 pollfd.events |= POLLOUT; /* Start writing only after reception of data */
         }
         if (pollfd.revents & POLLOUT) {
             if (!in) {
                 char str[200];
                 sprintf(str, "Hello%u", cnt);
                 ret = CHECK(write(sock, str, strlen(str)));
             } else {
                 ret = CHECK(write(sock, buf, buf_size));
             }
             printf("#%u: Wrote %d bytes\n", cnt, ret);
         }
     } while (cnt++ < max_msgs || max_msgs == 0);

     return 0;
 }
 --8<---------------cut here---------------end--------------->8---

Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
Reported-by: Jakub Jira <jirajak2@fel.cvut.cz>
---
 net/can/isotp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..d205359eaabd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1608,6 +1608,19 @@ static int isotp_init(struct sock *sk)
 	return 0;
 }
 
+static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	__poll_t mask = datagram_poll(file, sock, wait);
+	struct sock *sk = sock->sk;
+	struct isotp_sock *so = isotp_sk(sk);
+
+	/* Check for false positives due to TX state */
+	if ((mask & EPOLLWRNORM) && (so->tx.state != ISOTP_IDLE))
+		mask &= ~(EPOLLOUT | EPOLLWRNORM);
+
+	return mask;
+}
+
 static int isotp_sock_no_ioctlcmd(struct socket *sock, unsigned int cmd,
 				  unsigned long arg)
 {
@@ -1623,7 +1636,7 @@ static const struct proto_ops isotp_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = sock_no_accept,
 	.getname = isotp_getname,
-	.poll = datagram_poll,
+	.poll = isotp_poll,
 	.ioctl = isotp_sock_no_ioctlcmd,
 	.gettstamp = sock_gettstamp,
 	.listen = sock_no_listen,
-- 
2.39.2

