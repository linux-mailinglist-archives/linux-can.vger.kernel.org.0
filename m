Return-Path: <linux-can+bounces-954-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF592BFDF
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 18:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9495E1F207C3
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA731ABCD5;
	Tue,  9 Jul 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYZDtCNt"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F891ABCD0;
	Tue,  9 Jul 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542057; cv=none; b=VJ8Ttw2SYGvOA7QLBmrOkaCrpwK4FC5Ihi/2Ni16XIjwq8B60RXTyg5XLxuUXl1ARG3mlKts5u9mrEmCRxJavWWMsXVs4wkw9/namiIuRXHzDSX5GP1AbYfG1kOZKE9f57BCzLqfU59bptSgHW8vLDSwzJ7nqdIt7mwkJz+RFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542057; c=relaxed/simple;
	bh=fk5F7PnfMsulDDYfiUSEEt6RSCFGW7ofRStQVDVNt1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv8hKq0LcScmwFGQ2uy4gVM9kZTR8OZGNPSLT/J0PGJL2n7bc9GOTFSuX0jV/dXZR7KCb/9jQQFHGd7t5yJvY8PvLJjc2SJa7S+35rFCCtqYvVXnvJ0XhZFhG/r6+U+Cmz6q+7paAj5riDsUNiDa39K62Dk5iKD/oK/hq4DKayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYZDtCNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA99DC32782;
	Tue,  9 Jul 2024 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542057;
	bh=fk5F7PnfMsulDDYfiUSEEt6RSCFGW7ofRStQVDVNt1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYZDtCNtyGHh+x89dXmdb3cp14fE01oWZrojKTQEMlu7xs+ZUClmVmp3mlOQc+d0j
	 LF7RznILIzy20P55KSWGDiUFT8qof+OXDKck+/JtfHGhTXWWzV4dEQIOp/UB6E7uJc
	 Zg90BwK+e1Mx+NFGit/Uz5/DrSBfOMNqV2CfS/RvIIJ42zg0bOXiXpyGtey12P+MVz
	 fb4O8DIqpbqLhXoBzTqOGe+6Tiy4vjrksn8eOdXZf5U+XSJDjAKluOYCLuTefMuPNZ
	 pL+zRxwYhXih1LiVYTUqTGNrc1luuczUtF3bVrXd5ebSfxAYpZRh0a3QbPpKiET+ma
	 1w1nMKxqZPsFg==
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
Subject: [PATCH AUTOSEL 6.9 21/40] can: kvaser_usb: fix return value for hif_usb_send_regout
Date: Tue,  9 Jul 2024 12:19:01 -0400
Message-ID: <20240709162007.30160-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
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
index 8faf8a462c055..7292c81fc0cdc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -294,7 +294,7 @@ int kvaser_usb_send_cmd_async(struct kvaser_usb_net_priv *priv, void *cmd,
 	}
 	usb_free_urb(urb);
 
-	return 0;
+	return err;
 }
 
 int kvaser_usb_can_rx_over_error(struct net_device *netdev)
-- 
2.43.0


