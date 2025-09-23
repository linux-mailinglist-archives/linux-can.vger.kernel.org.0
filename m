Return-Path: <linux-can+bounces-4842-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24EB9471D
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7AF3BF01E
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199523101DF;
	Tue, 23 Sep 2025 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCbUY1m1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF713101D2;
	Tue, 23 Sep 2025 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606060; cv=none; b=DgRScIQgfgKE95X3uy/MXAHb5+0V65UQ2vLEmTYvluIhaiWcpHh5zXkRGTjHqNJ0xvaulrzayOoB8KSams0PzoPFH4Vvy2Jg4lKo5AlmF+4+yIcGfYNJ61vrBQmcLIJCZ7BJADprJ41zdpG/+IzBJSzAkls5qrDqVJIgFxf66QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606060; c=relaxed/simple;
	bh=WAKm5KoMoYNrq4ugY2CVCp2v6gFNBH2vldJXBcaEOHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=toHqWS+BuYH8YjjA8qm+dwOQke4ozm/MNy3DANHH0CRPFkBtVjkLySoAtnvl090wmhL3VcZ5X1f78sVCJuZyoHxuA9HQ0NFKAczo6TNLScuz4EYKjNLAyOPRZaVfO0UgCVVFOrNoldsj4yxdUhTsXFAH9nNZtiS9Fs1fUXhotCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCbUY1m1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4347AC116B1;
	Tue, 23 Sep 2025 05:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606059;
	bh=WAKm5KoMoYNrq4ugY2CVCp2v6gFNBH2vldJXBcaEOHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pCbUY1m1e71Lfb2EDyxWEb5Rz0OoqkhnE+2v0KsyOtnRD62JOjJG68LEvaV1OkDhk
	 OuLb3t5BA1rPWZ1hRiav4+eqtIakr+6Jhh1keZKtJxIuAmumgaCrC/GQkL8YRyre02
	 PzOzMBl142AN1yKoUEj4HJEF6EUIzDYJvKlOdiLMwtvF9MTXTUnU7vhTsArZzIwLvO
	 +GAUUEbehp4LGGNuzJ3vFdXQl7ahcl4m5H/F/CrR1D4pQtZKYMDuzdZHkTopg6eXeC
	 oEKJwLgTqcCRdqtf7hIvO+VYvQN806Tdt0JBH5Ynxiqy6nnl1VG2imdcMe0wbCYRGs
	 kZZET+sA4gwEg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:43 +0900
Subject: [PATCH v3 08/20] can: netlink: remove useless check in
 can_tdc_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-8-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=WAKm5KoMoYNrq4ugY2CVCp2v6gFNBH2vldJXBcaEOHI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjHbf7DcVt2WacP3CoRna9eV2nrUr9BwnbvIz8Lpbd
 dP6ildRRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInw2zP8M/gb7DVRd5vFjJc2
 gav82DOvClxdZfJE7vHJb4xPzQ/J+DH8s76WzH5c8VzmpQ19wRkSHu+t1+/5pKSutPLnxBvP5rd
 +4gYA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_tdc_changelink() return -EOPNOTSUPP under this condition:

  !tdc_const || !can_fd_tdc_is_enabled(priv)

But this function is only called if the data[IFLA_CAN_TDC] parameters
are provided. At this point, can_validate_tdc() already checked that
either of the tdc auto or tdc manual control modes were provided, that
is to say, can_fd_tdc_is_enabled(priv) must be true.

Because the right hand operand of this condition is always true,
remove it.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index c212c7ff26cd3367d2014db99de7534077a1a841..17ed52d238e3a17e946116a94c7c5f503e184c3d 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -180,7 +180,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 	int err;
 
-	if (!tdc_const || !can_fd_tdc_is_enabled(priv))
+	if (!tdc_const)
 		return -EOPNOTSUPP;
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,

-- 
2.49.1


