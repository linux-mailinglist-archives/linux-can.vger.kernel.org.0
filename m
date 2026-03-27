Return-Path: <linux-can+bounces-7263-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLQwE+Nfxmm+JAUAu9opvQ
	(envelope-from <linux-can+bounces-7263-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 11:45:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E9342CE5
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 11:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F248330247C1
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 10:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7E4342526;
	Fri, 27 Mar 2026 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toAOcOYj"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901D322A00;
	Fri, 27 Mar 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608351; cv=none; b=i8yt7FBuyvhPZl6QmFTIhltyrYy7GU5edDQLy8cD+oekUSCghRmnLd2jYXTXgpwpaOYiwp410B03xwkjPNLyeimnnCVSyjsHxr3y0wCq1mKX5wx/bOAhWnVLjpMFRSVe2LFT63fd/FHAYgUbicKr6Wla6uo982ob+Br+XgMNU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608351; c=relaxed/simple;
	bh=VSVTgCBIhcWB8wQW4sPVab2dZEDNTik5aRP5r8Y9blo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7ncfk1ML3XInbiJEpcpLjdzKxl3wXdTkdHybroaI195B9YKT2ROpWiW9vE4nLEo3WFuNABJ4Qn6jZBSKBfAm5+5V8+2+G6HjByP7tdAL0yzWZ35xaUF10B4fbTL6Z67DqCcpAPIXW12i36GkhF38c2LBRRSFx+0RAwVbVtQOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toAOcOYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8693C19423;
	Fri, 27 Mar 2026 10:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608350;
	bh=VSVTgCBIhcWB8wQW4sPVab2dZEDNTik5aRP5r8Y9blo=;
	h=From:To:Cc:Subject:Date:From;
	b=toAOcOYjgXMJaofkINkl75xkd5tjXCjjCX8n0tbF2x+Fdy4lZK+igLxmKDHD/zitw
	 CcS5ZX+rL1z+sjQuTUNMaZbPGfhUcyZfjIeCdLODIXjtMMDMAVM88/OaoAtTWI9PRJ
	 gKHAYj0a6TRZpkIwRmsLEwOr5PV3RkThrGX60iM+j0mUnLJEe76/qEvVhFYqagMkJ7
	 lXQe6BJXM3AMU9oZIOXpm53Wh1i+IsoVo3qKKVPU9ENPIa6dOR11/vGZMb7Xa6W96U
	 /kgAE0NlhArg9FaMA3UD1Y6kB4gJjLc+VdEXM83xMOEYZURTPE/IeE/UbfraXHyrTV
	 xV5fkwZ7yi9bQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w64hI-00000005UqH-2CqT;
	Fri, 27 Mar 2026 11:45:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: [PATCH] can: ucan: fix devres lifetime
Date: Fri, 27 Mar 2026 11:45:20 +0100
Message-ID: <20260327104520.1310158-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7263-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,theobroma-systems.com:email]
X-Rspamd-Queue-Id: 889E9342CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

USB drivers bind to USB interfaces and any device managed resources
should have their lifetime tied to the interface rather than parent USB
device. This avoids issues like memory leaks when drivers are unbound
without their devices being physically disconnected (e.g. on probe
deferral or configuration changes).

Fix the control message buffer lifetime so that it is released on driver
unbind.

Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")
Cc: stable@vger.kernel.org	# 4.19
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0ea0ac75e42f..ee3c1abbd063 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1397,7 +1397,7 @@ static int ucan_probe(struct usb_interface *intf,
 	 */
 
 	/* Prepare Memory for control transfers */
-	ctl_msg_buffer = devm_kzalloc(&udev->dev,
+	ctl_msg_buffer = devm_kzalloc(&intf->dev,
 				      sizeof(union ucan_ctl_payload),
 				      GFP_KERNEL);
 	if (!ctl_msg_buffer) {
-- 
2.52.0


