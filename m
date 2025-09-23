Return-Path: <linux-can+bounces-4832-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9FB9443A
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F092A1159
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 04:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B430EF68;
	Tue, 23 Sep 2025 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1e4VqdT"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CD30E85A;
	Tue, 23 Sep 2025 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603214; cv=none; b=tMhlqYvhNxhY7USYuBaJVM05eQJZd6RI9dUrLTGI43JQeM85FYJBzYBoth6x58KOtJteCVEhBSZbu1NuWapDOLDDXVRL5PzhZdHP7QytCflawtdPSyIgu26HmqSpSydHDOKC+lFJgm1WUKnNBVWfhEElH8ATkHMMBprRpY0wSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603214; c=relaxed/simple;
	bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RONgtBJdfjnWlRRqXyb7o7ywRJFmaHe7N/LafodZSjnpmeeYRmDu2Z4ZoiO0ok3eiu0RMgWNVsvGgkS8He3mIopzKYbKl2GnK/BIrvRz0sW2MB6dkArnGCoadIgPO/R9kb8bQztQEpSQ4aZwNKDYBKwgS8kmncqEFrtlntfOFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1e4VqdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A14C116C6;
	Tue, 23 Sep 2025 04:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758603214;
	bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p1e4VqdTd1XpBlyJcpGd9iZpt3GYyG3z618tUvRHM1wZOhgAuIi4iBy54U5k5S12t
	 d4Siuya0oLMgRQq0XiPbDObsR55JbRruFk1Hn7Qz/AHlINR33oxCwTanZBwS50Z1dR
	 2PY78YqeH+7q1t4wX+URXOTVgFp1NSPRuFlwOYEuSmReJzyhty4mwQhtGcNqa96Pjw
	 wuM+DJPwuXchBaTP0f3LTvII5m/+jR4ARr7WpK62D1c/4vQH1KOVvV0UMMQm1DGtLz
	 5rD92kMIGlweLoRfYUYY/5moJAR+CIX26r8gEKZZJTaj/H8Ql3W5joH14kLDlnK7/c
	 ic1Z5M7IDVC/g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 13:52:44 +0900
Subject: [PATCH v2 4/4] can: enable CAN XL for virtual CAN devices by
 default
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-can-fix-mtu-v2-4-984f9868db69@kernel.org>
References: <20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org>
In-Reply-To: <20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmX1I89vKDqmLLM3PhNUlPpoT6HrbLz/8x93RxhfZLJ8
 rE/f8mEjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABMJz2JkmB17+UfqqQvTEvXT
 csou1UanVH/4xu70WupN+V6WA2Fsixn+cHQp/A/8Mvvmv0Pu1f5szGvT2f/LP1i5MPDa0bw/q1c
 fZAQA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

In commit 97edec3a11cf ("can: enable CAN FD for virtual CAN devices by
default"), vcan and vxcan default MTU was set to CANFD_MTU by default.
The reason was that users were confused on how to activate CAN FD on
virtual interfaces.

Following the introduction of CAN XL, the same logic should be
applied. Set the MTU to CANXL_MTU by default.

The users who really wish to use a Classical CAN only or a CAN FD
virtual device can do respectively:

  $ ip link set vcan0 mtu 16

or

  $ ip link set vcan0 mtu 72

to force the old behaviour.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/vcan.c  | 2 +-
 drivers/net/can/vxcan.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index f67e858071007acd5f34fa00a76212f1a77997a6..fdc662aea2798125b3aa373f09958363b427ced2 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -156,7 +156,7 @@ static const struct ethtool_ops vcan_ethtool_ops = {
 static void vcan_setup(struct net_device *dev)
 {
 	dev->type		= ARPHRD_CAN;
-	dev->mtu		= CANFD_MTU;
+	dev->mtu		= CANXL_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 99a78a75716749bf858cc78eadb41ca2588fcf94..b2c19f8c5f8e5101b8be343401afe9a4f388c4da 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -156,7 +156,7 @@ static void vxcan_setup(struct net_device *dev)
 	struct can_ml_priv *can_ml;
 
 	dev->type		= ARPHRD_CAN;
-	dev->mtu		= CANFD_MTU;
+	dev->mtu		= CANXL_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;

-- 
2.49.1


