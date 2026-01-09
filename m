Return-Path: <linux-can+bounces-6054-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFBCD06C12
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 02:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C465F300B823
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 01:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4D1F30C3;
	Fri,  9 Jan 2026 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UbV5Mcl4"
X-Original-To: linux-can@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CB1FBCA7;
	Fri,  9 Jan 2026 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922634; cv=none; b=I5JVPk6Zef6QUUnosCSR4jiHtaqY/cDSKgp5ItqCz1Xe3p5Q4Z6pVswvEcWP4RRkM/UDQ9dAlwJeCF2jav9wB1bJ5ibbvpkh4neQ6c54sNS55R04lJvi+jMqmRMdDoZTgwtW/c6Cg0CvtnoKQAkAzqZe/iY49y/24/Jg83UksNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922634; c=relaxed/simple;
	bh=vrQFZ60kCD4QItloqTS4yIEdK+yDADC5qDuNejKIoFY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OIpII90rJGBs0qLO+g8lVhK77IhDLgr+v+NOmj0UNBOqFz+oryhAHVV3en3OfSOjzFFweUFATXctRYtmkvnNVS0Col5BIuAQ3dSbQ+MHCB2UJjYrseseGOFQ2i9U8HuSTbY3V1NPvikKB/gQcWf+qlcG01+xkzLlprlxhZFUSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UbV5Mcl4; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1767922621;
	bh=vOhhGovDEdI7MIiVRYvOwSIIsewzXgqtF+6ZX/55HJs=;
	h=From:To:Cc:Subject:Date;
	b=UbV5Mcl4K6+JKlA5mwbtoQfzI8fXiBA2F6qSIz/bauchr0qg33pmy5ausMN+8c7aI
	 TcJrLRq5xgOw8m7WAo696JL0WZ6WgaN5+lQDsdoNra02/UTsxP8lbMPSLHVrcuEdUY
	 X+lCwkU9m7mzhnLj/FvfbVNTBiVZ91q+9fvVKums=
Received: from 7erry.customer.ask4.lan ([31.205.230.119])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 9381240F; Fri, 09 Jan 2026 09:36:56 +0800
X-QQ-mid: xmsmtpt1767922616tb59jxuxm
Message-ID: <tencent_B88CC7093F21BB59E7B4298209F208E02708@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJP7ilj1YbtakSSuxxLEyKtcI22eJaJPW//OvymwtbZJOU2kvvwl
	 9OmqnYzT8W6vlsBjHCOS6vRE6uhHlOwKBktoVJM/Yzul8A2KRPQBUwIVl+/y7bTUedGqUKOSAy4P
	 f+I+u37JxCC3znWGxau6juDKjLu96S2nSJJgnThCh3h+hpRttj9eG5biInC2DKStgHd27IFlaZkG
	 CbS8d51qLqcjfXoxf+OugAa8kmatc5VdmZAEijj2cDjCjoX0yCWU1IPH/mZ1gz0yFBigCFujQv1B
	 CTvsXaOKJ31OPvtXw298n4JwnxlW3fZlJR6nj+mkb9g6YP1aCv8bfyHqgEknZqvdlSALHIEIgh9o
	 1sH6/2flUNdP5EkcYSLAHTfkgdL7IQV0IWGhA7vIs/z818vsMlKaEmNHzYlTaUCZSmaAhDWzR+Rk
	 ONpSi7AS3eNSaT4fc2D5HIGWX6d0vDefp10fx1kYbMogsyoX9+rflSgunNOFev/ukkLP1KsfQCRM
	 0e3llcp5/ovMabujiM+AvwK3ERHU5XBTPOe6rFt+mfMQapZp/tj1qhH55LVKqYG99HuMz5gtFjRD
	 cOmg19fx+mHfsennQeRS0KNcjoQydRFl+47i17/0BiK8ySQSvki5SGYeSLBvU1WGB+kJpNgZW5XP
	 kGHcGh/WmTFkWZ9SQKvKuJdFhAYamMQ4eJiOj3lfNPGd7J/RCvisLtf5et+s6cmlM7qfad9HVhzZ
	 IPcJtf+zGWZDbnJ4cJpYtqzdyIuBFr3jTk/K3/d/Ih8EX5xiJ5rXpQzjgvPG51K7y7zgrifyqM/I
	 nGcE5P8hDfj9emRsbGRdKLrrxq/VzdWigxFSGbUhY5YEBMfGboDCCT4Vcbc20UxzWTiKKkY2AjzY
	 SvUo0MDw7ecy1uZTnlw9aL3h7vvGltGOJQK0jXqOQYBePROmQswJYbJSLeczKRRh2LRBGDcs2pTn
	 eSLt8MY8JqWM8Nr1KJRyRSH7KvmEfbM/TwX7Uj3xgcy0+ep+LKRy7lV62UVL93Xx45njtLl+YKvB
	 AL9rNwR4y2AwsUOTMSSAQMija1sJ1L8X72JVmV0K1l0Ejz8Qij
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jerry Wu <w.7erry@foxmail.com>
To: mkl@pengutronix.de
Cc: mailhol@kernel.org,
	extja@kvaser.com,
	eeodqql09@gmail.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	w.7erry@foxmail.com
Subject: [PATCH net] can: kvaser_usb: kvaser_usb_leaf: Fix some info-leaks to USB devices
Date: Fri,  9 Jan 2026 01:36:48 +0000
X-OQ-MSGID: <20260109013648.39054-1-w.7erry@foxmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uninitialized Kernel memory can leak to USB devices.

Fix this by using kzalloc() instead of kmalloc().

Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
---
Commit da2311a6385c (can: kvaser_usb: kvaser_usb_leaf: Fix some info-leaks to USB devices) 
fixed a similar issue, CVE-2019-19947, in the same file. The other functions 
contain similar logic. Would it make sense to fix them in the same way?

Thank you for time reading this. My apologies if I missed anything.

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 1167d38344f1..b031e6e42a41 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -723,7 +723,7 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
 	struct kvaser_cmd *cmd;
 	int rc;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -1881,7 +1881,7 @@ static int kvaser_usb_leaf_set_bittiming(const struct net_device *netdev,
 	struct kvaser_cmd *cmd;
 	int rc;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
-- 
2.52.0


