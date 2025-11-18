Return-Path: <linux-can+bounces-5485-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35629C68830
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FEBD4F29FD
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01651329E57;
	Tue, 18 Nov 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="a9m8DajD"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CC327219;
	Tue, 18 Nov 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457702; cv=none; b=C5QJLqtr5bo1GHTmMaOXIi+LM9QiJ0xBChkSsP3oszJyQ8JlzPk5S1+6IXlVBdhzttOFHBXN0b6krpWY2AaJtyMRnRMTp/QP5TE8YTEQZxL4baFMetd8VKJXxfT2BLrLIYZKiwmwUA6nd4NuNeSOMVIv2qJ5X+htDzG5G7Z6JRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457702; c=relaxed/simple;
	bh=ug/Om85tbIBh3JYtv6HolFoHDU30KjEcwo6+XqPwbPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRXHf25ylJ5snkjuc1EAQ1KTUpnmHZHenEzUgFae5msFUvFKJUDRg8MRKnYbpexVpN1g80UOqIzGY0wR7/8/JuLaPm1eeXCfTu05ojttSNrVTrLO36n4E197NCxBMO8C7hIoCmn1MHQ11LmO3R+lbKs3NVocFgcFdwIjzUniFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=a9m8DajD reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fJ318nQz1DQsp;
	Tue, 18 Nov 2025 10:21:39 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fJ214cNz1DDTS;
	Tue, 18 Nov 2025 10:21:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457699;
	bh=DB+/tMqLlPkDZnPEDnw4du5Ox/vJip09odqNd4Jpj68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a9m8DajD/yUrXtHDnt0RAsddXnnPJigvXbMyyajH9SMM5kmPvCWNaZftG33NYIL+q
	 UdTuBi1yBbPh3ND8F1Z3+aVckWGYepwVxOkQsaalMH7y2Au47gmOmRgCGzDsM1OadY
	 FeEclIPKZMSxC1a7HJwN8S3YIVw/mZd3mX7h/WmDV1DDV03e2fnfcpPtDSvIjmwtNb
	 TNaMtoOTryiZ/g+U79M1I+FtDC8jgSWSWmOavLP8i7U8+tC6XhLuZMfL5OsTWe0vdX
	 jNP59Se+qbY+std+LStmAHXxeoxJxor7T+0o+cs5eHTVCBkhmuYByAIu5Ib+sX9kPo
	 xS56bVcc3eZeA==
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
Subject: [PATCH 09/10] can: grcan: Reserve space between cap and next register to align with address layout
Date: Tue, 18 Nov 2025 10:21:14 +0100
Message-ID: <20251118092115.3455-10-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
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

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index b0e2367fb163..8753bff4f917 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -48,7 +48,8 @@ struct grcan_registers {
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


