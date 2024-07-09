Return-Path: <linux-can+bounces-960-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C1B92C16E
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 18:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BFA1F221CD
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4F1AC239;
	Tue,  9 Jul 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcgO+yZ7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075819E2DB;
	Tue,  9 Jul 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542455; cv=none; b=Yk3tZKYat5G9q3M9p3zcMdTQltpR0bD7rngfGB3FHCneiCRpBta7WukjyKfzXBZ/N7oLSZW82aOmJu+LwA3vIfsdVfnMlqekt64pv2VEbCU33mrSNFY6zLRmK9/tHGymsoEXFld8hXDpfH0VcuA1I3ZPhA5Qi9ocb+VfCAlMtno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542455; c=relaxed/simple;
	bh=T3/jczk8DefyyOzICliQwiN6RMTl7o+cGz0tOuFzcgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMi4qwi26da1ItJkpPkYpoKIr2ohKKlAcHSCPBLGfb42kPi68ITaI2XCeVJV4dddfsVnGmDEcQZgT/jGi/QcDsYJGSu8dAWc+4OAf4Ltcvon15rYwo5L51z8Ivd+QS3qjYiz5eFjt3nBLQCxotPSrUc8ldJ5fxSIR+mHhL0pLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcgO+yZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EAEC3277B;
	Tue,  9 Jul 2024 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542455;
	bh=T3/jczk8DefyyOzICliQwiN6RMTl7o+cGz0tOuFzcgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcgO+yZ7/2pexlHgmmRzum4Fx/fjDXyCn/8FrvLFJHnOtrUSR8vZIkI2VQFSR9du5
	 5dnX8bO9NTg/EUYurJb+6nDYmjdSsie5ypb5iWaj8V8wD36uE068jrsZg3AtnIpXbn
	 qXRb+QUQhFp9WCYG0jJY6JzprZ20SfhhyLWRp8HpYAcjC4p489FZh5MYvzBHyauxX5
	 xSpzH58+24q8xE1G6ikcpg2TJLeVEBny+yKP5wyDrwBNZB8XIKcR6e79if3BlIpvyQ
	 /wVSf4nMtuYfGwlmboZ5Y8Ix8PHXGl4Fl8+qylP4SSIeSmQmwud2av1f18s2AmzuCY
	 fokDYIKQetNbQ==
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
Subject: [PATCH AUTOSEL 4.19 3/7] can: kvaser_usb: fix return value for hif_usb_send_regout
Date: Tue,  9 Jul 2024 12:27:14 -0400
Message-ID: <20240709162726.33610-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162726.33610-1-sashal@kernel.org>
References: <20240709162726.33610-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.317
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
index da449d046905d..8bbe526455c86 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -265,7 +265,7 @@ int kvaser_usb_send_cmd_async(struct kvaser_usb_net_priv *priv, void *cmd,
 	}
 	usb_free_urb(urb);
 
-	return 0;
+	return err;
 }
 
 int kvaser_usb_can_rx_over_error(struct net_device *netdev)
-- 
2.43.0


