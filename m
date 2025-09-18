Return-Path: <linux-can+bounces-4750-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA62B84BA2
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 15:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A61893287
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B4E30749E;
	Thu, 18 Sep 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALuUE+wF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0B307493;
	Thu, 18 Sep 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200379; cv=none; b=bPuNyVoewugpRGEo3O0qj2Y6tSH6zCkyfugo/zJenubBC/nABs3xOOL6Lcpq2b23sAyIuPe5PJEYw8ifxt12wqwiKlpOi2sCKOS3GqH7D3Z//7vdKuq96E82JSOlUq2Ux00KaF55YrqsdWGMWKsMi/+cZG2Y8hcx2/sED2jWLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200379; c=relaxed/simple;
	bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRJvmUbX/61obVYdMBZ3jXtjnW644N8lfQGswHLlNTjtubADnqexuGiBsuvhOpZzNwh7dV/bShpolluvEjHx2PPBSxXGydi+GywSULeflI1NzLQwItf7xcJzYpVKN1nli0CT5aanFuQZyRnIOyP+16dck6Ig+MZQ8n8nT/ZxAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALuUE+wF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DC0C4CEFB;
	Thu, 18 Sep 2025 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758200378;
	bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ALuUE+wF4QyR07v7KLfnr6Stu0SlzmPIlubjM1KQhcSMD3CV3f9CU6HYXgdUyZ0+M
	 EjbZCOC7NWjnvbJ1YaXgySORyqauILrE53XBUcvl/E2xTpsFdunzzreDEtqbICtNN9
	 hxUaJgfihQaxGfhS9C31mJ2eVzkkL/G5Mj5t2KtfXyFMxCijwDz15lWt5jjfMtRkiY
	 zILPIJiTv7z0/FbFug6FsZVH5bENN4Nv+Bi0wO+QY8y++y+/FAfhXcaQzbOL86VcMi
	 Sc/bcyrxwPXjX+B7UG8MRGHxC3Ltn8PAfVaA95LzxLMbkIpdyd5zEb59PcYqjWQXqE
	 H+qBHGxgP6Nqw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 21:59:15 +0900
Subject: [PATCH RFC 5/5] can: enable CAN XL for virtual CAN devices by
 default
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-5-471edb942295@kernel.org>
References: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
In-Reply-To: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlnmIyurpvtpM+gttg4QlpwkiLPO1PxeEV9hu2OWqEvf
 ayT38p1lLIwiHExyIopsiwr5+RW6Cj0Djv01xJmDisTyBAGLk4BmEjTBUaGRZqvrnvEBP/xMbE1
 5Fy1+J99plFU1c0mtfBADu9/gfn9DP9U1+T8XFzO+YSnYsW5H9MsDB7V3G+0jrTnFN9iG/Rtuys
 rAA==
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


