Return-Path: <linux-can+bounces-5916-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1843CD9078
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 12:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E533F3066DEF
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A53321B1;
	Tue, 23 Dec 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="UnfoU6tZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013B330310;
	Tue, 23 Dec 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487403; cv=none; b=FoTjkXrHlXv4gCye+jlNBQc/tanoZaxx37JHDOyAelgOjoeuXS4YhGsbAgmgx5x6FAlrPgKIOkJ8aXIkX2oshtTjK1sa78BoiJmzSAapp3ZFAeWLI18m707+nlM51O7FhpQHOoqjl7gfZJdqkNO3uX8qdctnsn56l2ArzPYBpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487403; c=relaxed/simple;
	bh=9QyvR2OVjnNJziv4cw5QmTnTUUtC9dFxc6QMXkctYPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hd0jIa8UdUKHRhRTx+RqCADfQbfPZsK8yiiZkKJq9i2zwwWChDdjIcwIVWDI3/tvZGsSTA7Wl6EQlHf3BDgYReW1VTYv2t5LTT5P+EgtQJVGBT3MxjFxJPvedhegcjkAXjMWe4UF4fsXGuKeyl+VkurdbsK6eT3KtS+cyxABd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=UnfoU6tZ reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dbBlF5JRrz1DDMt;
	Tue, 23 Dec 2025 11:56:25 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dbBlF2xRzz1DDT6;
	Tue, 23 Dec 2025 11:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1766487385;
	bh=TTQmwKgI5xEhgQzcwjjJXhV/fl55LLqEZtnpyxE/gPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnfoU6tZ6A4heQdE/ePItc58pokHvatl6SB0OzrEttaDE7hmXIyLnRHoSUqHsAEAV
	 zhKkJ0uOQKfemuzO9K7cmX3H/b6TyFYcsE62NTw26ZXwwhxfwUOVJdEUvtGlJQC/uC
	 tap6SCFxutqfVENj/xb/13WmWxfI4/59DObqjxVCAD0q8Lv5vzkn7nyaxxW/+1dWPp
	 n5u1bgoPqmep5hfi5y93xNfYabDXpR+x4mZVlb5xdm964pQr1EftLxU9dYPp6Y6NgI
	 i4lMPogsKM6LgeoNHauJHoo7SPDYGzHISZ7zOmYIH2N2cr7MT05jzTz5H+pcsMcnRO
	 3knN9NUw0J0Jg==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v2 09/10] can: grcan: Reserve space between cap and next register to align with address layout
Date: Tue, 23 Dec 2025 11:56:03 +0100
Message-ID: <20251223105604.12675-10-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Hellstrom <daniel@gaisler.com>

Reserves space between the capability register and the next register
within the GRCAN driver to align with the hardware address layout.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index dc14b3145e73..bf1c503d575d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -49,7 +49,8 @@ struct grcan_registers {
 	u32 conf;	/* 0x00 */
 	u32 stat;	/* 0x04 */
 	u32 ctrl;	/* 0x08 */
-	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
+	u32 cap;	/* 0x0c */
+	u32 __reserved1[GRCAN_RESERVE_SIZE(0x0c, 0x18)];
 	u32 smask;	/* 0x18 - CanMASK */
 	u32 scode;	/* 0x1c - CanCODE */
 	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x40)];
-- 
2.51.0


