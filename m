Return-Path: <linux-can+bounces-4434-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8CAB41937
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B81681C6D
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888192F360D;
	Wed,  3 Sep 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpw3SFX5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F232F360A;
	Wed,  3 Sep 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889535; cv=none; b=NoIpI3eHExsHf82/mWZNWT95Kc9Vlqk+jO1+Lk6CqtGhy/MYdz4NKMrmc7V0+RcI9SIMqNU6rkKtMbIXVeMjnAFUFaN9Ql/PuFznsx1TilI51rDV2DqtEvBttak2kuXB94/gFUo3qwS4Eotb9V1B5a7Z9GeV1EuOJ6YT3T4t0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889535; c=relaxed/simple;
	bh=j+XT6RHjpBO0eBj0mjkVANxUKisnC4Q+X3d22r45gmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7PegQazSRxrhtKzdtJgGQnCSX8hP+Vqi0OeJl5GCMMpCSBvTnRfGlWl2Rgk7oi2t1YHqsIlbCItCn57CDb50q/Qhi3Vcmj4Uu/39CR5vwh7KfDG8kIIKgIvXkJDb0orID51YrtcNb+NtJVuaP9zdtE/JYfhze7nuVH0sgnr+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpw3SFX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0477BC4CEF5;
	Wed,  3 Sep 2025 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889535;
	bh=j+XT6RHjpBO0eBj0mjkVANxUKisnC4Q+X3d22r45gmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qpw3SFX5R4Fv6VHFgzmMdwQZQ5b+NoippbZJOkBTCGeSco7ifF6H8TR0MBFcfdxTk
	 H7nvyeKr/erkIFMjWaxIotlZhx8UhycCdRA55xcCKXeza5WGLB2qyv1XjFo2tMalTl
	 8ufSOkmzKfjq7Re/tRaDjOIA7TOAukNGoBfdjnsDL1fZ7eg7ta7zUsdv55d0nU7q47
	 k+4nhyaOL+bhCykk7zGrdGMwkHNQBhb4erCOqWUe2jDCcXoPWIjFvuUB5wnMUkPYQN
	 5KNJgtKZjMS6vhZI7YZhhB8umyqlPKPXYOPVXiS3nSh1utn/4YC3QqDn9TJPWcJn2v
	 XArH/zrcyN/og==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:09 +0900
Subject: [PATCH 10/21] can: netlink: make can_tdc_changelink() FD agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-10-904bd6037cd9@kernel.org>
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
In-Reply-To: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=j+XT6RHjpBO0eBj0mjkVANxUKisnC4Q+X3d22r45gmA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GHsN6toPmlrFfjgQOLdrobyNU9Y/HvVLUzeba8Utc
 3VYbzW5o5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwEQkGhkZFuvPfrKndJv394au
 XQ3lHrmLrq/jEPx9N2L+MtFH09VOWzMyTGa34tgUdTFK/HZDiXDmjTVm/1d9d/ixaMmZRbv9Zx0
 t4QQA
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
index fcb23df08f7b76f341a298d0bd16ec62e0a98525..1a3389e3880f1c9c57e2e45f4cacc272c260fb07 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -164,12 +164,13 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
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
@@ -207,7 +208,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 		tdc.tdcf = tdcf;
 	}
 
-	priv->fd.tdc = tdc;
+	dbt_params->tdc = tdc;
 
 	return 0;
 }
@@ -375,8 +376,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
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


