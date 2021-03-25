Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0AC349286
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 14:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhCYM71 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 08:59:27 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:15116 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCYM7S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 08:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616677155; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z2hzzoyKhRliphnz3UxpJR0UdwV/n0qvqMGB7g1+drKO5rgUfzFLQL7GIRTg6svU3E
    FUYOURbneB5Wps1qsB147Nby4P3Ujw8vlAD3dlc6+wYOEfGD8z9vYILhfCb5C0jSynAV
    lhLa/OiRFAxrc2RViwlI8dPTNHtbVdEDJp8cvHVQm7PABFacc0DWzb47gyO4DNXlFkDC
    SBF/Dnymo8KkxZqY8heX7S3gBnnjOY32TiYjaCYtGZ+v9KeGHskExy3DoXZOYjRQGFjz
    iUs7lp5cZCkrieCJO39n4o0mOF2f4YkAEMgEqlpreGYmYbbn9BrrRFP+v0vA4lMMI9yT
    8wOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616677155;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BtQvu86BsDEqco/hwzQUxNhpogg7mivKfJlDqcBXnfQ=;
    b=pm0O9JZvmNcVqWZB/3kwVJBSL7ZW0tHR2Ndz5cyQ8JPvPhgkVuCNM3fgTpkHAAmYGy
    LOSD/63KuYkE37z9sAjzdvJNsiQ6mi72dKlL5j74BQg0Bcm7wmuoaEbxoIVMSp8Jkd4L
    CZqcelfi/PHXVhGbbo5F/SGUgBNAMgVY46CxISt/dQVRnepUnN/CzUPmw7oj1p1oFwFD
    gNWrBdk/+qRG3KNeoRmRp+1IiCK5kBXAVu1Q2oBn451lWolZOD4GDTx29J8cjLjA4xp2
    sUkum0r+S766U7vTnsDo8kX2p7DlmTHJWDw46rVqWi5IRLbwhrTxLfanrDrc2ch930iK
    Xfzw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616677155;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BtQvu86BsDEqco/hwzQUxNhpogg7mivKfJlDqcBXnfQ=;
    b=Grtdh96J3RmKeIHHDz7bQPgcNUXyRgrEQNfDkQ1bRu88vrAs0jOpS8HYGyMalIMCSS
    juMATljpQngHH3mo3jxXDyYIAD8E91sUk8pklUqGjT0TbU9Vmui3OZNzOBTkkA9uvWdk
    4KA0RiwMIFKa4q1VH+CzPnVoJcczW5H78IQmmG3enpiE7D4TBk0fIPL0RQjADJ9kH9Xb
    wgAA+Ch2dbf+lhScBMFvlx5N8p+Sxt8jBzMFlIxFytgIf3manYufal7v4YZq0YWAZvuw
    mrIJtmuLWvqkeEH5vtM/Sha3sR8ID/9G7Nj7TX6f+qQfi2hxhLv9fywjpRpQLyRvWduw
    t/hQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVLjM8tyWa"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id z00fabx2PCxF4Ci
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 25 Mar 2021 13:59:15 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Weinberger <richard@nod.at>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 2/3] can: isotp: fix msg_namelen values depending on CAN_REQUIRED_SIZE
Date:   Thu, 25 Mar 2021 13:58:49 +0100
Message-Id: <20210325125850.1620-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325125850.1620-1-socketcan@hartkopp.net>
References: <20210325125850.1620-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit f5223e9eee65 ("can: extend sockaddr_can to include j1939
members") the sockaddr_can has been extended in size and a new
CAN_REQUIRED_SIZE macro has been introduced to calculate the protocol
specific needed size.

The ABI for the msg_name and msg_namelen has not been adapted to the
new CAN_REQUIRED_SIZE macro for the other CAN protocols which leads
to a problem when an existing binary reads the (increased)
struct sockaddr_can in msg_name.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Link: https://lore.kernel.org/linux-can/1135648123.112255.1616613706554.JavaMail.zimbra@nod.at/T/#t
Reported-by: Richard Weinberger <richard@nod.at>
Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 15ea1234d457..9f94ad3caee9 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -75,10 +75,12 @@
 MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
 MODULE_ALIAS("can-proto-6");
 
+#define ISOTP_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp)
+
 #define SINGLE_MASK(id) (((id) & CAN_EFF_FLAG) ? \
 			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
 			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
 
 /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
@@ -984,11 +986,12 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	}
 
 	sock_recv_timestamp(msg, sk, skb);
 
 	if (msg->msg_name) {
-		msg->msg_namelen = sizeof(struct sockaddr_can);
+		__sockaddr_check_size(ISOTP_MIN_NAMELEN);
+		msg->msg_namelen = ISOTP_MIN_NAMELEN;
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
 	skb_free_datagram(sk, skb);
 
@@ -1054,11 +1057,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct net_device *dev;
 	int err = 0;
 	int notify_enetdown = 0;
 	int do_rx_reg = 1;
 
-	if (len < CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp))
+	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
 	/* do not register frame reception for functional addressing */
 	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
 		do_rx_reg = 0;
@@ -1150,17 +1153,17 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	struct isotp_sock *so = isotp_sk(sk);
 
 	if (peer)
 		return -EOPNOTSUPP;
 
-	memset(addr, 0, sizeof(*addr));
+	memset(addr, 0, ISOTP_MIN_NAMELEN);
 	addr->can_family = AF_CAN;
 	addr->can_ifindex = so->ifindex;
 	addr->can_addr.tp.rx_id = so->rxid;
 	addr->can_addr.tp.tx_id = so->txid;
 
-	return sizeof(*addr);
+	return ISOTP_MIN_NAMELEN;
 }
 
 static int isotp_setsockopt(struct socket *sock, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
-- 
2.30.2

