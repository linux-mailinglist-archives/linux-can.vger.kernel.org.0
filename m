Return-Path: <linux-can+bounces-3698-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC8AC5B0F
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8842A1889F6C
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE454202962;
	Tue, 27 May 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QW2xAuMQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="uPPchOG+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2120297B
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375812; cv=pass; b=pcM4m2QEUgMtQvRw6Rs+pJ2bhocs9IZx8ZhpKZ5QNzZVXAbiY0Yz+CVWWzY3jwERCnZySa3aSNObGAPfCwQSjpGSQJgGaTWZiDeivOAAAosi8AiHUm8PfruPT8h2mFFnnBbfmxgnPcdyNg3KG6mxjm+ijHvtWGRXPF0MaWzuEdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375812; c=relaxed/simple;
	bh=vj2csscb+SurYSClc10OEvtAHiI9moLg3YBdP2gX2yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHBJWp/WRRNHi+hyKb60uudS9v7GuLA5curSMmu36w/vqsVbpol/26YpGJP+bJuE7j/t10HgwsT2wLQx3AlWcbrBirkGueDoqfnVn5C0Psdc3afUWADK1UC/fmEGRSBJzVGPIKkKw/A2hamux86CWxZ+DpR1W9jk5pxnL5+YmEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QW2xAuMQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=uPPchOG+; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375802; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MNc3jGpC9G5uzMXrJikwuYsz+KKpqWf0z41jIdizKCPi+JnqxSNrT0Agrx2V4VYRBr
    9z879wgAQKKKmck2xyiYAfv6NerpPNlWHe6j4pYntcRb7+qzLhj+eU1F6SkvjNb6AGkT
    uyVl3kdTYcqggdraMWDW4AIwMtSycKdo4tUYJyvJ2Nj2fcUexVHhVdw0rSj2p4BGSbQ3
    94uFO8cIK+dAVMstKzV+ICcrTiF6Bu6iHXK3yD6jIbeJIQcdsljFd1I/BJO78tDiZLCU
    2aBUm+tGVBqSpopSwuDw7d5qHxdTeCf2lzwW2nH8Xz4pAjNR6n/b7jAolWMYYwQ74mjg
    T4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BcVu39h1EO1Axk0ESTTnkUI5jB7uVPq0FJPjTf8PAnw=;
    b=gqhPHuxn3r3Gx9kgTgkM0cooL/g3HEOL86tPbx2dV8pTuCAKbjZ3LTJaCtmv0WWUjf
    3Fqoht164ywm8FsqmaH2hn92x6/x0TY49rVMxla3dVOnTQlUlJPQEBIUuXgI606uXlqP
    BsPVJuLEnPu1CwdT0VV6Wh3RJ0aafL8WfECQxtGyuGqKZ+xwPUbRQnkdPOdMH8LU/4LT
    x3Hixe1/ypG8tnT+Pi8Yfa/zhOwj10WGsOhaCpkUUFIOocJ2Jc3Q+sAYZApIVfIK7ihD
    92Mflm/t/J7dANkxe9Ig5Kq7bv1S8brn/j+YLjD0cL+pCuywQA6QqeFZUM6NYDyz7gRy
    c7vA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BcVu39h1EO1Axk0ESTTnkUI5jB7uVPq0FJPjTf8PAnw=;
    b=QW2xAuMQS+W7k6jnM0xo4/w0kHgRHVZkDGnm7gRQ1IIbaK1sMuR9Y+9aufEEFVh8a3
    SOlodVLx+RNAu5bbpbNir3xsEjSdKLhFQ+80pZ0Qli7shDZS74toJtgvszQc6CqCYGqP
    Rqiw6aWTSntHrYyUFyvHwQCRrqdeReYlrsFTV20ackYIrbQKqbA7usGXtNfqQ3hzhzDr
    e7n0vCU2ksYsLo5bUbeUyyoNNtSrLIgDbiwmZx16JYc1eOQhDhUTjN9iG9cWZxjrwzNE
    jHZFwxxmvwsUhMe0mTtwjhXQG9rs9BISKGJDHZNUi0Ovu1S9jt952jd6lX3dXdxst2JH
    u9jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BcVu39h1EO1Axk0ESTTnkUI5jB7uVPq0FJPjTf8PAnw=;
    b=uPPchOG+VGjXKbJCfB+fd7S+eTkCb3NfzynhZQBoNT803uebNdk/uRnWIduqXWk/0o
    aojZo6WKZnN0mYXQe+Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJugiW7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:42 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 05/11] can: netlink: can_changelink(): rename tdc_mask into fd_tdc_flag_provided
Date: Tue, 27 May 2025 21:56:19 +0200
Message-ID: <20250527195625.65252-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195625.65252-1-socketcan@hartkopp.net>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The only purpose of the tdc_mask variable is to check whether or not
any tdc flags (CAN_CTRLMODE_TDC_{AUTO,MANUAL}) were provided. At this
point, the actual value of the flags do no matter any more because
these can be deduced from some other information.

Rename the tdc_mask variable into fd_tdc_flag_provided to make this
more explicit. Note that the fd_ prefix is added in preparation of the
introduction of CAN XL.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 16b0f326c143..13826e8a707b 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -187,11 +187,11 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	u32 tdc_mask = 0;
+	bool fd_tdc_flag_provided = false;
 	int err;
 
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
@@ -232,15 +232,15 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			       sizeof(priv->fd.data_bittiming));
 			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
-		tdc_mask = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
+		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
-		if (tdc_mask)
+		if (fd_tdc_flag_provided)
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;
@@ -340,11 +340,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 						 extack);
 			if (err) {
 				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
 			}
-		} else if (!tdc_mask) {
+		} else if (!fd_tdc_flag_provided) {
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
 			 */
 			can_calc_tdco(&priv->fd.tdc, priv->fd.tdc_const, &dbt,
 				      &priv->ctrlmode, priv->ctrlmode_supported);
-- 
2.47.2


