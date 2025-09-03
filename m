Return-Path: <linux-can+bounces-4433-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AE9B41934
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FFA681C21
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B342ECE8F;
	Wed,  3 Sep 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpORcDbk"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07C2F28F4;
	Wed,  3 Sep 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889534; cv=none; b=I1r3dRANggGVZOGOZDW8IxowOGbEfVKuHxOgflVWlSq2WvF8MB72CcoRijobtDd2IvBXMLPS/5mp5vzU+fWBt+pyMNmEl+co7pZxIY9y2hUdE0kmyHuahKnE2QeNZVMp0XrKSRPGzwZ9ENM1fGOar6Ucqz9LpjnQOKzrkeUzzs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889534; c=relaxed/simple;
	bh=GjTV/5L2ZdLVzjt0OPfo1ElfwP2t92QXFhoCAlrxUF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tlLogfglfMXtfqSuR6nUF98LrXxP15FKIe8J2np5C1GnM/oFGFzZgKG6YjjgEphKzL7G0mqwP9OpDyeymoIxa6PyzcsGa7pbdzskkJkVwi6cbX2ka7nM9B4h+ZABIRESC8+HU6wyLAMBWgAVOuxQAHwvpVK1b+DGzV5YRDfTll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpORcDbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED68C4CEF7;
	Wed,  3 Sep 2025 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889532;
	bh=GjTV/5L2ZdLVzjt0OPfo1ElfwP2t92QXFhoCAlrxUF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jpORcDbkOsr7WRIetHr2wjPuAbdwdL/MmrKTgdENHYE9F/Bohw00oteGJ3D0aZymm
	 ePmcBtaND6U9yAoDQTKp51jz4yu//f3p+ggA1h+yWDkFx7YIsrv/2OSqsW1CxfiRgr
	 1npWxcldQv99bihZ0hQIx5th5FQv5ojFh6eFvzwW3Fohoepd/2AWvsjx7tEoPUQgOG
	 /yDtfvRERr8zC2qe3JURL8cDabVmr/JJREUpDwzA0JvyMUxxScfSy5WARSnBthoEsV
	 QRJFuENK2yyviEi+JiLTfLGB1Yhfd4PX1Xu99RzkQ7M0nP7g6EV4lGK6GTHEILCnir
	 K6C/+Xfu2eiRw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:07 +0900
Subject: [PATCH 08/21] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-8-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=GjTV/5L2ZdLVzjt0OPfo1ElfwP2t92QXFhoCAlrxUF4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GDuWu951OPhhWve53pAssYWBNqvNuX9tC1ayefJp+
 r+VQV/EO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEyEn4OR4dv/wNgHMV07njT/
 f6oR9H2Pd9LSvZ/+794UxOrsfuD27xaG/zWvPuzdwftyx271ZZXR36NY4rj99FSK7MuuNQb2P/o
 +ixUA
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
 drivers/net/can/dev/netlink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 6ea629331d20483c5e70567eb1be226a3b09882c..a7bcb2b0a1c06711601d0bb037c4b998259b5dfd 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -247,6 +247,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		if ((maskedflags & ctrlstatic) != ctrlstatic)
 			return -EOPNOTSUPP;
 
+		/* If a top dependency flag is provided, reset all its dependencies */
+		if (cm->mask & CAN_CTRLMODE_FD)
+			priv->ctrlmode &= !CAN_CTRLMODE_FD_TDC_MASK;
+
 		/* clear bits to be modified and copy the flag values */
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= maskedflags;
@@ -263,11 +267,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 
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


