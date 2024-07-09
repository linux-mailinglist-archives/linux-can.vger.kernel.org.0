Return-Path: <linux-can+bounces-955-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F406A92C0A3
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 18:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D1B2722E
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8C1C2DFC;
	Tue,  9 Jul 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC11SiMN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5561A01AE;
	Tue,  9 Jul 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542184; cv=none; b=a7LYLKsfQCaDTW1i4esD+fC0ELt2RBpkS6n4HyLkx8VnJ5vcIf4mdy0qjzp7sM1l1ODiQ/TbZFT5JWL0hi7qG4mjkfTYJS0F6RlK1kM+3imUReN4Slw/lnPFOEaikZP0SHHQ31ptYqiSjB+CBGAgMdgV3e1kP6+3aOuDl/lDf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542184; c=relaxed/simple;
	bh=tdzzJLvvDu0ufaMXnQPf31T2BYHzkosVnFTO5IXKVJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzYsS5En7LLvoJHlT5mxLFoTANjOzHU05hYRqAc6tkrl8PL1GYkHot6hIx0f8aJzfAIognJ/3/NC5ys5ryGAcCJ37wJ4Vy1fq9otsf5qpyHpH5AD7oDzxdSjhHNyfZQzeiOgflgmnt7CtB+Tu/xOyrdNPm9j8rMeqLSNEQlyFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC11SiMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A374AC32782;
	Tue,  9 Jul 2024 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542184;
	bh=tdzzJLvvDu0ufaMXnQPf31T2BYHzkosVnFTO5IXKVJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZC11SiMNCY1Sy1OdLhvtckJLt+5y9tQoPB1bjM9OtlyNWM8hKgvH5s6zXIHRJ/F4w
	 bb509xa0Ekma5/4eYaRl+jL6IPruIoyR3Uv0iNmgm1zRDLaCbQqmgtB66zAX0mKoBh
	 l2TzMu5HG8PvE0wUtADhtE8sJHrEhmD0Kdg0cp13ZvJIk1JAZgQyfXeu4jbFpkeoJg
	 XvNecwtPRFQT3cL42DFKRsr74GOJo7qx1TgETm8MJ/PukmGD9SDfmYqF1BRDyFjL4b
	 TBnlgXrFhQDahTnwoM7a33ydr/dU8PXDM3S4+k61kPN+Ata8vofbcKt1EEnPriRzYg
	 oBgktEELWDrEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	extja@kvaser.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/33] can: kvaser_usb: fix return value for hif_usb_send_regout
Date: Tue,  9 Jul 2024 12:21:43 -0400
Message-ID: <20240709162224.31148-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 0d34d8163fd87978a6abd792e2d8ad849f4c3d57 ]

As the potential failure of usb_submit_urb(), it should be better to
return the err variable to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://lore.kernel.org/all/20240521041020.1519416-1-nichen@iscas.ac.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 71ef4db5c09f6..51c8b7c109728 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -291,7 +291,7 @@ int kvaser_usb_send_cmd_async(struct kvaser_usb_net_priv *priv, void *cmd,
 	}
 	usb_free_urb(urb);
 
-	return 0;
+	return err;
 }
 
 int kvaser_usb_can_rx_over_error(struct net_device *netdev)
-- 
2.43.0


