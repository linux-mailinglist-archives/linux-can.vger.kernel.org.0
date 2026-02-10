Return-Path: <linux-can+bounces-6532-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNM3IiqtimnpMwAAu9opvQ
	(envelope-from <linux-can+bounces-6532-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 04:59:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB1116D12
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 04:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D561B301F7A8
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 03:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20A2E7F2C;
	Tue, 10 Feb 2026 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="rAAsRLm9"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29416280329
	for <linux-can@vger.kernel.org>; Tue, 10 Feb 2026 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770695974; cv=none; b=j+NBLlezKkegwQUrM42ge7Dk2Qw5HegloHC1fVsO0fZ3OwzA5Vn1t+56SEVf3OnMNv5WxQ/o2UoR6EV4xXJuf6geNf6VV1V8/8njQv7Z4i1Z0pzKvDDY1Pahn6hC43YWSGB19X8eIo8kc4HgEvg2/2egP9U+GU2KUpmc+Wet2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770695974; c=relaxed/simple;
	bh=CaLRQGDtoDAMVEGVQgSbj/4K3469J4TgDR0REJBVcu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmmurlKbTMb+wL2Dqy4QNk7ObIcL63ClP6Z9fdT3g0ZANEP2QigM32KgXh2ImN7FB5YV4gI+8n1U/0SEDy3B5SW2Tw7R/uwaY+h29Y0TmYnXNs3vF7cV6jS9gEBAuugFcrTxiKRBBzavw19oVl9tfcUANXgScrp+bHCVIWpQ/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=rAAsRLm9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-896f6d4b6c1so27852056d6.2
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 19:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770695972; x=1771300772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpf1MFkXf0A2Zb5z4XixNkuKeokSbhH8docqD8c0D1o=;
        b=rAAsRLm9jd5zGuxE7IRxpY70+FzVNB7fzAwXmJyuZcklTlOeGSEygv/rzywjGSNxlB
         HZfh21kfHFqykDw9irRR+lOBO5uvwxvMT9IZOij/wE0/g+D8Onpd/J4l8ksM+LAPrNtJ
         dyIK9TXawJsdIWrElX3GXUz9gE5Va2UNHOCbwsusv3cAYEBKYdIAkdAgu+zViUPeS+Gv
         DazsxJ91zm04fa88dC75BbwOJpyPIniuQIpFNsUh0sdl2U2EHA52w68t1HWJqAA2a8gx
         DakNlIpb20h4gXRLkajS6OozZZEHlkgVYK5pPsJpOHdF/HLBkYo4wqO9xDqfofkOxwNC
         Ng0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770695972; x=1771300772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpf1MFkXf0A2Zb5z4XixNkuKeokSbhH8docqD8c0D1o=;
        b=DgJZQg2zcsFa9DWgTizhj4HgUwHQCkn54N5GCYJW3zFeQ2G/s5ZUqR2hyaAOt5n1bo
         6BVPqxWAueTSYqSpJKnBbwUxU/sVvn3Nrnew/LemTdWc7ivs6v7u1ccwqU2ERhmEuyWe
         YAf4q4CyoPKb3CDGEjezCbNT7B6WiRtMii4P/FL0wC7o19caVWcG5ZM7h7b4EK8R3+oR
         a4fHXsrSKS8n/VwKEPDZk+N4gyTu7/XjkNDKXkp9ZyTQwLkFB4UUCWqjiZLfUbSp161f
         AFPsG88ldQfkK5yMofRCASLGw0y2OR6fCUcyHXPcFhEQxZFHVZFTuBkKdPfIfn/X+YG6
         LgIA==
X-Forwarded-Encrypted: i=1; AJvYcCUGUQGWon2pCZHBMWbXY1BFguWpLaM7dQ+ohCVf0e4TJBHO/+1LMAnbwYBWKR69LgHzxTGRvwKI0WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykGj0JbIPaKVBCS9xMCZ7YslLdPDFEPdl+t//TCndosmC5Wsf
	Em1zys+/6YtpEv8f5SOaI/6B72p7Sl+E9mPtNzZhbjticSIhzikoDQzFMRjKjntF9Qk=
X-Gm-Gg: AZuq6aKXBaVEqz2AhBQonNeRL1ge74e9pFgIKrdcqQAQXz92vBpVliykYmFHX7SoJfZ
	uj4+apl+5I+iymZ0XtZEA0E2oZ/ddlYbXS+OjL83ig+oVVYNYkzC+1VuhDJ1PnGyuSA6JJHanzP
	U2MqphUm0ZgcEJLnI00LWpr8Uxp6wmjLDUJDuRxR5xp8ztNgrLMAQg7OWZtLPFSg7y5yy/i6N8B
	GDLJj7kT45J2ib4qfGaHEfUFF3OEE0nnjWJHySleRLtmh5Pf/A5tXW67q7Rc3CvwJ/ZD/FMWpvl
	cYY+jboSt9+SzO0SdpGvIKk8ZY9GR4vA6NvC+G8u8V/wFyRWaYvpz4Kep0q4yQMvOrnhxIliiqC
	TZBBvQ+nGcCwuxFzSqbSyY1+8NBIgw/ve4vJ7f14K8zXUjQYLzA5RubX1WE0jTHI9cCtz6vIgUc
	3PDYSVz0soxB1PbMKbjtnu5qsxF3DBqGIg1wc8CPjcv1Stev0LXU3IF3RTcjZIMSz5av3VVMcUT
	GYf4C7wRIJik7d7BtuL/1lHtUt5Piru3bXGvoMjICiwXL4e3fOCyA==
X-Received: by 2002:ad4:574b:0:b0:88a:43bf:b279 with SMTP id 6a1803df08f44-8970e515d3dmr9855216d6.33.1770695972160;
        Mon, 09 Feb 2026 19:59:32 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a16558sm939193785a.27.2026.02.09.19.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 19:59:31 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Frank Jungclaus <frank.jungclaus@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	socketcan@esd.eu,
	"David S . Miller" <davem@davemloft.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] can: esd_usb: add endpoint type validation
Date: Tue, 10 Feb 2026 03:59:29 +0000
Message-Id: <20260210035929.3490155-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6532-lists,linux-can=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F3FB1116D12
X-Rspamd-Action: no action

esd_usb_probe() constructs bulk pipes for two endpoints without
verifying their transfer types:

  - usb_rcvbulkpipe(dev->udev, 1) for RX (version reply, async RX data)
  - usb_sndbulkpipe(dev->udev, 2) for TX (version query, CAN frames)

A malformed USB device can present these endpoints with transfer types
that differ from what the driver assumes, triggering the WARNING in
usb_submit_urb().

Add usb_check_bulk_endpoints() before the first bulk transfer to verify
endpoint types, rejecting devices with mismatched descriptors at probe
time.

Similar to
- commit 90b7f2961798 ("net: usb: rtl8150: enable basic endpoint checking")
  which established the usb_check_bulk_endpoints() validation pattern.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/can/usb/esd_usb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 8cc924c47042..054ded490eb3 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1301,6 +1301,10 @@ static int esd_usb_probe(struct usb_interface *intf,
 	struct esd_usb *dev;
 	union esd_usb_msg *msg;
 	int i, err;
+	static const u8 bulk_ep_addr[] = {
+		USB_DIR_IN | 1,		/* EP 1 IN  (RX) */
+		USB_DIR_OUT | 2,	/* EP 2 OUT (TX) */
+		0};
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
@@ -1320,6 +1324,13 @@ static int esd_usb_probe(struct usb_interface *intf,
 		goto free_msg;
 	}
 
+	/* Verify that the required bulk endpoints are present */
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr)) {
+		dev_err(&intf->dev, "Missing or invalid bulk endpoints\n");
+		err = -ENODEV;
+		goto free_msg;
+	}
+
 	/* query number of CAN interfaces (nets) */
 	msg->hdr.cmd = ESD_USB_CMD_VERSION;
 	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
-- 
2.34.1


