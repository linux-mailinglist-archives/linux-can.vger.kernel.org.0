Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497CEA808F
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfIDKoR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53313 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbfIDKoR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:17 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Slr-0003XS-DI; Wed, 04 Sep 2019 12:44:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Kurt Van Dijck <kurt.van.dijck@eia.be>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 18/21] can: introduce CAN_REQUIRED_SIZE macro
Date:   Wed,  4 Sep 2019 12:44:02 +0200
Message-Id: <20190904104405.21675-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190904104405.21675-1-mkl@pengutronix.de>
References: <20190904104405.21675-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Kurt Van Dijck <kurt.van.dijck@eia.be>

The size of this structure will be increased with J1939 support. To stay
binary compatible, the CAN_REQUIRED_SIZE macro is introduced for
existing CAN protocols.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/core.h | 8 ++++++++
 net/can/bcm.c            | 4 ++--
 net/can/raw.c            | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 708c10d3417a..8339071ab08b 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -41,6 +41,14 @@ struct can_proto {
 	struct proto *prot;
 };
 
+/* required_size
+ * macro to find the minimum size of a struct
+ * that includes a requested member
+ */
+#define CAN_REQUIRED_SIZE(struct_type, member) \
+	(offsetof(typeof(struct_type), member) + \
+	 sizeof(((typeof(struct_type) *)(NULL))->member))
+
 /* function prototypes for the CAN networklayer core (af_can.c) */
 
 extern int  can_proto_register(const struct can_proto *cp);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 28fd1a1c8487..c96fa0f33db3 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1294,7 +1294,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		/* no bound device as default => check msg_name */
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
-		if (msg->msg_namelen < sizeof(*addr))
+		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
 			return -EINVAL;
 
 		if (addr->can_family != AF_CAN)
@@ -1536,7 +1536,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 	struct net *net = sock_net(sk);
 	int ret = 0;
 
-	if (len < sizeof(*addr))
+	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
 		return -EINVAL;
 
 	lock_sock(sk);
diff --git a/net/can/raw.c b/net/can/raw.c
index fdbc36140e9b..59c039d73c6d 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -396,7 +396,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	int err = 0;
 	int notify_enetdown = 0;
 
-	if (len < sizeof(*addr))
+	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
 		return -EINVAL;
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
@@ -733,7 +733,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (msg->msg_name) {
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
-		if (msg->msg_namelen < sizeof(*addr))
+		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
 			return -EINVAL;
 
 		if (addr->can_family != AF_CAN)
-- 
2.23.0.rc1

