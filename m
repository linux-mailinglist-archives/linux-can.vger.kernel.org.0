Return-Path: <linux-can+bounces-956-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7F92C0AF
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 18:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290361F2371F
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DCB2139D3;
	Tue,  9 Jul 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ0k10z7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED92139B2;
	Tue,  9 Jul 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542268; cv=none; b=FKBfPS9Mqy9s8c+29+/jUR5vKTPfvNUpWDLjtEGkY5lkey0pYBwf15izEEMoucDcgKytFW3eiDIeruLvSeh00Z1TVEF37ws+mMpHToWlu34YUPLcPCYTbMZoDQmoOEt7gMLCHLPKQREOjRvXNA9ITyPBy3974znKUJZPWU7a75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542268; c=relaxed/simple;
	bh=rqQBo3mbDovOFPoF/8YNT6rE9vXlmpWf5sM6h/gqEFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XT+pW22co34XyFWfEK2DwxsPrj8fjAh2wnaNTuxhGKjh8+5wy27BYTCmUSyZA2AD5cfUK8RjUXHDvj/YreO/VLXLLI3BqSUh5YpLqVHR87bcHuIhbc+OMxDJ5cDtiKT3CETvEN0cECqLgLWL2AQFgdFkq0uc3vnbSBOv91LRQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ0k10z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770DDC32786;
	Tue,  9 Jul 2024 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542267;
	bh=rqQBo3mbDovOFPoF/8YNT6rE9vXlmpWf5sM6h/gqEFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZ0k10z7Va1YXdjPe6u+/a25TlhQaiLccEnj0bgqIqNEDSOpZxtmOsckVN9eRQoC5
	 +ODgkD0lRyg6JoCs0JX43TIRvLw/AvjGA5NA9/HFxgoH8sy1Eiu9sKjKDDi6I692G9
	 X2xQ2Ma8SxpIx0nU6HBSIaWP3+blD5Pj4LLw6W5LmcH3QwEBY55/2l3yrOBZJ5uFL4
	 tCVglT+buVvbD504kTVAQUJt/kMvhpDqylbBRAiEyB2HPIPoDKqgMHol73/UuQk4Nw
	 DobKnYIqM6dcnpcZan36vaIiFJkwe9j2zNKNliAMmoCyyUDyVS1Onwk5jFWaN+wub2
	 6/DidVOYdtiuA==
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
Subject: [PATCH AUTOSEL 6.1 12/27] can: kvaser_usb: fix return value for hif_usb_send_regout
Date: Tue,  9 Jul 2024 12:23:26 -0400
Message-ID: <20240709162401.31946-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
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
index 3a2bfaad14065..6d50c94d40c37 100644
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


