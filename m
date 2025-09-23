Return-Path: <linux-can+bounces-4865-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621EBB94A3A
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16CD1885292
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87930F94D;
	Tue, 23 Sep 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBB60qv+"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A7311586;
	Tue, 23 Sep 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610792; cv=none; b=a4emeLXSSiteGxnO8i3X+UfKpCJC1VEfqCRk5RI3RkE77z2I8kLliLVi5iaOXo6yP8vnERuULdfZLGXWELBzYdrOqaQYt5XCYGPeciS/Qdkiv9H1GRQ5m8DErzlR9G/Dymu8YSwl39hu6XAMsBIEgYPVQ6WZdEH1N333KfjgQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610792; c=relaxed/simple;
	bh=YbwnjxfMye/PzcS1THZ1QtGxRafIoeUGUPEkh1iC8L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LW5C2WrNXBmvC0bJpB9gBBMG29PTsFa1GP1bKCMLCUKYPzsGvVxPSuiOgcUmp8CEhGit0uf7sgT1AbqHWjaZG3TKyLgquZi+JMHUEhKuYXoLG04e8tMq4cslJAvnIvGSbXFkAHKRXNFnUpHN6Jr065rdnXAZSrsFrEQ6FAksXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBB60qv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7452C116B1;
	Tue, 23 Sep 2025 06:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610792;
	bh=YbwnjxfMye/PzcS1THZ1QtGxRafIoeUGUPEkh1iC8L0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tBB60qv+uo/+daSANX4YUwMARs93aREqLF1v1USM4r3awAFi4F9Ar49uHhNeWaDkc
	 Af4Zw3zLwZSbtl3YG1VlNrwhtkhKuAqoflNmMQ6j/IDXcEnDzquYAAc85dM7O2b+t/
	 2kuNmVIvgROg0BcNGKEauLaOSzspOeNXyWDcOfthB29ckwLRn43ycKUca+Ib0KGZVP
	 hEnhNeXa9UnMqVYgFvG0nqAY9fn9mwsDFHmKRmRHISSosIjeZldEglC8whi5NcsdAD
	 Mbd7/OGkLRL8amgam2vC0uleTBXJyqYImzkgVEANdIs64PpMBrkAo8U6PIrfk72MLb
	 2teNixUjm/SIQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:29 +0900
Subject: [PATCH v4 04/20] can: netlink: refactor can_validate_bittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-4-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=YbwnjxfMye/PzcS1THZ1QtGxRafIoeUGUPEkh1iC8L0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXPXuqSWyHuHPfcKiJORWsmOZZCvX3btT/glOzkpN/
 vrjsDF3RykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgImUxjAyTLZPXt54pn2F/EHV
 pJWdx/ZNspGt4Dlf/eb6h+Zi/tR76xn+aVV0+Uzl4n55sJKrUPkj/+t3Fuzzd635lyFeZtnAHtj
 MBwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Whenever can_validate_bittiming() is called, it is always preceded by
some boilerplate code which was copy pasted all over the place. Move
that repeated code directly inside can_validate_bittiming().

Finally, the mempcy() is not needed: the nla attributes are four bytes
aligned which is just enough for struct can_bittiming. Add a
static_assert() to document that the alignment is correct and just use
the pointer returned by nla_data() as-is.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v2 -> v3:

  - add a static_assert() to prove that the alignment is correct.
---
 drivers/net/can/dev/netlink.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 248f607e3864ffbda6f0b8daf4e2484179cf9cd5..13555253e789ec6ca9c8c30571c990ad6bfde770 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -36,13 +36,21 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
 };
 
-static int can_validate_bittiming(const struct can_bittiming *bt,
-				  struct netlink_ext_ack *extack)
+static int can_validate_bittiming(struct nlattr *data[],
+				  struct netlink_ext_ack *extack,
+				  int ifla_can_bittiming)
 {
+	struct can_bittiming *bt;
+
+	if (!data[ifla_can_bittiming])
+		return 0;
+
+	static_assert(__alignof__(*bt) <= NLA_ALIGNTO);
+	bt = nla_data(data[ifla_can_bittiming]);
+
 	/* sample point is in one-tenth of a percent */
 	if (bt->sample_point >= 1000) {
 		NL_SET_ERR_MSG(extack, "sample point must be between 0 and 100%");
-
 		return -EINVAL;
 	}
 
@@ -105,14 +113,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
+	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
+	if (err)
+		return err;
 
 	if (is_can_fd) {
 		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
@@ -124,14 +127,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			return -EOPNOTSUPP;
 	}
 
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
+	err = can_validate_bittiming(data, extack, IFLA_CAN_DATA_BITTIMING);
+	if (err)
+		return err;
 
 	return 0;
 }

-- 
2.49.1


