Return-Path: <linux-can+bounces-4850-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B9B9474D
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7120E161DEE
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512A31771E;
	Tue, 23 Sep 2025 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCSdOQX8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EE317706;
	Tue, 23 Sep 2025 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606072; cv=none; b=CoqcPWHrn/nQbXF8N8Ab9O+bznEoKSJsvym+g3vCi4Uzwdkgo8qyWKW/tPsL4XH2dZIMx5hpgjrPql2dLDtjBDonX0IUHXkV8l5dEuTmwn6sTssOqmcEVGP6T5lBnS/1vGUxr8Y+tVtTb0mLfJXbH7ElnRsqrNhccoZgiri3UV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606072; c=relaxed/simple;
	bh=5sfUrtoOZp4BjKuJF6RyWHTN4aQhqobLwkByaxTv0as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7lLRGRwNewBQNAJLFkEffs3oFn/m6+1LZU3ngUprDq9wRN2tYS9d8HTAcpReXIibXas0UuZiOtW9JNZstFvDEQ7u6Ugtjs85ofLFKHpzxbXJQq1DJi3x7p2dei62YGU5wCiAcDkdId8tdH1Vc4RJj+6oiqlnguzyqvXExJC1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCSdOQX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF785C4CEF5;
	Tue, 23 Sep 2025 05:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606071;
	bh=5sfUrtoOZp4BjKuJF6RyWHTN4aQhqobLwkByaxTv0as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JCSdOQX8usrmtB4Pih31u0b11Sb60n2jbtEj821+pABStUcC3DbxU81nUwzH6/8Sz
	 /nGwh5zBf2BwZUCjTaoe6OMItvefcPUHjXO49g2AofbpVz336EpA23PKEnEoRlLYSl
	 nNq6/r9vlhkCKily7SAJIubvpujMqFk3Do83QVBlhx6dEn7Yy8fBICrBqss+h/LRx7
	 udP/DpxxH0jKFCfWHSl2Gsw8Oh+Rlr3Nupbh0auN3tyWIVp8qRE5cO35YV+G2dZkvm
	 TsjyO4Zz1DuujisjAZU79qqiAOZZI3s51zSHYY0gUaPyXMZuSzzABAuacrlpmTjEW3
	 pehrdBnZhsdQQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:51 +0900
Subject: [PATCH v3 16/20] can: netlink: add can_bitrate_const_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-16-87a7684333f3@kernel.org>
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=5sfUrtoOZp4BjKuJF6RyWHTN4aQhqobLwkByaxTv0as=;
 b=kA0DAAoW0WQ+QNd/fbMByyZiAGjSMtCiPyLcn2/4ja7tfeBRCy6meHU3j0aZG5hXk5Z3bl7BA
 4h1BAAWCgAdFiEEpncJCyCIcUtWwv050WQ+QNd/fbMFAmjSMtAACgkQ0WQ+QNd/fbOlTQEA2JDE
 C/YAPqTqCq6xeAhN28zf+Y+gUZ7bDaoJeqAfK/8BAO8TcRrVUbVuuhO86JCxFAfMf5MFyDrvX3Q
 U6XFxy+YD
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add can_bitrate_const_fill_info() to factorise the logic when filling
the bitrate constant information for Classical CAN and CAN FD. This
function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index fa922a61f75afd18c587f144b6bb2a17be7f26da..9794f283ed588e37fbc9a189cb54c6965960d436 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -576,6 +576,15 @@ static int can_bittiming_const_fill_info(struct sk_buff *skb,
 			sizeof(*bittiming_const), bittiming_const);
 }
 
+static int can_bitrate_const_fill_info(struct sk_buff *skb,
+				       int ifla_can_bitrate_const,
+				       const u32 *bitrate_const, unsigned int cnt)
+{
+	return bitrate_const &&
+		nla_put(skb, ifla_can_bitrate_const,
+			sizeof(*bitrate_const) * cnt, bitrate_const);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -686,17 +695,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		      priv->termination_const_cnt,
 		      priv->termination_const))) ||
 
-	    (priv->bitrate_const &&
-	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
-		     sizeof(*priv->bitrate_const) *
-		     priv->bitrate_const_cnt,
-		     priv->bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_BITRATE_CONST,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt) ||
 
-	    (priv->fd.data_bitrate_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
-		     sizeof(*priv->fd.data_bitrate_const) *
-		     priv->fd.data_bitrate_const_cnt,
-		     priv->fd.data_bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_DATA_BITRATE_CONST,
+					priv->fd.data_bitrate_const,
+					priv->fd.data_bitrate_const_cnt) ||
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),

-- 
2.49.1


