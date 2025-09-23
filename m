Return-Path: <linux-can+bounces-4869-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3771B94A4F
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05FF18866A0
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B71312819;
	Tue, 23 Sep 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHSf/qMm"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A63126DA;
	Tue, 23 Sep 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610798; cv=none; b=D+u80bRnzZZQPd/I8IFNpyuFBZgwpVzhKiI7OtEJxIPTgXmy9/WYGrCzswTur+LZ4Y840lpb6soNVigGeQxOJN+aUUPoaU0jNB1/m19GmhQdRnpClSb07WsKvWuUDJ2xqD94BEoQcahYYI8R0Bz6d3nxR1EgkrIAVcOhtlU8edU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610798; c=relaxed/simple;
	bh=WAKm5KoMoYNrq4ugY2CVCp2v6gFNBH2vldJXBcaEOHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEIrUUizkEZnNkONTIQ701+ijJsXJf4E53XKjANhXCVNG1DxuMitURn4yQFkRWtwqpA6glLcGYQrpT9E0N9GXT5T307LaMUZsljlUXA66lL/APYkMCidpPwMBaOj62gNET76ecV95Vx32t6R4kBas6e8PUjB2ZnbqkhY3AbpwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHSf/qMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F243C116D0;
	Tue, 23 Sep 2025 06:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610798;
	bh=WAKm5KoMoYNrq4ugY2CVCp2v6gFNBH2vldJXBcaEOHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rHSf/qMm5h41BT/6myD+dUwEO1YA1jCT6gewmoKi7T0GdlxPJaOAZT+ZohreJF3Zy
	 ZmDo0CQTgaMl/XYGYNGLx8xkHScNy0qII311FZgkEh1Y+ENHQ/OjsXkdy6hzIu5A3x
	 mYj1m+ZUTJjvi3IHEXTdephcYdvtwG1pU/WasCwYp6zjGFPFufGYlveByJNrifLzhh
	 FhBIkrgeTw2f3fffTvbLiFrJbTTKaM+HEflxOEeJ2ic7l/xy/MuWqcNoQq016365h8
	 WqV23BZtsXeQBxGhrcR28ofX4IQvxTx7eLI7zx2H9SeIsnCx+KkNcGyZApfYLtoQ6r
	 BhG36OEY4p2og==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:33 +0900
Subject: [PATCH v4 08/20] can: netlink: remove useless check in
 can_tdc_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-8-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=WAKm5KoMoYNrq4ugY2CVCp2v6gFNBH2vldJXBcaEOHI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXC1uMD15vykgNe/0FL+1d7iT7Ti12u/nJjMuu77qz
 fVlLeJ6HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACbykIORoWW/27YVt1///JIQ
 nT07jmnT9Elp7ga32Fa5m73nEujIa2H4ZyCUkPzwY2XliSiP+TZzZ+V+X6CsFKxlnVq9MPhU3Fo
 1fgA=
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


