Return-Path: <linux-can+bounces-4843-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F28B94720
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52D494E1076
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1453311581;
	Tue, 23 Sep 2025 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQNpQZ3R"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952D3101A3;
	Tue, 23 Sep 2025 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606061; cv=none; b=aQJsjYeb9HIOCkl6eNwANmc/6+WoUwpNga8cheInxCfipf5if0S96CwfzWf1wvsVL1eIPMwlgrdSZzjIbBAn0/O6dxLTzipLwXru6x/KLsPsVnplV3xbZZzzFlFOHlrH1LLA4MXez0X5IJ7bN5IOCbor8rte52sJnnhNZ8ByEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606061; c=relaxed/simple;
	bh=o4MugYdXfmhUPXOXY4Q6rh0kdu4L448448o6JZzxGa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDcfYGvQb+Ug2gaAV/2xd0B9W90f5S3u2pDs+va77FEcDFKLim+BcimrIHntGTFH2vj/a0JvJriXscj3I8VQTBKjGXV2tWg3nOmNAhoOFpZEjHecRELupyEUtbQS7REh6WHBpAYEwb6o8tykFOF3qqr5Q2wMEgegDhp0AmtVd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQNpQZ3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5259C4CEF5;
	Tue, 23 Sep 2025 05:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606061;
	bh=o4MugYdXfmhUPXOXY4Q6rh0kdu4L448448o6JZzxGa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sQNpQZ3RpQ2xF7qOpoBGN0YpkODh6rp4dhTZcL1TbLShnr3wgMfKfyGPMy5405UXu
	 /d0CBurJ+4xj5/HNrlYKZLpdh+TrKXoWBFTAyCXFuKLYuAoas2A7fw2Rebdmnw4GbO
	 GJc93j7NcmVoJ6+pp1KMHno6dWj/etxN1Iiqr6LwunpQLOJ/4NgEGOARu4IG3O/XXB
	 iA8OOfdh/pitgfX3aXYZfkEflpFucZ84ILO3Oj0Wi3B98df+/WW5lZ6qXtNZyrXrAK
	 sU2oFgK52YQ9VpKJxLWWzO73GhyBhUFelFuhDx2uVFB3vEHgrYg6l06guTNxlHJf0C
	 UKuSW5G4djHXw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:44 +0900
Subject: [PATCH v3 09/20] can: netlink: make can_tdc_changelink() FD
 agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-9-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=o4MugYdXfmhUPXOXY4Q6rh0kdu4L448448o6JZzxGa4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjPYyve4pCK1szLM0SV5zcfW1Ju4OK98438krTS/vY
 F5kHqXRUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCIZ8xj+aUxZMXm91Ooa4+1p
 DWdL31Yp3JCurZQ6wir0TPDllL57uxgZ/iewsard25LipxPtGfRqU4KZeLy44h/rzYYlW47dKZ3
 MBwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_tdc_changelink() needs to access can_priv->fd making it
specific to CAN FD. Change the function parameter from struct can_priv
to struct data_bittiming_params. This way, the function becomes CAN FD
agnostic and can be reused later on for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 17ed52d238e3a17e946116a94c7c5f503e184c3d..abff7b84fdce9641e1a5338ec6cef992774b0ec0 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -172,12 +172,13 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
+static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
+			      const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_tdc tdc = { 0 };
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 	int err;
 
 	if (!tdc_const)
@@ -215,7 +216,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 		tdc.tdcf = tdcf;
 	}
 
-	priv->fd.tdc = tdc;
+	dbt_params->tdc = tdc;
 
 	return 0;
 }
@@ -382,8 +383,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		if (data[IFLA_CAN_TDC]) {
 			/* TDC parameters are provided: use them */
-			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
-						 extack);
+			err = can_tdc_changelink(&priv->fd,
+						 data[IFLA_CAN_TDC], extack);
 			if (err) {
 				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;

-- 
2.49.1


