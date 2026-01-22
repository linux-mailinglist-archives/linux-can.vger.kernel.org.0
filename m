Return-Path: <linux-can+bounces-6265-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jt+IwckcmnhdgAAu9opvQ
	(envelope-from <linux-can+bounces-6265-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 14:20:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B50672F7
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AC095EC37B
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628944CF23;
	Thu, 22 Jan 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="N0es4UrF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8F43E48B;
	Thu, 22 Jan 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083862; cv=none; b=YTMTBHQzzxIVru3bPcV6LUv2plpQZ4FbCPwO8ZIgMYNuEWB4mwBjUeausJEzM8XZyWvrzi2ut0YrodAde50q3vamAY74CErDDayul4XTl+Hyn5on27Eu15qmWc4qEXGzEgC+wWjv86kzKkAgM5g1Ken+Yp0BfwrgTtRLGQUJUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083862; c=relaxed/simple;
	bh=ntLjzCp65tIxL92OBrl6hc1EQJAsMAfVCAnEiXcT5zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ij9St2q1CvOXKPWbjR9nxvaqCrTnf16WDeWtazSBcf8x6QWfMu696HExUD6Vcx0ScNd9fGBJRVtub/6I4IiSaGMGY9gf57qUoEXa7rmSS6/QbsueY3d0j2WJRQ7zUrQMeLA4i0yEQTGmBggRC5QKFsR8NGMxGTQYMGoMwOt/CH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=N0es4UrF reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzF5n9Qz1FgdH;
	Thu, 22 Jan 2026 13:10:49 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzF1GQyz1DDC3;
	Thu, 22 Jan 2026 13:10:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083849;
	bh=nupmb7DwN5GSSfjG2VlctIMK0Bsqy3N15mv4BCL+2aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0es4UrFjCHccec7Br0nj90q1NRZiQTOeG9CCQQq/ZT684PY5euIer2O90yjHaDZ/
	 fNcL2GbHP4NNxkKbuBqMcaF0Km/Ro7mk9ORg81gK4XT9Sg0BXt2tdM5+xGTwXoi8in
	 dthvu4TKHin9HgOk/smUUzX1XoiOpLS+J/LOVRidMdwoBF+DBV7h5RW4ntWrH5gtOH
	 IKUttCYYyMkycihydfdTM9sv9Z4TKdF7PlOwNZtnNKu83qC0DlZ62CPVz8BM1tyaNG
	 SVn/N/C60vKHLMenNx+4cHayApLitE/mXx3C67ThFgKkfHfnzdZFwNz8KhELRx/zE8
	 YjtisUYR9dBZw==
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
Subject: [PATCH v3 11/15] can: grcan: Reserve space between cap and next register to align with address layout
Date: Thu, 22 Jan 2026 13:10:34 +0100
Message-ID: <20260122121038.7910-12-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : No valid SPF,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6265-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: E7B50672F7
X-Rspamd-Action: no action

From: Daniel Hellstrom <daniel@gaisler.com>

Reserves space between the capability register and the next register
within the GRCAN driver to align with the hardware address layout.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 0ee6e9bfbe7f..e99a8c2bffc6 100644
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


