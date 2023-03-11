Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0716B5CE2
	for <lists+linux-can@lfdr.de>; Sat, 11 Mar 2023 15:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCKOfG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Mar 2023 09:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjCKOfF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Mar 2023 09:35:05 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AD1042E
        for <linux-can@vger.kernel.org>; Sat, 11 Mar 2023 06:35:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678545299; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ganOkBNfqE7w6rQicuTUZJRBgvJCzDHkFNnW7ydNOspm2+HPOc69z3LpjmGbuB2V3k
    vy5GrrlZzwkkYoJpALvztiuxRaNWBfucfj6fAPTjhR+monjBt0uYTkBnyNOvdeKZOdib
    FkXWH07yXKMjaXXhya3EprIgswvmZ1fvWXqaic7/yurUCwMCXzXPfpf5ig304ofUFDy5
    XVGTSMdP1RG7ERsfPaQYaqaxMKHg0IZM39JKccIiHcwgjMsmGcG1GRYSqOMgRUZBxGFJ
    qcASZOAXRoLzhr7mui40uVGCVG7CAnOgtMlXLlqcMFuRndX1znf1Gr3wPx9rlhRy3DQR
    DIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678545299;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DyAKFTYLQeaHcX4yOS+IEgE/1jgi7l0etoifzCVHp6E=;
    b=kOUfDmqIwEUSXiqJupDREnIVea8eLRnS5kDJuLpvCGYsNINUj+wL0amxyx8DuX9W//
    +rDnzrvw2OgfyCVK5sCWLPePdMMPFqaQf+FmCsj+EqyxjBMkt7KHPAisjUWI6sJisRIm
    oo3x0WBom+kmmI3HoXYkC8xC47Iu6QvcTI1yKmVt+49Fx8kVCxcDZpijGx8bDVSW22Ha
    N4azxNGrGZHfAllURJ1jI04WfAQvnLpP2P218wt0DzJ0OPmHHPhBTBcTCJP3RosE3wlO
    cG1mbh99aezQO0zoF5nA46GswdV5Mg0FIQkfVdVkAo4GEegzRjBf7ZK4kvncN9ADLELC
    YlfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678545299;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DyAKFTYLQeaHcX4yOS+IEgE/1jgi7l0etoifzCVHp6E=;
    b=eqskSpw0i5nW0iYhBE/KZja+XgxFBQAczoSLC3Zrvl5jWr2Pdxfn86d117Mg3Dcxf/
    K3RM8m9YkjlQk6oOmZAJTGG+DcyLAX9lwMH42FguXY9TzkbUTDYJ7Kj+VESQ5XDmG0FM
    8uhYgNPu/F7dK1VxHa8lJTAKe0layt4AZiMW5xzfCHrrWNyXzmwZjK7REzTKnocdFh3q
    nE5v2M+3lFVlfh57F/qegiHHPtbQtdgn8Ui1x++7Khdr0xBGtqZ7UZyn1V7xMtj1F9tH
    5iQlU6bb1QWe2Zzl/QtTwb8/jf4t+3uEhipip/IH9aq8iD3dMkiZcKlpUunWaGoqNsY9
    AOdw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id c675b3z2BEYxVtF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 11 Mar 2023 15:34:59 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH] can: isotp: add module parameter for maximum pdu size
Date:   Sat, 11 Mar 2023 15:34:46 +0100
Message-Id: <20230311143446.3183-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With ISO 15765-2:2016 the PDU size is not limited to 2^12 - 1 (4095) bytes
but can be represented as a 32 bit unsigned integer value which allows
2^32 - 1 bytes (~4GB). The use-cases like automotive unified diagnostic
services (UDS) and flashing of ECUs still use the small static buffers
which are provided at socket creation time.

When a use-case requires to transfer PDUs up to 1025 kByte the maximum
PDU size can now be extended by setting the module parameter max_pdu_size.
The extended size buffers are only allocated on a per-socket/connection
base when needed at run-time.

Link: https://github.com/raspberrypi/linux/issues/5371
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 59 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..3f052deeaaa0 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -83,14 +83,22 @@ MODULE_ALIAS("can-proto-6");
 			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
 			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
 
 /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
  * take full 32 bit values (4 Gbyte). We would need some good concept to handle
- * this between user space and kernel space. For now increase the static buffer
- * to something about 64 kbyte to be able to test this new functionality.
+ * this between user space and kernel space. For now set the static buffer to
+ * something about 8 kbyte to be able to test this new functionality.
  */
-#define MAX_MSG_LENGTH 66000
+#define DEFAULT_MAX_PDU_SIZE 8300
+
+/* limit the isotp pdu size from the optional module parameter to 1MByte */
+#define MAX_PDU_SIZE (1025 * 1024U)
+
+static unsigned int max_pdu_size __read_mostly = DEFAULT_MAX_PDU_SIZE;
+module_param(max_pdu_size, uint, 0444);
+MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu size (default "
+		 __stringify(DEFAULT_MAX_PDU_SIZE) ")");
 
 /* N_PCI type values in bits 7-4 of N_PCI bytes */
 #define N_PCI_SF 0x00	/* single frame */
 #define N_PCI_FF 0x10	/* first frame */
 #define N_PCI_CF 0x20	/* consecutive frame */
@@ -121,17 +129,19 @@ enum {
 	ISOTP_WAIT_DATA,
 	ISOTP_SENDING
 };
 
 struct tpcon {
-	unsigned int idx;
+	u8 *buf;
+	unsigned int buflen;
 	unsigned int len;
+	unsigned int idx;
 	u32 state;
 	u8 bs;
 	u8 sn;
 	u8 ll_dl;
-	u8 buf[MAX_MSG_LENGTH + 1];
+	u8 sbuf[DEFAULT_MAX_PDU_SIZE];
 };
 
 struct isotp_sock {
 	struct sock sk;
 	int bound;
@@ -501,11 +511,21 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	off = (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 
 	if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
 		return 1;
 
-	if (so->rx.len > MAX_MSG_LENGTH) {
+	/* PDU size > default => try max_pdu_size */
+	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
+		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
+
+		if (newbuf) {
+			so->rx.buf = newbuf;
+			so->rx.buflen = max_pdu_size;
+		}
+	}
+
+	if (so->rx.len > so->rx.buflen) {
 		/* send FC frame with overflow status */
 		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
 		return 1;
 	}
 
@@ -945,11 +965,21 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			goto err_out;
 
 		so->tx.state = ISOTP_SENDING;
 	}
 
-	if (!size || size > MAX_MSG_LENGTH) {
+	/* PDU size > default => try max_pdu_size */
+	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
+		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL);
+
+		if (newbuf) {
+			so->tx.buf = newbuf;
+			so->tx.buflen = max_pdu_size;
+		}
+	}
+
+	if (!size || size > so->tx.buflen) {
 		err = -EINVAL;
 		goto err_out_drop;
 	}
 
 	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
@@ -1193,10 +1223,16 @@ static int isotp_release(struct socket *sock)
 	hrtimer_cancel(&so->rxtimer);
 
 	so->ifindex = 0;
 	so->bound = 0;
 
+	if (so->rx.buf != so->rx.sbuf)
+		kfree(so->rx.buf);
+
+	if (so->tx.buf != so->tx.sbuf)
+		kfree(so->tx.buf);
+
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
 	sock_put(sk);
@@ -1589,10 +1625,15 @@ static int isotp_init(struct sock *sk)
 	so->tx.ll_dl = so->ll.tx_dl;
 
 	so->rx.state = ISOTP_IDLE;
 	so->tx.state = ISOTP_IDLE;
 
+	so->rx.buf = so->rx.sbuf;
+	so->tx.buf = so->tx.sbuf;
+	so->rx.buflen = DEFAULT_MAX_PDU_SIZE;
+	so->tx.buflen = DEFAULT_MAX_PDU_SIZE;
+
 	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
 	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
@@ -1656,11 +1697,13 @@ static struct notifier_block canisotp_notifier = {
 
 static __init int isotp_module_init(void)
 {
 	int err;
 
-	pr_info("can: isotp protocol\n");
+	max_pdu_size = min(max_pdu_size, (unsigned int)MAX_PDU_SIZE);
+
+	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
 
 	err = can_proto_register(&isotp_can_proto);
 	if (err < 0)
 		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
 	else
-- 
2.30.2

