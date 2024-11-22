Return-Path: <linux-can+bounces-2178-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226919D60DF
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C3FB28213
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB0013AA4E;
	Fri, 22 Nov 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LzCLfG+G"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036113B298;
	Fri, 22 Nov 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287181; cv=none; b=K0EAzOQ6Mmg2VuZJXMhysyX/68RfXZEy0IWltVV8mNZJIGqOqbca7X4fCsFyR073exVtdYIsSNYuXSLgHm2fUOvX/F+REepNMG/BFWIgh+u6IpRjG3YwuqQeeIbGJwshf51FjpOS/XG1UcSyXPfulwGMLN3z0KymUeF1BP7645k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287181; c=relaxed/simple;
	bh=aFi5zF3dMYrTZJtFjbLKmRl7u3piNrt0b5TZjGxN6qU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uk3tdqeDUwy8HhQ9XhRiCsD3oIxUhfNSghAoYhsoAfG9pp6eZ5vYcD24V7SSVurUN8k/HIJmvx7DRT/2dOLPUalByfTvEju96c34gWYFDpvJe8AcdsfOKOaawAVGh3ud1MnXTc6bEwU0rylMPcjgvhL112jcN1H9cJ/bs6av+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LzCLfG+G; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=USN4L66UJITCUR+qW8nXpFIAvm6RhtpdO923SmyUnvI=; b=LzCLfG+GXRj0txFYscxL9W73iG
	V0C3xgDYiiqttu+iINNLYe4Z6IGS2SfooBSdm6aBO4RciEWAiUvriJQQywI4Uoq70+1JBJJ/6/qMn
	o+LH2/8PssXVn3odg6pa55GxNU1Bmy0QX1AHM68Di/KYHrHUOCVJ6H8j/t3oGV+kpek8Ni+4ltb5P
	8nzD7R5A9gtbxuiDjhIphGU314bvpr1oIgdexFyv3+fAz2J3SFMrbHPft2f38kjW4vI6YySCxtJ1P
	AhzpGibl8gHVc7kwVZYRzcl7b7rOZCyg0h0n1lzvz7asguwxhQy2YWyNwmu3UtJnQmigXd2GFHS3/
	pkehmVFg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tEV1W-000KIH-LG; Fri, 22 Nov 2024 15:52:42 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tEV1W-000HFz-1T;
	Fri, 22 Nov 2024 15:52:42 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 22 Nov 2024 15:52:24 +0100
Subject: [PATCH can-next v3 3/3] can: m_can: call deinit/init callback when
 going into suspend/resume
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-tcan-standby-v3-3-90bafaf5eccd@geanix.com>
References: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
In-Reply-To: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27465/Fri Nov 22 10:41:26 2024)

m_can user like the tcan4x5x device, can go into standby mode.
Low power RX mode is enabled to allow wake on can.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/m_can.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e31ce973892a96f47d26d06464e0f6e2245550fd..777dfb23c6fa2052e9544d0808c0c4980e9c8b0f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2444,6 +2444,7 @@ int m_can_class_suspend(struct device *dev)
 {
 	struct m_can_classdev *cdev = dev_get_drvdata(dev);
 	struct net_device *ndev = cdev->net;
+	int ret = 0;
 
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
@@ -2456,6 +2457,9 @@ int m_can_class_suspend(struct device *dev)
 		if (cdev->pm_wake_source) {
 			hrtimer_cancel(&cdev->hrtimer);
 			m_can_write(cdev, M_CAN_IE, IR_RF0N);
+
+			if (cdev->ops->deinit)
+				ret = cdev->ops->deinit(cdev);
 		} else {
 			m_can_stop(ndev);
 		}
@@ -2467,7 +2471,7 @@ int m_can_class_suspend(struct device *dev)
 
 	cdev->can.state = CAN_STATE_SLEEPING;
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);
 
@@ -2475,14 +2479,13 @@ int m_can_class_resume(struct device *dev)
 {
 	struct m_can_classdev *cdev = dev_get_drvdata(dev);
 	struct net_device *ndev = cdev->net;
+	int ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
 
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
-		int ret;
-
 		ret = m_can_clk_start(cdev);
 		if (ret)
 			return ret;
@@ -2495,6 +2498,10 @@ int m_can_class_resume(struct device *dev)
 			 * again.
 			 */
 			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
+
+			if (cdev->ops->init)
+				ret = cdev->ops->init(cdev);
+
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);
@@ -2508,7 +2515,7 @@ int m_can_class_resume(struct device *dev)
 		netif_start_queue(ndev);
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_resume);
 

-- 
2.46.2


