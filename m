Return-Path: <linux-can+bounces-7556-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCw8ENV2/Gm3QQAAu9opvQ
	(envelope-from <linux-can+bounces-7556-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 13:26:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A174E7709
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 13:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F6A0304875B
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2026 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102DB3C3C1C;
	Thu,  7 May 2026 11:23:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471C3C345D
	for <linux-can@vger.kernel.org>; Thu,  7 May 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153015; cv=none; b=gHMbpxGYfu+LGYM5Kqc8OwGD48XLsCZOC0L12a4UNlxXmonQBCrTZkesjkYxL+ejt0P7mV227RkTdX5vTmDiw0VHz0tx4YT6z50HFwyRFVBqbOfyTohtmN7kASG3RdKtQAYCZu6eFW8qgu/VutfW0CXmlw37ucQzpLjiTMhVTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153015; c=relaxed/simple;
	bh=Pkq/BDOjNe9hNPvfxWkn84cA+kV3vsRmaPmix8Qgv5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4eMa68vhJAbGuJe4PEOo9T8Zs338KGJFNwRi9yutSxXKB9xKIGcXU3mCldaAvIxvzaTy1uJ1io0FkbszbJ5gDrn5AGqIvz2awQb59+zOXzL/kmjjkUKRrRFbQgeYf09KUXYrOiCdiW1zAiwYGsZ8XIufDLylgf/LVLPr6YNsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwpA-0002vj-69; Thu, 07 May 2026 13:23:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp8-000ufd-2w;
	Thu, 07 May 2026 13:23:23 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 096DC530406;
	Thu, 07 May 2026 11:23:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Eulgyu Kim <eulgyukim@snu.ac.kr>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/6] can: raw: add locking for raw flags bitfield
Date: Thu,  7 May 2026 10:22:23 +0200
Message-ID: <20260507112321.439968-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507112321.439968-1-mkl@pengutronix.de>
References: <20260507112321.439968-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 83A174E7709
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-7556-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,msgid.link:url,pengutronix.de:email,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,snu.ac.kr:email]
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

With commit 890e5198a6e5 ("can: raw: use bitfields to store flags in
struct raw_sock") the formerly separate integer values have been integrated
into a single bitfield. This led to a read-modify-write operation when
changing a flag in raw_setsockopt() which now needs a locking to prevent
concurrent access.

Instead of adding a lock/unlock hell in each of the flag manipulations this
patch introduces a wrapper for a new raw_setsockopt_locked() function
analogue to the isotp_setsockopt[_locked]() approach in net/can/isotp.c

Fixes: 890e5198a6e5 ("can: raw: use bitfields to store flags in struct raw_sock")
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Closes: https://lore.kernel.org/linux-can/20260503112200.22727-1-eulgyukim@snu.ac.kr/
Tested-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Tested-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260504111928.41856-1-socketcan@hartkopp.net
[mkl: use Closes tag instead of Link]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 66 +++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index a26942e78e68..82d9c0499c95 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -562,8 +562,8 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 	return RAW_MIN_NAMELEN;
 }
 
-static int raw_setsockopt(struct socket *sock, int level, int optname,
-			  sockptr_t optval, unsigned int optlen)
+static int raw_setsockopt_locked(struct socket *sock, int optname,
+				 sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
@@ -575,9 +575,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	int flag;
 	int err = 0;
 
-	if (level != SOL_CAN_RAW)
-		return -EINVAL;
-
 	switch (optname) {
 	case CAN_RAW_FILTER:
 		if (optlen % sizeof(struct can_filter) != 0)
@@ -598,17 +595,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 				return -EFAULT;
 		}
 
-		rtnl_lock();
-		lock_sock(sk);
-
 		dev = ro->dev;
-		if (ro->bound && dev) {
-			if (dev->reg_state != NETREG_REGISTERED) {
-				if (count > 1)
-					kfree(filter);
-				err = -ENODEV;
-				goto out_fil;
-			}
+		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED) {
+			if (count > 1)
+				kfree(filter);
+			return -ENODEV;
 		}
 
 		if (ro->bound) {
@@ -622,7 +613,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			if (err) {
 				if (count > 1)
 					kfree(filter);
-				goto out_fil;
+				return err;
 			}
 
 			/* remove old filter registrations */
@@ -642,11 +633,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		}
 		ro->filter = filter;
 		ro->count  = count;
-
- out_fil:
-		release_sock(sk);
-		rtnl_unlock();
-
 		break;
 
 	case CAN_RAW_ERR_FILTER:
@@ -658,16 +644,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		err_mask &= CAN_ERR_MASK;
 
-		rtnl_lock();
-		lock_sock(sk);
-
 		dev = ro->dev;
-		if (ro->bound && dev) {
-			if (dev->reg_state != NETREG_REGISTERED) {
-				err = -ENODEV;
-				goto out_err;
-			}
-		}
+		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED)
+			return -ENODEV;
 
 		/* remove current error mask */
 		if (ro->bound) {
@@ -676,7 +655,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 						   err_mask);
 
 			if (err)
-				goto out_err;
+				return err;
 
 			/* remove old err_mask registration */
 			raw_disable_errfilter(sock_net(sk), dev, sk,
@@ -685,11 +664,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		/* link new err_mask to the socket */
 		ro->err_mask = err_mask;
-
- out_err:
-		release_sock(sk);
-		rtnl_unlock();
-
 		break;
 
 	case CAN_RAW_LOOPBACK:
@@ -769,6 +743,26 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
+static int raw_setsockopt(struct socket *sock, int level, int optname,
+			  sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	if (level != SOL_CAN_RAW)
+		return -EINVAL;
+
+	rtnl_lock();
+	lock_sock(sk);
+
+	err = raw_setsockopt_locked(sock, optname, optval, optlen);
+
+	release_sock(sk);
+	rtnl_unlock();
+
+	return err;
+}
+
 static int raw_getsockopt(struct socket *sock, int level, int optname,
 			  sockopt_t *opt)
 {

base-commit: b266bacba796ff5c4dcd2ae2fc08aacf7ab39153
-- 
2.53.0


