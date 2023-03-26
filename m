Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8432D6C9414
	for <lists+linux-can@lfdr.de>; Sun, 26 Mar 2023 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCZL7W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Mar 2023 07:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZL7V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Mar 2023 07:59:21 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E28D40F0
        for <linux-can@vger.kernel.org>; Sun, 26 Mar 2023 04:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679831957; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oVwlLjXlTPpeOrnh0Qib1UuCC6Qewl5/1nmK2wudU9Qs0hBVgxToZjQNdvykwvW6y3
    ex3GdRiilczO8MTE+y7tUieTIBnTA5gAbDiAZgauX4Ssyug41fx2EwaZAyyj1CasdbnZ
    lMeJq35WarZYnUc4ks539ieTRMzR9lFHsQ7xkXIkI3wciq+FzuExXm4G5UKJ+fl9Ur2u
    gIFdazgQnCKDsjTZfNY7MH2V7AqFqsUhz6nZw7ko3yBU12RxNcAjsNQbnkux4lOoBUKQ
    9apQd58Lo/qPOyZB2yt9zCA576ktxrGGWOMmYDGoMxiyUcej82z2UaBlrWZZQZUDnFSo
    T6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679831957;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UkWJgOgAg/3aM+vUmBjEFphnlgN+tTMIpxfOFqmzm8E=;
    b=bSPCRtSZ29Sg0z7zZtK3QzUqXXrUhR+dmew68n9QJMHQdb+9JCmWWH+mfqooOBE0ac
    HKdlLZta0tRxpGGYOwIbEVY/JacCYpK2ceoFYXj2vvi6TyCv89Q4KSN+OIxYft4p49AB
    Y3bHnTxGjumXYMf+mjp5jjlk9NUBdmFkLslwhjQZQnFtTNLumeiDGxeQL/hQhylvPDVq
    IPqdqExwWV+8BkXsXEsS2ZJDWzgoVzf+FbrI+RJiltggHN2Pzzw9cTn7Ilki+Q1pClcn
    tpEE05wzvAnG8Ty5ITsqDgVf6iVp8R+LL3GKhUvVNT0V9BGh0cbdRX+sCVwWtz2H4qmn
    NW4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679831957;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UkWJgOgAg/3aM+vUmBjEFphnlgN+tTMIpxfOFqmzm8E=;
    b=D4oS9394iIZztLNlH9B3Hk+PBJPzMyoMwUocE8Xs0CzO9OC2Igkqxy2hwvedE5dbc1
    lhdcIslGWiDlyKoPlfxGP+1Uaqd1GM5wKcHfUcb4DU1uBYIiMbPbuMiDBt6tNJt6dPKx
    u+7umbzZRIkGel/k1akv+cYo+ZAGxqJavgVbyjL2WsDNZPJJMJPjwfz7LkWKQRgpxQ6h
    Jq0iQndUy5+zkvj3UBWGrjdpnzk15p8VICi/6+610oAwoafQGNmQAmCTZ7zPfs9RatBZ
    b0DyDvSLL0BGAwEhZVCoJoXEhJxhrATrS0OZIkaAAfLZToFHfUiXS4LZBI//SroTVNdy
    ThCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2QBxHSFm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 26 Mar 2023 13:59:17 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v3] can: isotp: add module parameter for maximum pdu size
Date:   Sun, 26 Mar 2023 13:59:11 +0200
Message-Id: <20230326115911.15094-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

v2: limit the minimum 'max_pdu_size' to 4095 to maintain the classic behavior
    before ISO 15765-2:2016
v3: use ARRAY_SIZE() to reference DEFAULT_MAX_PDU_SIZE only at one place

 net/can/isotp.c | 65 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..f1ea91772ae7 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -83,14 +83,25 @@ MODULE_ALIAS("can-proto-6");
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
+/* maximum PDU size before ISO 15765-2:2016 extension was 4095 */
+#define MAX_12BIT_PDU_SIZE 4095
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
@@ -121,17 +132,19 @@ enum {
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
@@ -501,11 +514,21 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
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
 
@@ -805,11 +828,11 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 	cf->len = so->tx.ll_dl;
 	if (ae)
 		cf->data[0] = so->opt.ext_address;
 
 	/* create N_PCI bytes with 12/32 bit FF_DL data length */
-	if (so->tx.len > 4095) {
+	if (so->tx.len > MAX_12BIT_PDU_SIZE) {
 		/* use 32 bit FF_DL notation */
 		cf->data[ae] = N_PCI_FF;
 		cf->data[ae + 1] = 0;
 		cf->data[ae + 2] = (u8)(so->tx.len >> 24) & 0xFFU;
 		cf->data[ae + 3] = (u8)(so->tx.len >> 16) & 0xFFU;
@@ -945,11 +968,21 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
@@ -1193,10 +1226,16 @@ static int isotp_release(struct socket *sock)
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
@@ -1589,10 +1628,15 @@ static int isotp_init(struct sock *sk)
 	so->tx.ll_dl = so->ll.tx_dl;
 
 	so->rx.state = ISOTP_IDLE;
 	so->tx.state = ISOTP_IDLE;
 
+	so->rx.buf = so->rx.sbuf;
+	so->tx.buf = so->tx.sbuf;
+	so->rx.buflen = ARRAY_SIZE(so->rx.sbuf);
+	so->tx.buflen = ARRAY_SIZE(so->tx.sbuf);
+
 	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
 	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
@@ -1656,11 +1700,14 @@ static struct notifier_block canisotp_notifier = {
 
 static __init int isotp_module_init(void)
 {
 	int err;
 
-	pr_info("can: isotp protocol\n");
+	max_pdu_size = max_t(unsigned int, max_pdu_size, MAX_12BIT_PDU_SIZE);
+	max_pdu_size = min_t(unsigned int, max_pdu_size, MAX_PDU_SIZE);
+
+	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
 
 	err = can_proto_register(&isotp_can_proto);
 	if (err < 0)
 		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
 	else
-- 
2.30.2

