Return-Path: <linux-can+bounces-1468-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A662973F84
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 19:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDEB1F29CD4
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F81B78E4;
	Tue, 10 Sep 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn05P4rS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E451A4F19;
	Tue, 10 Sep 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988984; cv=none; b=cKscEzWfAx1HLdzC063JetoEHiyXAVXGjfOnxBC5scngwUZjXZnhmgAeLvwR3bj+7ptag3lLd1fkueYmMrv15baSmEyafAhVvfCl72+rQC2s0sQQ83KK84iV6XLUTBD2EzxUHk/4tP9E+4ycvhclN8cDTkkQgNpPPCmzP09V5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988984; c=relaxed/simple;
	bh=co+0/b4aRDm6iCVskWeVHG7wwfqak69YUvWTAJJ1DXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zxpd3nSmKZzD//F1WK6/y5eyP5UGfUe5nL+RMT0kgXzjAFRFbhk2axYQdN+i00dK/bT//E8SRR5QyzDFfgIloN5T1QVE3izXqnNdLYodyyucJ9tRXmi2vcfur3loVg4BiYkAdE5+xJBfBNKVQfGNCXgEZrXYCj4UDscmgDSDz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn05P4rS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0260BC4CEC4;
	Tue, 10 Sep 2024 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988984;
	bh=co+0/b4aRDm6iCVskWeVHG7wwfqak69YUvWTAJJ1DXc=;
	h=From:To:Cc:Subject:Date:From;
	b=kn05P4rSDEzw5iwg/iNH+7IccpH4G5uBqcjT/cVex/9h5CpF0YISg8gTjJw3Cpx2Z
	 snj8rWuxM/crAXZA6oUDV8gkysPzki+hhhobxNTqab3z0lEO9MLhW3CDiOj1DhWfDB
	 AjPogMjfjeeqDboA1WaINoHpQVFLvxhVeP39zh9dsTyCmRZPNoF+meaErY3EQv8/ta
	 AZZ8FAXQY8XR9XiZshMOPOjc/ELI97RMZHx0MTe/hrQxYi5hwHZXAed56NtBajGvu9
	 Kz62pqZHAJ+cLZbNu9syUQQ3X7KvPwysRBfdpKZuKFKslcMg7dN5p/HAlhNp+JBaPQ
	 ppkn0XWkTEVgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	manivannan.sadhasivam@linaro.org,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/12] can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configuration
Date: Tue, 10 Sep 2024 13:22:43 -0400
Message-ID: <20240910172301.2415973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit ac2b81eb8b2d104033560daea886ee84531e3d0a ]

When changing the interface from CAN-CC to CAN-FD mode the old
coalescing parameters are re-used. This might cause problem, as the
configured parameters are too big for CAN-FD mode.

During testing an invalid TX coalescing configuration has been seen.
The problem should be been fixed in the previous patch, but add a
safeguard here to ensure that the number of TEF coalescing buffers (if
configured) is exactly the half of all TEF buffers.

Link: https://lore.kernel.org/all/20240805-mcp251xfd-fix-ringconfig-v1-2-72086f0ca5ee@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 4cb79a4f2461..489d1439563a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -289,7 +289,7 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	const struct mcp251xfd_rx_ring *rx_ring;
 	u16 base = 0, ram_used;
 	u8 fifo_nr = 1;
-	int i;
+	int err = 0, i;
 
 	netdev_reset_queue(priv->ndev);
 
@@ -385,10 +385,18 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 		netdev_err(priv->ndev,
 			   "Error during ring configuration, using more RAM (%u bytes) than available (%u bytes).\n",
 			   ram_used, MCP251XFD_RAM_SIZE);
-		return -ENOMEM;
+		err = -ENOMEM;
 	}
 
-	return 0;
+	if (priv->tx_obj_num_coalesce_irq &&
+	    priv->tx_obj_num_coalesce_irq * 2 != priv->tx->obj_num) {
+		netdev_err(priv->ndev,
+			   "Error during ring configuration, number of TEF coalescing buffers (%u) must be half of TEF buffers (%u).\n",
+			   priv->tx_obj_num_coalesce_irq, priv->tx->obj_num);
+		err = -EINVAL;
+	}
+
+	return err;
 }
 
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)
-- 
2.43.0


