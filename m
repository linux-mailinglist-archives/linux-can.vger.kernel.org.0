Return-Path: <linux-can+bounces-4868-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022EB94A4C
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B59189FC30
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B9D3126C2;
	Tue, 23 Sep 2025 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEjQRbbt"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D93126BE;
	Tue, 23 Sep 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610797; cv=none; b=dG8wREEa0UjZJ73jMVmgvwLjrFA/1Sf9qcsp50lXe4FSi2an+p4zccUWnnsCa97tAoEfwzFbGgMKFFlXT+iGq8koD3lAF6baWYWB7nHzJpWY840AqpL9rMp+KRoDcTFNfjjgsTjal6meMircwYODU8WuKGAXsSODXEHHjT0DLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610797; c=relaxed/simple;
	bh=M9/FIIXWlcfUEEFfRYD4MlOKBHufakUc+q8CDcjTqY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZ64Urm0S6VloRTgyAOyR5aWp1fhGSBgg8wpvNkKDxlJ6OXRciJ+4yXd3Ck6284pOfo4Y4OpzlNyQSvH4Xg/TMufaS3is7oSc+3My1fyhQWRA3tySB4jLhfZ6BT8GWOvN7cDaeGqZU1U9/JdDbuOplTZgUuZwk8K1hbiDVI5v/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEjQRbbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865F3C4CEF5;
	Tue, 23 Sep 2025 06:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610796;
	bh=M9/FIIXWlcfUEEFfRYD4MlOKBHufakUc+q8CDcjTqY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WEjQRbbtowBkXFX59CVu5l1G86KjwL/KuUp6l5h0ayVcFZf81GUQ9ZAIJ9G0WJYgK
	 SsIWC04ZHgukFXelnLjd9Fzf+EqC3VyehjW1HAxFXrRWzlHDTCs2lhX34iKc80Iyv/
	 tcIqo5nNfVItWzdP+jPB9tuX4SgEblVDuo10W0w+4DL7oYL0erjH16cJl6JTt1w9nO
	 EqVy2QkEY5YsdN8t3XYfkEjW46JarxyDIg2J8usG+S34fQoFAICTtACLf0yxSsGypG
	 pLJh0r46a4+QbanfYLxLTVaWu7UT3Y97OpIeQMTiuUnm3SXbjwd6OWH1E+xqlprv/d
	 Zqx4/xDOAg6zA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:32 +0900
Subject: [PATCH v4 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-7-e720d28f66fe@kernel.org>
References: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=M9/FIIXWlcfUEEFfRYD4MlOKBHufakUc+q8CDcjTqY0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXM1UN2wy9vOuvPggPqpuzSa3V0//qJzf4Bd7Tsqn2
 F8k7F51RykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIlk9zP8rwuNnvngScHJLzWv
 nFcEeZ95l6pXzz83c4M2z3ITZv1TvAz/rGzMi5O8gytyvv5+euvoh3kxX3JsLu3mnCjwivVV/4f
 fHAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

CAN_CTRLMODE_TDC_AUTO and CAN_CTRLMODE_TDC_MANUAL are mutually
exclusive. This means that whenever the user switches from auto to
manual mode (or vice versa), the other flag which was set previously
needs to be cleared.

Currently, this is handled with a masking operation. It can be done in
a simpler manner by clearing any of the previous TDC flags before
copying netlink attributes. The code becomes easier to understand and
will make it easier to add the new upcoming CAN XL flags which will
have a similar reset logic as the current TDC flags.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v2 -> v3:

  - Fix a bug in the masking. Replace

	priv->ctrlmode &= !CAN_CTRLMODE_FD_TDC_MASK;

    by

	priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
---
 drivers/net/can/dev/netlink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 549a2247d847dd26c8cb8c76ecb609256f549eb2..c212c7ff26cd3367d2014db99de7534077a1a841 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -255,6 +255,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		if ((maskedflags & ctrlstatic) != ctrlstatic)
 			return -EOPNOTSUPP;
 
+		/* If a top dependency flag is provided, reset all its dependencies */
+		if (cm->mask & CAN_CTRLMODE_FD)
+			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+
 		/* clear bits to be modified and copy the flag values */
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= maskedflags;
@@ -270,11 +274,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		can_set_default_mtu(dev);
 
 		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
-		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
-		 * exclusive: make sure to turn the other one off
-		 */
-		if (fd_tdc_flag_provided)
-			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {

-- 
2.49.1


