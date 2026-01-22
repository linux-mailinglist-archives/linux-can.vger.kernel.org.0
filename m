Return-Path: <linux-can+bounces-6256-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA0zAbIccmnrbwAAu9opvQ
	(envelope-from <linux-can+bounces-6256-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:48:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6E66D43
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 13:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6538E9789
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954EB42EEDB;
	Thu, 22 Jan 2026 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="c7Yptj0l"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB13B530E;
	Thu, 22 Jan 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083856; cv=none; b=IaqHQTFdODbnpcL6Ox3cgcjHijM5L759HW7GsJx6bkvc54o3xYqrndPSGqqP9GdrhC40IsmEm/UCf2LshMKUlkcs3k0mye277O1EWJMrEoNK1BSYi5kTQueMppL8YymYNsvlxTRCpdbGwLTtG7OjFRP5TFxFtGUk42kVOxSVzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083856; c=relaxed/simple;
	bh=hG5KSuPtLiBtHjq424HSyAbeOdsq1PzCy6qL7NHd2UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgffIjX27oLigRCkp7sMeiQ6O8YsOHwnu34dFZwel7ikqOmAf1FCGJskV49wc6zBc2FGS6YLd1IsHYkHwBe6CCkvBeBjIZdOm8ucwaRSUzP3CpD5APrhG/iP+2DBZD4DuNr4PuQiJbE551sxJhjZXlsAZssDv19WswtRb/4c3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=c7Yptj0l reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzB31slz1Fgd0;
	Thu, 22 Jan 2026 13:10:46 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfz956CRz1Fgcp;
	Thu, 22 Jan 2026 13:10:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083846;
	bh=lDfZgx61aSWUJ1n5uo3C1KLCGawncX5ACzgdlX+fljk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c7Yptj0l/vbaClo29pXsJ/WdqRR/uLT9oFIn3tV5b87uPiHYzi6yHGxGg+/uVJ/uD
	 H24EwpR0K71MpjDjq0P/o8I5WTyX8Rw7XZMuwulpEdk4o6KRmx7iD85WFfxvNX7mzC
	 l87QBiT9/xmypfP+SLb1jstuSRTBqkmJXLUyb7CvVkjuyaKT6Aqg2Ur42Byp9xu5IM
	 TTBJLO3SDfMXS55NkbAi2QIquyWFANcsB0QAywfyKWupQqDHSRsK6nUiZQrbQ7TA5v
	 rSoUSsF0DWi4KEiGWU2tZu6kP429nd8fh39K4dbVKCRaOsXEk49sNX2NdpmlFVRpOB
	 I17SfFIsfS8iw==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v3 03/15] MAINTAINERS: Add maintainers for GRCAN CAN network driver
Date: Thu, 22 Jan 2026 13:10:26 +0100
Message-ID: <20260122121038.7910-4-arun.muthusamy@gaisler.com>
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
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : No valid SPF,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6256-lists,linux-can=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: 6BB6E66D43
X-Rspamd-Action: no action

Add Arun Muthusamy and Andreas Larsson as maintainers for
the GRCAN CAN network driver, This entry ensures clear
communication channels for maintaining the Documentation
and driver code associated with GRCAN.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dc4aa37d903..14ddd48e063f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10706,6 +10706,14 @@ F:	drivers/gpio/gpiolib-cdev.c
 F:	include/uapi/linux/gpio.h
 F:	tools/gpio/
 
+GRCAN CAN NETWORK DRIVER
+M:	Andreas Larsson <andreas@gaisler.com>
+M:	Arun Muthusamy <arun.muthusamy@gaisler.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
+F:	drivers/net/can/grcan.c
+
 GRETH 10/100/1G Ethernet MAC device driver
 M:	Andreas Larsson <andreas@gaisler.com>
 L:	netdev@vger.kernel.org
-- 
2.51.0


