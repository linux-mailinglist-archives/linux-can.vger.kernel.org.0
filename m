Return-Path: <linux-can+bounces-4860-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB092B94947
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 08:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BFE18A8480
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472F30FF30;
	Tue, 23 Sep 2025 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yid5DSO5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5ED30FF2B;
	Tue, 23 Sep 2025 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609456; cv=none; b=B5AiGC0oxGsqsRP/LpSfI6mLi9R7C6WjXNXzD6QsV3bcfCA7lznlEgG7zNKin393zPatmjfX69eUYE78QiPkomqcSGokjabYe/82JjPG/0JzuZs8ddtrZepU4mzdnBzzsldGAVdMH/0aRTg0z6jv1FLNVLdsDfeQ/+QvLIHsOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609456; c=relaxed/simple;
	bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fY4FCLVXssISblIfC7f5vt0OIK1X6CAnpYcB4YOG/Ddnm/pu1V/xF1JxZBDKD2u6TwsU6jzjHffQMH/jlTtaZR1X90cKz/Nz4DH6H7Sqka+/r/pIw3bu/IPwwL3c8XtO2duooS8vNuAixq+L9v7LuaTFR0LohvgWPezJir26r/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yid5DSO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50E7C116D0;
	Tue, 23 Sep 2025 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758609455;
	bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yid5DSO5OInIoJg8c9aESz7+ekB6vofo7fonrI+I7fzXnN5onXi7XeUnzViH4/uCc
	 baTxLuTMHGdUIE4vOI+cfFJKq0wALaMurKR/UOEVQDZerwmOKG3uSUXXfpdY+Lb9RG
	 iq+KsdOAWwbF2vP4BbSOlcige3sJGzR+VQrHn+tzK2A+admGFRtgGESJv3XajEe7QG
	 D4whkSb3ZbTmiU56+cme1J74jwynYetwFb4BwDwcgHAFlt5wbEMQrKNLzwEO6J4ug0
	 snol8yrlEZ6qQCxS8t4uAo1GU/8QifQPAmVZSMinifCk3ySrzqzNiC40k4MwOo75pF
	 e8QC9jilLQU/w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:37:11 +0900
Subject: [PATCH v3 4/4] can: enable CAN XL for virtual CAN devices by
 default
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-can-fix-mtu-v3-4-581bde113f52@kernel.org>
References: <20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org>
In-Reply-To: <20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=2/MlNtQVs67BhcBQu3mBYH5/+H7qem0YfGtT2lPXmQw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXHNQvBBd7FG6ZOu/poX87d5YcO2nRpcN9if/x/dPp6
 duaFxuwd5SyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZhI305GhqOczpdXc7esDbjW
 23r6N3Pi9iOcZzfEFLwoetHi/+bQimOMDO9nHNgiEz7H7E/NvtwDZsmP5y+sLlt8dRnHlNc+a5r
 2mvECAA==
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


