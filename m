Return-Path: <linux-can+bounces-4572-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED5B4FE30
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 15:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52834E4F6C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E707345721;
	Tue,  9 Sep 2025 13:48:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881B342C84
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425730; cv=none; b=WxOcAHOFeC20/wb4i1R8g8tSsQQswi7ok2tVx03MWajkp5f9x1JT4h5pKjOKh4PStmlA/6cy8zwaq8oxcE8wY/euH3Z1E/A/zL/sHGTnS25/jwBSXORA48NuEFnwD6X1SNX/X3cHStJmUOFUu6Sg1NIImddYUsT8l6I37gTyHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425730; c=relaxed/simple;
	bh=iW2n5GH/4gJJq4YFEEWYmR4SvihvrrgIcQ9OWppZ29I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHjFPX4SX6ak5uYPwp+ekbj/fGRtiJXOp6rCokWA8QM87Q6kjINzwrVUDjeZv7HHCHU/Nawq1ZgrQ5ZkcMtNtq5diJ8uTxhUpSGCpgNwfyK6qEbHbHtd2gGaF8PdEiuepPEDhGz5/PUHCk8POg5G9pNaJRmnAT9Q3UBaH6S2mAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvyiE-0002lx-8l
	for linux-can@vger.kernel.org; Tue, 09 Sep 2025 15:48:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvyiD-000QmL-04
	for linux-can@vger.kernel.org;
	Tue, 09 Sep 2025 15:48:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A0ADB46A056
	for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 13:48:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6FD9F46A027;
	Tue, 09 Sep 2025 13:48:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f32ea1bd;
	Tue, 9 Sep 2025 13:48:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/7] can: j1939: implement NETDEV_UNREGISTER notification handler
Date: Tue,  9 Sep 2025 15:34:56 +0200
Message-ID: <20250909134840.783785-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909134840.783785-1-mkl@pengutronix.de>
References: <20250909134840.783785-1-mkl@pengutronix.de>
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is reporting

  unregister_netdevice: waiting for vcan0 to become free. Usage count = 2

problem, for j1939 protocol did not have NETDEV_UNREGISTER notification
handler for undoing changes made by j1939_sk_bind().

Commit 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct
callback") expects that a call to j1939_priv_put() can be unconditionally
delayed until j1939_sk_sock_destruct() is called. But we need to call
j1939_priv_put() against an extra ref held by j1939_sk_bind() call
(as a part of undoing changes made by j1939_sk_bind()) as soon as
NETDEV_UNREGISTER notification fires (i.e. before j1939_sk_sock_destruct()
is called via j1939_sk_release()). Otherwise, the extra ref on "struct
j1939_priv" held by j1939_sk_bind() call prevents "struct net_device" from
dropping the usage count to 1; making it impossible for
unregister_netdevice() to continue.

Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Tested-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Fixes: 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct callback")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/ac9db9a4-6c30-416e-8b94-96e6559d55b2@I-love.SAKURA.ne.jp
[mkl: remove space in front of label]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/main.c       |  3 +++
 net/can/j1939/socket.c     | 49 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 31a93cae5111..81f58924b4ac 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -212,6 +212,7 @@ void j1939_priv_get(struct j1939_priv *priv);
 
 /* notify/alert all j1939 sockets bound to ifindex */
 void j1939_sk_netdev_event_netdown(struct j1939_priv *priv);
+void j1939_sk_netdev_event_unregister(struct j1939_priv *priv);
 int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk);
 void j1939_tp_init(struct j1939_priv *priv);
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 7e8a20f2fc42..3706a872ecaf 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -377,6 +377,9 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 		j1939_sk_netdev_event_netdown(priv);
 		j1939_ecu_unmap_all(priv);
 		break;
+	case NETDEV_UNREGISTER:
+		j1939_sk_netdev_event_unregister(priv);
+		break;
 	}
 
 	j1939_priv_put(priv);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 3d8b588822f9..70ebc861ea2a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1300,6 +1300,55 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
+void j1939_sk_netdev_event_unregister(struct j1939_priv *priv)
+{
+	struct sock *sk;
+	struct j1939_sock *jsk;
+	bool wait_rcu = false;
+
+rescan: /* The caller is holding a ref on this "priv" via j1939_priv_get_by_ndev(). */
+	read_lock_bh(&priv->j1939_socks_lock);
+	list_for_each_entry(jsk, &priv->j1939_socks, list) {
+		/* Skip if j1939_jsk_add() is not called on this socket. */
+		if (!(jsk->state & J1939_SOCK_BOUND))
+			continue;
+		sk = &jsk->sk;
+		sock_hold(sk);
+		read_unlock_bh(&priv->j1939_socks_lock);
+		/* Check if j1939_jsk_del() is not yet called on this socket after holding
+		 * socket's lock, for both j1939_sk_bind() and j1939_sk_release() call
+		 * j1939_jsk_del() with socket's lock held.
+		 */
+		lock_sock(sk);
+		if (jsk->state & J1939_SOCK_BOUND) {
+			/* Neither j1939_sk_bind() nor j1939_sk_release() called j1939_jsk_del().
+			 * Make this socket no longer bound, by pretending as if j1939_sk_bind()
+			 * dropped old references but did not get new references.
+			 */
+			j1939_jsk_del(priv, jsk);
+			j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+			j1939_netdev_stop(priv);
+			/* Call j1939_priv_put() now and prevent j1939_sk_sock_destruct() from
+			 * calling the corresponding j1939_priv_put().
+			 *
+			 * j1939_sk_sock_destruct() is supposed to call j1939_priv_put() after
+			 * an RCU grace period. But since the caller is holding a ref on this
+			 * "priv", we can defer synchronize_rcu() until immediately before
+			 * the caller calls j1939_priv_put().
+			 */
+			j1939_priv_put(priv);
+			jsk->priv = NULL;
+			wait_rcu = true;
+		}
+		release_sock(sk);
+		sock_put(sk);
+		goto rescan;
+	}
+	read_unlock_bh(&priv->j1939_socks_lock);
+	if (wait_rcu)
+		synchronize_rcu();
+}
+
 static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
 				unsigned long arg)
 {
-- 
2.51.0



