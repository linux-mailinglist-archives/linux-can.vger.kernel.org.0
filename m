Return-Path: <linux-can+bounces-4841-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2FB9471A
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2491779E8
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527830FF1E;
	Tue, 23 Sep 2025 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loizxqwO"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F230FF10;
	Tue, 23 Sep 2025 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606058; cv=none; b=lwImWc/CwJc9uXRbdh80z3n/SUCM1GuPafyVSP/QfMKE8I37TH1fkLsZRBS6Yt6XgonUFkQ0DLxLIz9GO6pEGJuXj0xQqT+ep02AXEmpDz1xVdxIO55ufh6JfrNEKetiBJYDKBYKRIEie0u4jlMukleVC/DEGTp2YG0YIDTiTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606058; c=relaxed/simple;
	bh=M9/FIIXWlcfUEEFfRYD4MlOKBHufakUc+q8CDcjTqY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLn7BQasg4Vuqjrhqhk+4DOIsFuCG7OLZiCWFRRrru0t7JjNTJbIflWa1t7LYn7Eu/881smw9B85jiLcte6qCptSrkfjo7Wmkug1X51Bk4W2SBAQrUSlKyumRPb13iYdctzlMl+RfMc5/3e1ttOudgoUfaDDcimK0+dQgKL7k6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loizxqwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BE2C116B1;
	Tue, 23 Sep 2025 05:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606057;
	bh=M9/FIIXWlcfUEEFfRYD4MlOKBHufakUc+q8CDcjTqY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=loizxqwOOF3dEH/RoxEWplvOcLfeU1fD9RXWBV4SRS2Sqdd7Ic5yngUXd50KQvCdP
	 /F9ExcBUmQjDiHdKW8m/2Kzx7mKA3tefD6nuXDB6btEo+O3aMnINVRr9O+w0G2ZKVp
	 OSwn3xagLDy8GwmxrUd41cRdeqFF+lyjmaIqpyr9F06kceMlZ3YxSvHavAQHVQgv9j
	 pxYrSlD82Q8o53fDA8vG+dDINjplJA4udkRAsubvCPWMboPUZ3pI3/QP3ghWw12Nmu
	 SlR5WIpfIMBEbhP/kIF2cU2eHUQQNxzQfDO0oJYoNzl6wCQsZadmxoioa4zvscAp01
	 SUL5w/1ctTA5A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:42 +0900
Subject: [PATCH v3 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-7-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=M9/FIIXWlcfUEEFfRYD4MlOKBHufakUc+q8CDcjTqY0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjHZuT/7+/+evu0L5r9ccfbM+hffz9kmZ+ZOjzYT/+
 QtrRJXt6ChlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRa+GMDIe+6StJHHS8NnNe
 9MLnz28tlNw+4bHetM9Vv6pNWNgcTeQZGXbx+Or+ye/3uMdwPvD6rbcs+3LvzG8IiAmos1/21aH
 sBxcA
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


