Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71826717C9
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2019 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbfGWMJL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jul 2019 08:09:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:35088 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbfGWMJL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jul 2019 08:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563883745;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=tVi3QKTkhPZ7f0x5SZqo2vghfFSKEi5hjctPkldtnww=;
        b=FO2EiPTaEmtkJ/DDWJenLZAzOzCeSFNAjsPX3i46mX5dd+aA1A0XwfjUA0jNo3QMb2
        e/3YmPrY/eHGHlg1frzm3SMsa15xpInM3QrAk6gOPUaYoJa+PASHkI8snr+OguEY85cg
        jZdiSurpsRbclhP3MfxCXYCt9pj1AcB/5w4kTlc1cGULNZmTVsx3uGEkXysddFsm9zQ7
        ec40mlLqBEF8FHytCnDz86Q9Oa0sWH/fwBkdT0v5xf7EEe02yvy/dzlUQmsew8zlwPj+
        pdZimyBs6XD0PuRW+TPEo4uOU1omfhc6+QAANhQeXPBbJAks17Qfe21gkFYTfOsk7sY1
        YNvA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lO8DsfULo/u/TWqP+w=="
X-RZG-CLASS-ID: mo00
Received: from zbook.lan
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6NC95e0o
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 23 Jul 2019 14:09:05 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: remove obsolete empty ioctl() handler
Date:   Tue, 23 Jul 2019 14:08:47 +0200
Message-Id: <20190723120847.7453-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With commit c7cbdbf29f488a ("net: rework SIOCGSTAMP ioctl handling") the only
ioctl function in can_ioctl() has been removed.

As this SIOCGSTAMP ioctl command is now handled in net/socket.c we can entirely
remove the CAN specific ioctl functions.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/core.h | 1 -
 net/can/af_can.c         | 9 ---------
 net/can/bcm.c            | 2 +-
 net/can/raw.c            | 2 +-
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 6099bc18bd0c..f8284a94a13d 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -57,6 +57,5 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      void *data);
 
 extern int can_send(struct sk_buff *skb, int loop);
-extern int can_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 
 #endif /* !_CAN_CORE_H */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 80281ef2ccbd..9c86de2da45e 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -87,15 +87,6 @@ static atomic_t skbcounter = ATOMIC_INIT(0);
  * af_can socket functions
  */
 
-int can_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	default:
-		return -ENOIOCTLCMD;
-	}
-}
-EXPORT_SYMBOL(can_ioctl);
-
 static void can_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_receive_queue);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index a34ee52f19ea..1eecf4d3e8d2 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1688,7 +1688,7 @@ static const struct proto_ops bcm_ops = {
 	.accept        = sock_no_accept,
 	.getname       = sock_no_getname,
 	.poll          = datagram_poll,
-	.ioctl         = can_ioctl,	/* use can_ioctl() from af_can.c */
+	.ioctl         = sock_no_ioctl,
 	.gettstamp     = sock_gettstamp,
 	.listen        = sock_no_listen,
 	.shutdown      = sock_no_shutdown,
diff --git a/net/can/raw.c b/net/can/raw.c
index afcbff063a67..bbbe3dd0abe9 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -845,7 +845,7 @@ static const struct proto_ops raw_ops = {
 	.accept        = sock_no_accept,
 	.getname       = raw_getname,
 	.poll          = datagram_poll,
-	.ioctl         = can_ioctl,	/* use can_ioctl() from af_can.c */
+	.ioctl         = sock_no_ioctl,
 	.gettstamp     = sock_gettstamp,
 	.listen        = sock_no_listen,
 	.shutdown      = sock_no_shutdown,
-- 
2.20.1

