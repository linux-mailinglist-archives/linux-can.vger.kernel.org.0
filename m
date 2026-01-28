Return-Path: <linux-can+bounces-6348-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GvdLoIjemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6348-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:56:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6EA3583
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA3A4306EE19
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CC35A933;
	Wed, 28 Jan 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ABOjyo7Q"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8A2D7DD9;
	Wed, 28 Jan 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611771; cv=none; b=PGmfTGklx+XjfhXejWscuY/fHJJDZNqG/2ag+axT89MZX6yfcAAjAuuNEtOBD2Rsjy+Net6RCOTzSSKN7ijOK2KvK0hCKzqf/jOlmz17dZemo4Do8rSxfe0c3JPv5/XXp6ZDOlPL8oWb14z/yywq8EFE3wTlz09BWQv4fI7Ekas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611771; c=relaxed/simple;
	bh=hG5KSuPtLiBtHjq424HSyAbeOdsq1PzCy6qL7NHd2UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcHaH/5bSO59QNG4VDbqPwHnezdLdHnI2o7lMFANDeJRDfz0ddFrnIlC1pNQUnArLvrtoJ0Dmk0qmQALIWOpPWx2wGF+/t4cS/bX1DgmX8Ox9Ur4PSyMASG1vQL3auRULQmBzzzlkQireuRIi8e0/dt3FU1OAFQ8HaMKuknIgU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ABOjyo7Q reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCW5Fs9z1FQVL;
	Wed, 28 Jan 2026 15:49:27 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCW2wNDz1FDXy;
	Wed, 28 Jan 2026 15:49:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611767;
	bh=lDfZgx61aSWUJ1n5uo3C1KLCGawncX5ACzgdlX+fljk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ABOjyo7QCcN2HGH0fm3FRdny/3vvaVZWTkqL4lqQhBzoCM+DhDuqRpDWeXIJqNp4+
	 UOhuoArUJRZqkZmAFSUG/2pE2c8JeapbHNeYDnBWH0ScylT6OHE+d0B0OicLywx4X/
	 Z4YbLblIGRV463eByBUoypSLPuO/ZceHOfpg4M/jZ5pt8rgPB3GN+2EOdnMNNoYjZT
	 JtLY+frHPZSRfcbJZMAo9FI2r8MvUpZPFrccokFnxRL0fvnc7JOQ5w4kVzOgEvCgt9
	 pF7Vi0fS2s+Pmu5LzOR7RL8xaSPdc2Vz7u44vWO8SVJEwaIVJA6WryFdYsJJn1UYAw
	 sT6Iht4IGvg+Q==
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
Subject: [PATCH v4 03/15] MAINTAINERS: Add maintainers for GRCAN CAN network driver
Date: Wed, 28 Jan 2026 15:49:09 +0100
Message-ID: <20260128144921.5458-4-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
References: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6348-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: 2DA6EA3583
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


