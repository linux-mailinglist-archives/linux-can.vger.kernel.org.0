Return-Path: <linux-can+bounces-8321-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZzMLOQoyUmowNAMAu9opvQ
	(envelope-from <linux-can+bounces-8321-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:07:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A15E741746
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:07:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=gk83zZc0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8321-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8321-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C0A300F5CD
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 12:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605C3AE6EE;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03F3921D1
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771636; cv=none; b=M4PdXhPABp7GVbdwZvx7sN9YwbkY/mNi2dQm+fa2OWma9BepdT+n1dFcXGHA+eZBlP7n8Uy6/f8KuEWh3dMiJCXQeo0napWFjcHuzNUTGU+qbdgGmb1sN8tTpnG/BprbugJ1UWXw1DrWzkYolq1zqzsokcbEGArXa4PlR9Dx3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771636; c=relaxed/simple;
	bh=VQe/jgFFTN7W5Ep2gIvymZ3dZ87mYZKX5LamygCl/20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALpOOEcASon411TozOzCDkv60GdLWBK45pbFvyGwJ9mVaGssxQx5botyP01XvYwI3Tui46k6C4iMDNg8gzzsktBd4fM+MjMJjXJWuudtKQLDLNAS4Ui7SAkoPfGMxDXPnv3PtQlAi0vYjXJtt9pLRzj7+FWEARYoTKBVGExWBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk83zZc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00732C2BCB9;
	Sat, 11 Jul 2026 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783771636;
	bh=VQe/jgFFTN7W5Ep2gIvymZ3dZ87mYZKX5LamygCl/20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gk83zZc0+AizCTWUa2vyfmzZw4nf1blIVJEiJ9a8lTqa/T9THhJ6pg6rgnWtt76Xy
	 dPD5+l7g+dyNyIETV5z4ic5IHrp4LHXz9xbY8IkiLDHT0CccZnyL+FvT2w1ap3+acL
	 Le/pghkq2vxhe5fwtc/EsgRR4UQ/HHBQFNr4sL3aw/lrBbilknsp0fesA7VYiym912
	 j9RZFxYcY4PzGjNWWpXjvK+MbH5uYglsEAkuP3PqkX3p3q1ny4xbL/RgpQfM6I0Q6v
	 0HPBE8hS5JlFF8HbHTOdMw3+/8GASWSxCPRJU88DjmLdOPqf7xZmmj+cnjXCq0P6yO
	 xHKkKUaEyOUwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62E7C44501;
	Sat, 11 Jul 2026 12:07:15 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sat, 11 Jul 2026 14:07:12 +0200
Subject: [PATCH v7 1/5] can: isotp: use unconditional synchronize_rcu() in
 isotp_release()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-isotp-fixes-v7-1-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
In-Reply-To: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783771634; l=2234;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=cSnqoBGcs6wuKBDxRmdL8uS6RqC/TXOr+Os8bOLeol4=;
 b=xCiMngS63huh4KkG/KKZToVABaWUAXX2LD0MY37LyJu87SmB1gebJ9jU2Tpt68ElGv2JZ4JPN
 Spta5cwZWLNADIzS5+GW8gQLAmEbJzaTk74ZMWoPzrR+6iVIgXSP+Ka
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8321-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A15E741746

From: Oliver Hartkopp <socketcan@hartkopp.net>

isotp_notify() unregisters the (RCU) CAN filters via can_rx_unregister()
and clears so->bound without waiting for a grace period. isotp_release()
uses so->bound to decide whether it needs to call synchronize_rcu()
before cancelling so->rxtimer, so when NETDEV_UNREGISTER runs first it
skips that synchronize_rcu() and can cancel the timer while an
in-flight isotp_rcv() is still executing and about to re-arm it via
isotp_send_fc(), leading to a use-after-free timer callback on the
freed socket.

sakisho-bot remarked a problem with rtnl_lock held in isotp_notify(),
therefore make isotp_release() always call synchronize_rcu() before
cancelling the timers, regardless of so->bound. This still closes the
original race (isotp_notify() clearing so->bound without waiting for
in-flight isotp_rcv() callers before isotp_release() cancels the RX
timer) without adding any RCU wait to the netdevice notifier path.

Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer restart on socket release")
Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.kernel.org/
Reported-by: Nico Yip <zdi-disclosures@trendmicro.com> (ZDI-CAN-31764)
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index c48b4a818297..d30937345bcd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1235,15 +1235,22 @@ static int isotp_release(struct socket *sock)
 
 				can_rx_unregister(net, dev, so->txid,
 						  SINGLE_MASK(so->txid),
 						  isotp_rcv_echo, sk);
 				dev_put(dev);
-				synchronize_rcu();
 			}
 		}
 	}
 
+	/* Always wait for a grace period before touching the timers below.
+	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
+	 * filters and cleared so->bound in isotp_notify() without waiting
+	 * for in-flight isotp_rcv() callers to finish, so this call must not
+	 * be skipped just because so->bound is already 0 here.
+	 */
+	synchronize_rcu();
+
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
 
 	so->ifindex = 0;

-- 
2.53.0



