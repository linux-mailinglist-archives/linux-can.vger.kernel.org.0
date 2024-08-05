Return-Path: <linux-can+bounces-1106-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF0947C66
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F291F23578
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943A6CDC8;
	Mon,  5 Aug 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRVQ6iXl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC91E49F;
	Mon,  5 Aug 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866539; cv=none; b=M6l0qnN+idZ0DLIQp/HH7DAdaKVJwyJIpEWRdp2ZNRXWR4dsiCmqcz1qBemEEuD+8sVP+bHd+y+nsxht5KiQ31ghaaNTKTq56BMX+GzpfpojzxQPLnmjvI1DZONJ8D9F6bI/iVjM2rIxDu0B7a7Fvl5VxDwY3OJ1hpy8qxkt6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866539; c=relaxed/simple;
	bh=Xdb1Mt9ezMRarreL/m2dFU89KsI90nKFmRWbmyikT6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c6YOSfYSIR0wYjAorZUi0mOYQ2rklb91VgKInT7svkvDLPadwYkIp1OIPZ6NdM5dTsm+HcKX0Wh8SsKyXiCLjRBYlVztM0yXTL21XAY+5a1MB+QI72P3qWljES5WaX6SPVRwNyHU4wcOEJ+mtPJf1JTzn1ePtTOMyGbSvcDWqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRVQ6iXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE26BC32782;
	Mon,  5 Aug 2024 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866538;
	bh=Xdb1Mt9ezMRarreL/m2dFU89KsI90nKFmRWbmyikT6c=;
	h=From:Date:Subject:To:Cc:From;
	b=BRVQ6iXl8CrluO2yu2+8aENwTsbHB+7M/rTYWCexfqsJD7bKsQwP7AWJK9HYHap3x
	 lTw1yxeeDHdqUYxB8vYLiStgCLWWV2ovh4t19Q/85qZovoi/GwOPxC75I1QTRXXW7O
	 vM9FRUFWFvOnK+PkmD8oNJfwrRPiYpdjbVIW2x33F+k0lqQGJjO0Fjy+jInrVSuIy7
	 nB+AYVeYV+d6Fjz+VFIMHNxva2PtWb7lYEUqgG1SqVLu1D5vuz3k9cLhin3SPZZ14S
	 xt0VxSFlvuAkDE31rwokz78YmKDIGQaCRiZilxH6sRuCc5T3EyTDZo2pSPqTBrebaU
	 Cif4Dv4EeM/Yw==
From: Simon Horman <horms@kernel.org>
Date: Mon, 05 Aug 2024 15:01:58 +0100
Subject: [PATCH v2] can: m_can: Release irq on error in m_can_open
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-mcan-irq-v2-1-7154c0484819@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFXbsGYC/23Myw6CMBCF4Vchs7amN6xx5XsYFtgOMFELTk2jI
 X13K2uX/8nJt0JCJkxwalZgzJRojjX0rgE/9XFEQaE2aKmtdEaKh++jIH4KY/FoTTi4qzNQ7wv
 jQO+NunS1J0qvmT+bnNVv/YNkJZQYrPOIbXC69ecbcsT7fuYRulLKF087Lu2hAAAA
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vivek Yadav <vivek.2311@samsung.com>, 
 linux-can@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

It appears that the irq requested in m_can_open() may be leaked
if an error subsequently occurs: if m_can_start() fails.

Address this by calling free_irq in the unwind path for
such cases.

Flagged by Smatch.
Compile tested only.

Fixes: eaacfeaca7ad ("can: m_can: Call the RAM init directly from m_can_chip_config")
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Added Acked-by from Marc Kleine-Budde
- Dropped RFC designation
- Link to v1: https://lore.kernel.org/r/20240730-mcan-irq-v1-1-f47cee5d725c@kernel.org
---
 drivers/net/can/m_can/m_can.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 14b231c4d7ec..205a6cb4470f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2009,7 +2009,7 @@ static int m_can_open(struct net_device *dev)
 	/* start the m_can controller */
 	err = m_can_start(dev);
 	if (err)
-		goto exit_irq_fail;
+		goto exit_start_fail;
 
 	if (!cdev->is_peripheral)
 		napi_enable(&cdev->napi);
@@ -2018,6 +2018,9 @@ static int m_can_open(struct net_device *dev)
 
 	return 0;
 
+exit_start_fail:
+	if (cdev->is_peripheral || dev->irq)
+		free_irq(dev->irq, dev);
 exit_irq_fail:
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);


