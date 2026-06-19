Return-Path: <linux-can+bounces-7883-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYMrOUMFNWpxmAYAu9opvQ
	(envelope-from <linux-can+bounces-7883-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 11:00:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E74EB6A4CF0
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 11:00:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.net header.s=s31663417 header.b=RK3v+d54;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7883-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7883-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17F513002F47
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48172345731;
	Fri, 19 Jun 2026 09:00:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C235A381
	for <linux-can@vger.kernel.org>; Fri, 19 Jun 2026 09:00:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859645; cv=none; b=nkNV1ENZKS+KzBHFo5cNZ06/MZcmRIeCR+LHIU6rLS7Jg+MiTNH15yuKK0Vgc44EgNPa2tFTlLkm9j5qvb8FiiSfyJxK4r5HBA0fkxVwWIy8jqv99d5l0ELmxp/91xKfUvhM7TJQHn4Iz1B9pMSn5I9QQa0Xh2IS0+ALL0RLk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859645; c=relaxed/simple;
	bh=8ykLV5mIjij2rqmLYbye7VXlF5VE6sZSjELACgMKRhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XAUPe0rlRFIzt3GJbFLJJoAUBN1AjU3YdPJC2cL1XcBcZwaDlsSuktWrXri3sURBHWOCRZsfhPO1ta2IN9ovjelaOj73gkGz5YB0ohcBBem1LT1f2FmNJUqXGf6vUdTZ5QxTLRpfUR4hN54asvP6tFJaEleyeFX4FEfaqRhHMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=RK3v+d54; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1781859637; x=1782464437;
	i=alexander.hoelzl@gmx.net;
	bh=CANjgG16/WteM0fH5vMNo/oqI9nHn3tISHBBUFbolWc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RK3v+d54zDhExSVS4l/JMOQTrI5r10Lcz1Wx+TCmpgzmk2mnVeCTXzycmcQRUoqG
	 CIMFEYyGyq9WaCehDyjh8/uHM9LmNNBckmRlA3eUyq+412GBD1u1UxqMcfVJTD7eB
	 nCPnclISjNJiSpaeC0oszCsuWWIjF3MUd2k9uDTZkxAG0BrIrAx7ls9JC+eHOxrEj
	 hsCPKYikerJgesmkQCdiTmVsCFOqkyPM6BExMkhShawLvIBn6orWxI2VjP0IjdNos
	 X0Y+yL1s75NVIj4d6xEwP/aPmMEulGs6hhdD2blBpidkUuFgS/33vXK4rBOz1+2Pm
	 IkCS67OO4Je8fQGpNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1wiIan1iFQ-00Lasv; Fri, 19
 Jun 2026 11:00:37 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH] vxcan: fix Kconfig description stating no local echo provided
Date: Fri, 19 Jun 2026 11:00:35 +0200
Message-ID: <20260619090035.17769-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3GQcuKveq/E2FxhqXGzmuwjmSsMisly8jq3/Q03UTL59QjqTuP5
 fb1aOcuTnvzfUu1CpK6eII3Xsa+qjUM23HgRfy+nKoTSw/njyQqy94QHqcQiQciHmGf/Oyi
 WEeSwMfpHOwwFoI91j5vVdTnj5OQZP6KvxyfqVRm59FfG9MpWEyMdl7+KyQQ/kATeCT+dCB
 8oxZgQCKg++x3+GSdr4zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:05yHva3NsVY=;Dol+drLICbgLrhLp06N7HQH0y3z
 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
 A35SaGS4OgzWOAr0A81WJ+yOVhlnJ4fMFxJ4hEu
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7883-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:alexander.hoelzl@gmx.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.net:+];
	FREEMAIL_FROM(0.00)[gmx.net];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E74EB6A4CF0

The Kconfig description of the vxcan kernel module erroneously stated the =
the vxcan
interface does not provide a local echo of sent can frames. However this b=
ehavior was
changed in commit 259bdba and vxcan interfaces now provide a local echo.

This patch changes the description of the vxcan module in the Kconfig to r=
eflect this change.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 drivers/net/can/Kconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e15e320db476..e68b5bcee3a2 100644
=2D-- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -40,11 +40,8 @@ config CAN_VXCAN
 	  When one end receives the packet it appears on its pair and vice
 	  versa. The vxcan can be used for cross namespace communication.
=20
-	  In opposite to vcan loopback devices the vxcan only forwards CAN
-	  frames to its pair and does *not* provide a local echo of sent
-	  CAN frames. To disable a potential echo in af_can.c the vxcan driver
-	  announces IFF_ECHO in the interface flags. To have a clean start
-	  in each namespace the CAN GW hop counter is set to zero.
+	  To have a clean start in each namespace the CAN GW hop counter is
+	  set to zero.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called vxcan.
=2D-=20
2.43.0


