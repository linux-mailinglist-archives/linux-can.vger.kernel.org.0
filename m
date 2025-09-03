Return-Path: <linux-can+bounces-4435-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202FFB41936
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FF51A88731
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE92ECEA6;
	Wed,  3 Sep 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR7T0d99"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863C2F3623;
	Wed,  3 Sep 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889536; cv=none; b=ijqRm0wgxORT79n2kKvH9eGywlWHue76mmHKbvb01oVjAjlN4lyyuBfwe/tvHUaq0PrmmWRPBKf4QhoZ6JWhmvKdKyKflzxhpvLn7BBpeJhnbpW8kXkk8gW2B8qe+lEapwBIxOSWI5+SHkKK3wTWOsHCaodaklZcmRLWgT85a18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889536; c=relaxed/simple;
	bh=mf9LgqcZWpmP7m5KW3Tj2JV0mHkTZDSnwKCnbyNv7/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnjdKNktD2i2EM5BkFd7B85rIHOIlR7qtIcULhFw65odVss7UMX6FaBhjOWtkJXyZHh+MfNr4nYY91AzKPUOJkJ5TfNESgMq3Qqfslk7ilxrknKu1fxN1qHhhIB86yNzFuzYPBIrVF9oOH4odKU9qzRFiUbghH7qlK0JJXGuS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR7T0d99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69414C4CEF0;
	Wed,  3 Sep 2025 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889533;
	bh=mf9LgqcZWpmP7m5KW3Tj2JV0mHkTZDSnwKCnbyNv7/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tR7T0d99DpfD2KCMGz5z2rMWw9qhcRyUglLgGch6JwD0dBc2tiY4Od4bc2LXvM1lm
	 izOLnvcnl3cayr0h6zxSd23zeVVRcv3RleKmk2lW85bs30UhYHgUt47IZs6l+xTYbi
	 t0ga5s8sPfeVIa6c61pvqE74QBSkN7kR1l612WBw1Q3TF5nawan6GN5a1wm8hNz35u
	 oOTM9TFMlYqaLgChDlEH1LjsuabZknkEghGzCCJojvbX7grgIfUunwZBYedf4XHl0Z
	 0mSMZjyz9SRbtfLypm3/tJT7PvHlCBgAJOIGiAudURiz2eBTqJKWYEf2i6ztXdzGrl
	 fKEzNNXPLtAog==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:08 +0900
Subject: [PATCH 09/21] can: netlink: remove useless check in
 can_tdc_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-9-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=mf9LgqcZWpmP7m5KW3Tj2JV0mHkTZDSnwKCnbyNv7/k=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GLt+Lu87zBEx//sLJs3IJypvq7XbOQN42Fsnfi/KZ
 4p6nGzTUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCI17gz/PRbM1Ol2mbtuhjl7
 /QJF48/ut9avLeounDNjjfyP3iNXTzMytByeo8Hy/nq19QT7fw8Ed3zfcvtvnojdAu7LrC+XtUv
 lMgMA
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
index a7bcb2b0a1c06711601d0bb037c4b998259b5dfd..fcb23df08f7b76f341a298d0bd16ec62e0a98525 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -172,7 +172,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 	int err;
 
-	if (!tdc_const || !can_fd_tdc_is_enabled(priv))
+	if (!tdc_const)
 		return -EOPNOTSUPP;
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,

-- 
2.49.1


