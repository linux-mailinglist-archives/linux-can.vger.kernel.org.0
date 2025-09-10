Return-Path: <linux-can+bounces-4607-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B21B50DB2
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE3B544E64
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A173093A5;
	Wed, 10 Sep 2025 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmOVOjNt"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AF3090F7;
	Wed, 10 Sep 2025 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484299; cv=none; b=Wz71qpyu4atd68mXDldE32Atm46xYwBahC0+lv4k94Pg/0021aHhAZOOf2kPAOPeDTFAIj69/KPNJ205ffDxZeNSWnsbHd6R1U3PZP1guXcyDJTSIuXSWCFOGyCGuu7IP9mCsoVRrCcGnoV7EqSsSwD2gHvj+MRA4DvvPD8jFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484299; c=relaxed/simple;
	bh=MKkviT77erw3U8yGa3mJeotKQaYV/lNzirqrwQvIByY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4nUyzUCRfCkmxBkus0qxUdQbkMDjTkRXRyKlWnTXHGO8PhbJYOAVsUbWVR6F0yjFEmY2Z6zlcSVnmyLCG1xo2ebSCmPLi4FpRM0HCaD7xpB0A2WTA9W0f+2tb36S6E3+QByfdiLUwzXRFyv3I18IuhmibMeu3Xr35922CGkn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmOVOjNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D39CC4CEF0;
	Wed, 10 Sep 2025 06:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484298;
	bh=MKkviT77erw3U8yGa3mJeotKQaYV/lNzirqrwQvIByY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rmOVOjNtR2axcsTOxJRxaIWVOFHivDrxWX47QDboYRHyFnilXIVKxo5K0+V94Sest
	 +7Z4vb7vnuWwQzWyZlHpDJvbBdlmRnJXiEBa7FwBJuuB65zr9Crkg17SwWOuOv2zll
	 9sPs4RGMvk1l+ho8PaE2GrtoW4g4nBfT2xVItB1rBxXCM0fiKHiNxGPmrx06rImRFX
	 1zAbFXu4nZnSXWDZgR1gLDcxYrA/9aTkYGK4okq1AsedQq+8bbAs5gYxWKP2IYUKTj
	 gQQmIiMUc/Ek4aZb+PJy7H1coCUWI9wfWQRmc2H/RW5zjITmnkRlcqaKmjjVQZGbUy
	 NcV7NY/mmxIvA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:33 +0900
Subject: [PATCH v2 08/20] can: netlink: remove useless check in
 can_tdc_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-8-f128d4083721@kernel.org>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
In-Reply-To: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=MKkviT77erw3U8yGa3mJeotKQaYV/lNzirqrwQvIByY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRW4/5jyZcOrBvOtRXNIOycfUXANP3v01Y59a+PbFB
 SbP9qRmdpSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZhIcjbDL+bI/BfuD8wW/7D+
 qavcLmvKnrhM/cLlR1ZOwpWb9Gf66DD8L68TYLvc4HKk9MH+i6a7Nxe/v3ulVcZU7eIFzhcHFH8
 a8AAA
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
index 72a82d4e9d6494771320ea035ed6f6098c0e8ce6..33a6621bd7a916583802fa12e0bd971c89560924 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -179,7 +179,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 	int err;
 
-	if (!tdc_const || !can_fd_tdc_is_enabled(priv))
+	if (!tdc_const)
 		return -EOPNOTSUPP;
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,

-- 
2.49.1


