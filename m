Return-Path: <linux-can+bounces-1061-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98729941042
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 13:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C292830C3
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A160198858;
	Tue, 30 Jul 2024 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNuXvIhL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134918EFE0;
	Tue, 30 Jul 2024 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337949; cv=none; b=TGG+gPskuIa503VSs4t31AMebeqzLRPWRI8QxBIZC/67Er6ecMzHYygNcJMxEblbTK7E7B1QMFGOh5EYWhu3ISYioG1DZ1ahvwQzxcUW4OnAQtw8Yi93P8ClN9ipBVUpw62T8Dszh18Zqy9Fju//YR2NZvDg1kwFteZ7EN4wH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337949; c=relaxed/simple;
	bh=TvBVeeSaQvImF3gatvBGe2C9RObvnI/gY3XbQ75heLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=frVofMHbqI5qAL30Tya0uwG50tCXi1MyfIkzBX0rKuxseOe/6CvOK/uV9LwB9tBhAxG7DwjZJuwTC5iuPqWfv0sSybU8JGnBm8KunVnOXjRuVp9uK+gINOfPJvQ9IGMvop57GZ5CamVOuVVwzvzx/22Zzyw/gMY9C46XW6sd4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNuXvIhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C96C32782;
	Tue, 30 Jul 2024 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722337949;
	bh=TvBVeeSaQvImF3gatvBGe2C9RObvnI/gY3XbQ75heLY=;
	h=From:Date:Subject:To:Cc:From;
	b=sNuXvIhLrxG8Op3OH7G8Yaz5/oPyT0TIQYcN4g5Vm6F8vntM8YV4le8v9hvbYm8e9
	 5HSzPu4kgW60U/Iqdv1qRORIxIO8a4k/1aLoq0ceZiXX7lYK1ibIFv335j//0pnCCI
	 v6Ht3cXJxgQVdsV37YdI4iCc3KBrFf1nQ3p1FWZWboYlKBo36mI54R7XqYzHhtuXhD
	 ju9x/wNhBCUP+A5vPme22jDc/0Tdvch3Y30ViK63Ps0TVDKnigmxfCupp78QfeA7NL
	 0TCT2i7yNIW0QOm5tUm3zyPHGV443cFzKWVaSB/gaCMpKq1+P19tOyutF7xvmj5bng
	 GRml+aqhVsPzw==
From: Simon Horman <horms@kernel.org>
Date: Tue, 30 Jul 2024 12:12:21 +0100
Subject: [PATCH RFC] can: m_can: Release irq on error in m_can_open
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-mcan-irq-v1-1-f47cee5d725c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJTKqGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc2MD3dzkxDzdzKJCXWOTVAsT4xQz8yRzYyWg8oKi1LTMCrBR0UpBbs5
 KsbW1APXbVlhfAAAA
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
Signed-off-by: Simon Horman <horms@kernel.org>
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


