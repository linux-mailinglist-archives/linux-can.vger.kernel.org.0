Return-Path: <linux-can+bounces-8003-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lRt4DqAJS2qpLAEAu9opvQ
	(envelope-from <linux-can+bounces-8003-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 03:49:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E1470BFB6
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 03:49:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EUsN8KTw;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8003-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8003-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2232E300A7E6
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 01:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179537C0E6;
	Mon,  6 Jul 2026 01:48:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECB31986C
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 01:48:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302506; cv=none; b=EDlf9ghLAekSBFN9+LhYdKMOuXgPs1PoEFlbfGTCEYMIX+b2r1Qt4txJs1/WOXZ0qsTIdvi3aPFbnM2KhiDaT7iSgs7tL/fWT7N9IoyeE5f2HxfbHeZPNyx3NG34asjqBZpDNCtQecCa5JO9DyftphVMkAws8xt77hzU8VGs8og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302506; c=relaxed/simple;
	bh=KYj7zOd2O8d1m5PjjympWJGMKsel6RN9WHkUQo5FhEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mt8iEkCY8kQTCJmkQg70ZoHS1szRMvM5F4PYkvQ3Dg/Vimie8+xUd9Jh2nLDXP8EMlZXOMsIul1tJ7QQG8nV51tPEbF8hlheT7Sjcs8Fu2CqsOAvLQ3OSgVIkIOSHZxC46MbeO2HYl1c/S9cuBUV2290TeyzNWQv7O0/90Purf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUsN8KTw; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8454160043aso2385089b3a.3
        for <linux-can@vger.kernel.org>; Sun, 05 Jul 2026 18:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783302504; x=1783907304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=866Vhq4TH5S1XsLtiE/a+HlLaZeRw/Uowkrpcrs94iE=;
        b=EUsN8KTws25uY9OSxIEQlQMIauN1uQnjU89Z5GfA4dB+CvdypLH4S0D+o5C24y0okk
         rgTCoIv5r+uzDqRh44780HWz/Ht0RLLjiyHnMz2a0sNBacnVN6mXfHdZ8zhw5Tu4WHZc
         KUPHf+ouiqcGzgsEMXVEqp+dXrREPmj4nZx40k+ZVjatWhEd/820C78H/uBkiqWZ3lC8
         l3anBvxjPOiZ48YfwN8uTdoE4xdZD7IzRKuqrLCGZ0pu46hw+YVBVWZw29LR0TTkCpEf
         BzSx50q9UzxVf/jIeXjNTjjKPDUZJqc6bn3J9A2cfw3jTFKpOAQbDLD/ODBbXXrISyQg
         7aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783302504; x=1783907304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=866Vhq4TH5S1XsLtiE/a+HlLaZeRw/Uowkrpcrs94iE=;
        b=JDh22SJedaV+n0MbSizLtzPWJaccrmA2xBQspN/5cSAHHUcjqDj2r4iwoM88ucJxl5
         wb/4hZNDgGJ0rUxNTqSCXNocNCWkj0fvhJoolAQykyz0Uh2ytqHEfVAl05MHkSG9em2D
         dNCrUOhNUOUadFS37HvA/TKij0fiXRIwT01I0mMOHjrkyfNghmo0Bk37AUA7S0ObUOd7
         tPwvFaY/K2Cybnsr7smsjbGe5+vQBToVkrz/6HYs0FHFk2rkjiARaV31r3TGnlCU5Gfz
         MykjzO2NJhq3UOhAVBRnpr1bmmhNXf/hecRruywB7ssywBgSvc6Yt6bQHUX3Cw4Qf+9x
         UbBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRmIDEqGnPTyKd84qcmopH3ql7XniggCYv10Hily225k8KUZQ8zR9gfnqr9P+tNMC1mNNu+XHUXco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Csa1fuBjMqztqXbdvUL7642k3zz/A8nHnDsecsl2f8I5QFj/
	C5yoc1ObNrt4E5GE8qOuWDu410dHvnA5C75ZLSidP82ySZTmmrcjX4J+Gw8GhfgVgaY=
X-Gm-Gg: AfdE7ckGpk/E0OAGWMPkpC1mxMHvgL5BLxGvUaNb+R6Hwo/sxclxiwu0lbrPXtO2lF7
	laQSJ7bI0Xl+wmmOhib5ACchs+WGgiD0rIsmF00MIQsw4+9HcbOb5JLo4hCuMNOvfDwHexOZ2sA
	Vfxsb5sD/k2LFGm/pwbKTDEH/JV6xHPLIWe2CJIVhqLSY7o6cWnRUX5pvEC3hJoSAWM9AA1dCzQ
	u0eBMjBls5lKQpGb0DXQiPFmUdonVlJR/B7eXY1RHtEOC9USLVOkxjsBLP2Xce2tnvD0SWdq9lS
	hS9iD3Uf7Anx3IuxYOGGHVbb/2PJ0wUoCad2nIk460B1mKru1adEP5RI1rsmnNxyOCaAvRaKl6S
	THQvF8w4M0uGAiKLYuw/hEfdNmLUJ5duf0+qQGh3I0mpsHkBh/DKMaJPTPyfG3O9SN44R4GI=
X-Received: by 2002:a05:6a00:a1d:b0:847:83bd:6676 with SMTP id d2e1a72fcca58-847f6dd39fdmr7486553b3a.17.1783302503847;
        Sun, 05 Jul 2026 18:48:23 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d49614sm2803285b3a.35.2026.07.05.18.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 18:48:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v3] can: usb: etas_es58x: Fix RX buffer leak on URB resubmit failure
Date: Mon,  6 Jul 2026 09:46:01 +0800
Message-ID: <20260706014601.415445-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-8003-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mailhol@kernel.org,m:mkl@pengutronix.de,m:gregkh@linuxfoundation.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3E1470BFB6

es58x_read_bulk_callback() resubmits the RX URB after processing a
received packet. If the resubmit succeeds, the URB remains anchored and
will be handled by the normal RX path or by teardown.

However, if usb_submit_urb() fails, the callback unanchors the URB and
then returns directly. This skips the existing free_urb path, so the
coherent transfer buffer allocated with usb_alloc_coherent() is not
released.

Reuse the existing free_urb path after a resubmit failure so that the RX
coherent buffer is freed before leaving the callback.

Fixes: 5eaad4f76826 ("can: usb: etas_es58x: correctly anchor the urb in the read bulk callback")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
---
v3:
  - Regenerate the patch against the correct base so it removes the
  original return statement instead of the v1-added goto.
  - Add the missing changelog. No functional change intended.

v2:
  - Remove the redundant goto and let the error path fall through to
    free_urb, as suggested by Vincent Mailhol.
  - Add Vincent's Reviewed-by tag

 drivers/net/can/usb/etas_es58x/es58x_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index b259f6109808..e1724ae79c5a 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1476,7 +1476,6 @@ static void es58x_read_bulk_callback(struct urb *urb)
 		dev_err_ratelimited(dev,
 				    "Failed resubmitting read bulk urb: %pe\n",
 				    ERR_PTR(ret));
-	return;
 
  free_urb:
 	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
-- 
2.43.0


