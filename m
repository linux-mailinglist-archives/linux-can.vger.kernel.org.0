Return-Path: <linux-can+bounces-8002-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HlVbEvsFS2ogLAEAu9opvQ
	(envelope-from <linux-can+bounces-8002-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 03:33:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E070BEE5
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 03:33:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fjG8GY+P;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8002-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8002-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 252AF3001FE2
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C4B1EEA54;
	Mon,  6 Jul 2026 01:33:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC47175A75
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 01:33:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301622; cv=none; b=XeTO8szsZK8gdHAEgtkZ2GH7oj72yavYiOkgcY6hgqg43FlUDcdbfEJ2xJ2R9pp0BHL/GBhA5Yb6LwLisAEymCR4q7LV0u7DSElyj5FdPvO1CKxa+L7lULuFKJx+aNudUlKqM0sws1G996qge9MwE9Bvy2vipFZ2Lavfgxk3sT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301622; c=relaxed/simple;
	bh=lMO2qkJ2/muvyHs+GtY/dK5mTATd4Yu4Q7K9tJ0DNA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATZXAqaiGnklhnmgR3oEr2bjt8fVxwf3mP9x12m1x10lxYuht4CJNi7adeGJRjit7L8OSuPVmqdefcxx5cRR3tBD/ZjKm+2zRZlogbgYdRmpEJYuiLtvrXpQ1HM9xvVxg5DDxDHosyX+UXZBdK040/dAiVMFFpe58h3UUeIK6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjG8GY+P; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f236418so1393081b3a.1
        for <linux-can@vger.kernel.org>; Sun, 05 Jul 2026 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783301620; x=1783906420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jreECMEQiShowkS9piQE/YnsH0rmBC8VLhOIRsTmMP0=;
        b=fjG8GY+P+Sd6ERBCiwm4alhRhoQIMKq2Kdh0JySVMU5GUNpy1z/cNhSnVrrA//U/Gi
         x1vbmf6OJyimM0of64djy0qUQ1CCEb1bCyQpewJtoXNXIxascFSxGGr3AiUBlZScZDzT
         Q1QH/FA8dIk6xDt4Yl8qhj2zTgfPOXI9IlYfZ/gXsv3bCIFk2EC5b5dAoVptYwRaxGgI
         S2Gmcq1QzsFjaLcGb+/gGKAtbN4OpePTjCe5CL6wO04zBipFLUA5yyputqJ+WD7fOW5i
         pLDIW52Y7X5deMgnv40qMopXUuYVrRRhEPVekx1L0w++rOrlNs0hrqSIl72c7hE5z4Ux
         tdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783301620; x=1783906420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jreECMEQiShowkS9piQE/YnsH0rmBC8VLhOIRsTmMP0=;
        b=HFl7NVVu+EtnfQha3JhEvpV5WVk70z7gVqIvj4ajuVuEk44R5VQrVMN1cgSVhzMHDB
         S1hIS939W0JijIrMz/WTE/AmMFpKmAE3way6A1MGIBtxgMoWfFpojFuV0xm+UKw7TD/u
         MbD7x7pBVADuR98zi0j8H3E8VcmMhqIhEqohU8QSZj+TEyUK4MAZSSFrSVCNjkZ5v23J
         aa/dZpdfOfgEFQDnefLRR+qbfHb5w1ZUh+J1ucSyQttPRkFLXdfjpXxCrLVCIyRLy2LH
         33y4+HHJMZZeLm6vCsXBeDfO0qBNPgnnnW+cAoQz9ZBmRIO7OR/eRb7ihvx9WQKuku2q
         iCPw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6fRxWwcIg1TB6SzPkL9hIs+9Jr+CN5eh+b45VVqeqN4oUgbwB1XSdsoFcV4RyER9mnhebKTv8vjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXxPZagc6w0EFEIQ9QA1a5UnRdTwhY4pMq6arm8/EIgKoUhRb
	CK88M9A7YJGt6eXEMOYsRuf+AqRjvkD4ud7kwOXCLCpuPP64lcWwGJsR8zbv2slQSbg=
X-Gm-Gg: AfdE7cltECchoDycAmXxAOZSOiGAyIjPBgp0uFCqxH6kXEA92sxR1Og8ojF9YLG4AlM
	/JfsmTLdQCzwFG6mC2O44vfSLWt5LYDmDQMPtSc/7b7J4erZ6JLlU1K4aIFb2Bh3acbCyH3DPZJ
	wKZN3oEyq4M/xgtQvVrQvBsTlnu3c6segF/bGC8L6ZA46c713xRXGqUgqY/sKdzhC6/XeNZob6b
	CimPeSYyg7jQKG2+QvZSqwuw3bs3bbSG7xIxd0KOuqdgMKVoq1wizTbgrrj5GtQ577qG2sA0RNG
	cfiGj04NiLtPSPy0rMzvNEQrCkw6o/uH6mWKsqX7FvnC9KIvlCthN36+6GSoJC2QTvtKllnLO5+
	U+BmR/bYkFXaCiE5SsdPhgO0q9Vmv/OUChlp/324jVRw/0gfztGjhm9ckdTxU19W2QoM1hDme3o
	jDdY0=
X-Received: by 2002:a05:6a00:428a:b0:82d:62ed:b01d with SMTP id d2e1a72fcca58-847f6f474c0mr6953470b3a.45.1783301620471;
        Sun, 05 Jul 2026 18:33:40 -0700 (PDT)
Received: from lgs.. ([152.32.214.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d76106sm2823159b3a.40.2026.07.05.18.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 18:33:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v2] can: usb: etas_es58x: Fix RX buffer leak on URB resubmit failure
Date: Mon,  6 Jul 2026 09:33:22 +0800
Message-ID: <20260706013322.360792-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-8002-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D72E070BEE5

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
 drivers/net/can/usb/etas_es58x/es58x_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index da12a35dd2f9..e1724ae79c5a 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1476,7 +1476,6 @@ static void es58x_read_bulk_callback(struct urb *urb)
 		dev_err_ratelimited(dev,
 				    "Failed resubmitting read bulk urb: %pe\n",
 				    ERR_PTR(ret));
-	goto free_urb;
 
  free_urb:
 	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
-- 
2.43.0


