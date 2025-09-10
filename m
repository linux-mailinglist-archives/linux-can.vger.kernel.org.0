Return-Path: <linux-can+bounces-4606-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D8B50DB1
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFF8544E49
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC16308F1D;
	Wed, 10 Sep 2025 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQG3FkIo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A28308F17;
	Wed, 10 Sep 2025 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484297; cv=none; b=WB/k/veJT+/BnklCpriOEHGsH+Xai6bItj57+A9B2xhoiTJv0/AIJrTxRydFypZTd1+JA+rfruIPPnDfi7ZdjuDIh0LlPYWLNxAnY0Yq3/0qXku5mUBdB6S/kt/4vVhNEUS5lIIoBHpRHM2iTw2AERNpjIlQgxexZiL0P+nNGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484297; c=relaxed/simple;
	bh=z4QfhxHdqa5NwYcif6XX3H+zIEilRUp8AiYG14f4sJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXSjRiXW5G7Yp9faUBUO8V6rsCPxRrMeEIulu7eRW8cjVq7kcvBR6/k5tEwYtExU/q8CL9N2qoQ82G1k10LuNM9ImdeZhvWeZmtmt0oRNquRWHMMDIWrTgArGQk46AprUuXiVTLKvf2mXqggOsD8yPQxMDnaldjd6OLIAxKUI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQG3FkIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0624EC4CEF5;
	Wed, 10 Sep 2025 06:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484297;
	bh=z4QfhxHdqa5NwYcif6XX3H+zIEilRUp8AiYG14f4sJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YQG3FkIoTI8BfxGW/lNrLcAQw0Kbo3Vr2QLOz1vp3+qjVkeHTD+6gk0sjO6FiXKhK
	 vCoZe3qlVS7iKD0WADvkmznsZeV9Z0hcfmqaumc0G5qie4H+Q5XMAVVE/lJ8FBeSI5
	 10Dwx6zvQ59kOJ2g2290cgLXO25yNnUigO/ZD+l+zZGsUZhtcvXEHGPHht88eGB9uR
	 yENiLI9QSvIHyTkkSsUT7nDdheeyU596xuaqm0rVE/zczmdlaUYoIZ9DPCe6rfkDAK
	 5F16OOfXc1T6t4vNXXdQTsTreLQJMcLWs09KeobDpk3OKu9haNHyMZOswpEK2BQgWm
	 RqrfaWkvVX68A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:32 +0900
Subject: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-7-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=z4QfhxHdqa5NwYcif6XX3H+zIEilRUp8AiYG14f4sJo=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRW5GeCkU7nB97l4jYc36/0pwbFKdw7Y4772f5ipYp
 mySeP+go5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwES+/WJkOJi2836Qvajb5QTD
 aa4bZ7ldmK8149edEIvMN/7Xt9140MnIcFuca+KfrBrThst7Ds512fSUd0f+QYGFSmKcmz7tfXV
 BixEA
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
index 274eaab10796b601d565c32f6315727a578970bb..72a82d4e9d6494771320ea035ed6f6098c0e8ce6 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -254,6 +254,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		if ((maskedflags & ctrlstatic) != ctrlstatic)
 			return -EOPNOTSUPP;
 
+		/* If a top dependency flag is provided, reset all its dependencies */
+		if (cm->mask & CAN_CTRLMODE_FD)
+			priv->ctrlmode &= !CAN_CTRLMODE_FD_TDC_MASK;
+
 		/* clear bits to be modified and copy the flag values */
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= maskedflags;
@@ -270,11 +274,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
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


