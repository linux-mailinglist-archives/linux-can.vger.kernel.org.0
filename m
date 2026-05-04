Return-Path: <linux-can+bounces-7480-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOOULKqD+Gn0wAIAu9opvQ
	(envelope-from <linux-can+bounces-7480-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 13:31:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7854BC645
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB13630066BC
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7D3AA1AE;
	Mon,  4 May 2026 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jiMdZRTF";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6vY1o7Bb"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9FC3BE642
	for <linux-can@vger.kernel.org>; Mon,  4 May 2026 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894311; cv=pass; b=oJN7KTjpaf18B9uY/zjjllodDDTMt3mMFAePCQbk3FYF29mHFiCWLrs9kq73eUweP/cjldrjmJlkwpIKKACOiK/y+ceZQlmqWYRyvu/rmM5TXOROGuaVwNpVWk+hZ8rH6zXm5FRCHVQnrC37XB8fsjErHKdqXGb1yTzczr5aK2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894311; c=relaxed/simple;
	bh=0O8HRr7BxKAVnH93FoKb/sB6uGn+feNBx5aH//L+8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJJ0m5i+LydhZEDPyRzguJK27lfOIYM0OT/6ZpfwY7/NLp0lLr7qBSP3e84yf5zkiQen4gWScJe8DgdVbmNci38wi2bBd7W8lhJ5hg3I4vpvQhHsX35wS11+yENNJZylV3Ugx9g3YRNJofvq1QQTqkaB26evx8YxpVR8k1q26iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jiMdZRTF; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6vY1o7Bb; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1777893586; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dNGozqpRDVPzWhJBymHE6tMvhT3kmmg+aAVB0yzBgECUQnZyKzeiI0Kh7D9kIiVLtH
    dR7oiudHqz6UoiB5yq3L1OXMjPqD2ueHD1+EAHYLyCb0NzHFGd8Guqcag0U6QEZsuWkY
    FSgr2R58Hzwb1zKmF0mAogfVvvrResyKM5wRqRx4xv1BKtGLPpWqBYP36pd/70jv32vj
    S7QtRIjjU+F3hIzo2Lqz3XmzDp32auZx6hAAgJ/75S0KxBeZF+c1XSbNpTYhG8QjoxZv
    HLbZOOdc9nNHfUja4wOeqa72PkxGigrH6TmIP0/uC1uqxEwwOFdFAIzxNnJtr+E9XfKh
    peqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777893586;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=5AIcaLUibSARsjXRgMx5B8iFLADO55gz1+AKmC+tAUA=;
    b=L1BiJLFp7BiGHIEeUgMgcAN8N0F7jD057nY9EG79H8Os3A3R81E/3sm87ttqp5ZqWW
    CVoL9Mc7VqPsb9qKWMtXiSfmelLYo0LNLSCAydFWHfvW5VYUH0iadsX05kScKy+7WFze
    0kpakEZoerqE06lu+k8+7UQKN9ma9Rtub1HP1nHH4l+pardGv2X4AHsgW6bcAU9Da6T6
    t3hWSnz04pTXh0q8ESVIQn0kIiNtm2OhuZLaVafj27W8cfOxGCUJ6v6y8QgcD3VBPMEe
    hXGi5aBe434P0lbPGLNVDU9SU9xp/5lI9uFC2vl3x/r5xU+FcI45hK8NN+DxLjkr3eVA
    YONw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777893586;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=5AIcaLUibSARsjXRgMx5B8iFLADO55gz1+AKmC+tAUA=;
    b=jiMdZRTF4TNPcJwowsuAGcVjWCUHt8ZI6u52gmTDsBIIvvUSd7KbZWtKpSQPM5kLa4
    PbKmSHLLnXsOLzaaSo0wuNYqDzscX750HVwqK60sc8/OO9Y6HM4IBCoFuat/6zSRHsRY
    LXSYgDmZidgu+O8xY+hnzGLexgQa1mTXb3VCDZw8ebfHQFl0DdH2MUNKE7NhgubKeg3P
    npwpGWqtjmUR7WjjGoTINc79C7bvJQxihiss+9zPOmGBgHEn82jWHJN/a054TVPGXUkE
    2voY1kOpmt0EhXnqMUYc1WTMz5QOSvlJO2vCCyo7aG9YrluQRy/5uQta3ChkChqr7y/1
    nVyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777893586;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=5AIcaLUibSARsjXRgMx5B8iFLADO55gz1+AKmC+tAUA=;
    b=6vY1o7BbguxWlmQrM8LfhndDCIG/C6xnPLu/OK0A2P3dUEvUZFmEj7f+ALKxXxZDsu
    i8sq0n32Q8/jp881ZPBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d244BJkMyr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 4 May 2026 13:19:46 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Eulgyu Kim <eulgyukim@snu.ac.kr>
Subject: [PATCH] can: raw: add locking for raw flags bitfield
Date: Mon,  4 May 2026 13:19:28 +0200
Message-ID: <20260504111928.41856-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 4D7854BC645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7480-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
Tested-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 66 +++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index a26942e78e68..82d9c0499c95 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -560,12 +560,12 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 	addr->can_ifindex = ro->ifindex;
 
 	return RAW_MIN_NAMELEN;
 }
 
-static int raw_setsockopt(struct socket *sock, int level, int optname,
-			  sockptr_t optval, unsigned int optlen)
+static int raw_setsockopt_locked(struct socket *sock, int optname,
+				 sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
 	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
 	struct can_filter sfilter;         /* single filter */
@@ -573,13 +573,10 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	can_err_mask_t err_mask = 0;
 	int count = 0;
 	int flag;
 	int err = 0;
 
-	if (level != SOL_CAN_RAW)
-		return -EINVAL;
-
 	switch (optname) {
 	case CAN_RAW_FILTER:
 		if (optlen % sizeof(struct can_filter) != 0)
 			return -EINVAL;
 
@@ -596,21 +593,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		} else if (count == 1) {
 			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
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
 			/* (try to) register the new filters */
 			if (count == 1)
@@ -620,11 +611,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 				err = raw_enable_filters(sock_net(sk), dev, sk,
 							 filter, count);
 			if (err) {
 				if (count > 1)
 					kfree(filter);
-				goto out_fil;
+				return err;
 			}
 
 			/* remove old filter registrations */
 			raw_disable_filters(sock_net(sk), dev, sk, ro->filter,
 					    ro->count);
@@ -640,15 +631,10 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			ro->dfilter = sfilter;
 			filter = &ro->dfilter;
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
 		if (optlen != sizeof(err_mask))
 			return -EINVAL;
@@ -656,42 +642,30 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		if (copy_from_sockptr(&err_mask, optval, optlen))
 			return -EFAULT;
 
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
 			/* (try to) register the new err_mask */
 			err = raw_enable_errfilter(sock_net(sk), dev, sk,
 						   err_mask);
 
 			if (err)
-				goto out_err;
+				return err;
 
 			/* remove old err_mask registration */
 			raw_disable_errfilter(sock_net(sk), dev, sk,
 					      ro->err_mask);
 		}
 
 		/* link new err_mask to the socket */
 		ro->err_mask = err_mask;
-
- out_err:
-		release_sock(sk);
-		rtnl_unlock();
-
 		break;
 
 	case CAN_RAW_LOOPBACK:
 		if (optlen != sizeof(flag))
 			return -EINVAL;
@@ -767,10 +741,30 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		return -ENOPROTOOPT;
 	}
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
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
-- 
2.53.0


