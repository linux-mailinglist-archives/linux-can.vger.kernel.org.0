Return-Path: <linux-can+bounces-7864-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a/Y8CM+SMWp9nAUAu9opvQ
	(envelope-from <linux-can+bounces-7864-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 20:15:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 157BC693F70
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 20:15:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dpBerd18;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7864-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7864-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 241D63001CCE
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A25F47AF6E;
	Tue, 16 Jun 2026 18:15:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD447AF5F
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 18:15:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633738; cv=none; b=sCsvJ/+XRrI8kMb7C8mO5Bntq4No1jrIWut6qKu5NW4/Y6ZSea6DJ8gj9Qbuz98waKL4mlUL7Kj1dknv+RV1rroSzj2/o9uARNcZaNz64xsY9hlBYewfupIKUsHBGWWEbdaN3NCHPHYfin13U6WjCaod6A8BT/FzmwtDGh5rgRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633738; c=relaxed/simple;
	bh=LwUjBCnRuhBhAVA007wGKMdFcjOoYCHu8co1Nbm+o4w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MX/aHOC6ics1zg/OuQRFfq15yM6PqbubT9eswb7IKqxAVWqFZwdiFy/csMO38Jjifk2k44+ink0VcjVp/jYoYq++OMgmmsFwSpMBcGY62x0RBlchZUyjL/FNenvV3GJWCW3znktFAD+E/CrKjdfJZgpTaHaYBq3ax3PtNRgGfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpBerd18; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37c5b9d42efso73818a91.1
        for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781633735; x=1782238535; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2CbO6xVE8ge/BW9bwE8msWNErqe+u3t/mZz4ScB7rc=;
        b=dpBerd18k4xbc6sIGCoDGKz1uhxfX4iiUt89Nezt/7lhIN9o0sG0UsYSFPI/c/ezkE
         rMdGsLeaMduur9esdNQkoFPbCPv2jmRWAHa01Xtopj5R4AovLYSQW27IbqJ3sV9QnR5p
         KXkrJ38Kk4yUpnLdUKxTX5Bp5PRjNLTbhgud3HE2WMrtrPrwxOc9Vgp7mMbVOt4we1N9
         OcPyeL7IAUCI5jUvMCPijppKF8yCXyWLAZ9yZ1/7LZoJKZFg8Ct6fXrE0LwG3xGUtaHF
         2PjcZ9q60WT51OaeqsKlyP8tk8z34xfiqiugFCdDhDMUqQpPWRpXLRFgBYjrb8pcg0D2
         Hnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781633735; x=1782238535;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2CbO6xVE8ge/BW9bwE8msWNErqe+u3t/mZz4ScB7rc=;
        b=EZFZh+F3QGShA9cwFjBtJKq5z5xfH7wd1jkU1553eh+PkeMWc/g0HUyzbP1vyqqRRx
         BYHg99YyNPPjbmgh48tmFkV+vxFIqUCmlwVxEgL2ALguENqQN50x6Y2/JB+tgMd8nCio
         1fCfNWMGWrGyQj62qukxlPSxcKWEuRipkLypmCQ6k6XhT7MXF0sODM1eXXVGLphX0yHF
         qEWjZN6hkANhrOoX9b/dJVT4DDhnYpNKXHXq+xehfNdscZ1lTxPMpBl02GNVsFk1gJ2u
         HmxxMHKD3Lq0AuHgsAhKdtJSbcDaey/MeA4KBa9VTAdpSitx0hfUNc80KyFGVbobJ4nj
         +6DA==
X-Forwarded-Encrypted: i=1; AFNElJ9rzIX1sSI/8QXzzV5S1YZsG+hKqG9hDxDugFAO1RhGhN5SC4KcgXbHYQbryrmfgliaPI4iKL0Q0OY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mN3BAzdB8uY7tqDXpp1czOF9muybxEZw0J2lUrNwCZB7myI/
	UjDjI5hjrDdF/evkQmoZZIxZpE5sxUnlJ0s1aP2dJ2LDvX7dnHCMSvwa
X-Gm-Gg: Acq92OFKGWPOGrWnNiH1JwZVA6Jsbzzwl7R+A9fuSpGUDKmO97+CyEMc+iL0LWklu8c
	Hnlltt/tac27nEpzZ3N3LYuUsPAo84MLjCvdszA53dW0Gq9s3H5hTB4wq0kt2QNlwvhjXinT6Ib
	0jTN5+txQ/2pbHSj/d/WzOMrhSxca/QEG1JrLiPzy2tOhl8vprvr3nIC/f83a3jm0vzT8q+ws5m
	baMaGCAsotr4sTWeTSdKkjJTNlUqk20qH2fv7U3wREAd9zeyXj9B7C6m2IMgV4tQMfhh/nDMA/2
	bNucPhWs4SsBtGYF39jE0MvCNIkI2xxRu/jq4RgAcqJKk7WpJYndVjf+ynivPMfoPcNSGvx1KTP
	KIUpwnrDeN70uWyXeb/+gv7prwO8pll7UEjOgNY89IaNsUu/ZWOLRK/YXegIqcipEHDsrIFo+kY
	Rq3wHkOQPLsK5SFYRc9JECp6/tXhEn3egqnX2Y8o5l2s7DyVcR
X-Received: by 2002:a17:90b:3b8d:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-37c8e7ebc02mr498888a91.12.1781633735182;
        Tue, 16 Jun 2026 11:15:35 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae78csm3578034a91.4.2026.06.16.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:15:34 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 =?utf-8?q?St=C3=A9phane?= Grosjean <stephane.grosjean@hms-networks.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] can: peak_usb: fix double free of transfer buffer on URB
 submit error
Date: Wed, 17 Jun 2026 02:15:31 +0800
Message-ID: <178163373110.2507866.216458825145756798@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7864-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:stephane.grosjean@hms-networks.com,m:vadim.fedorenko@linux.dev,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,trigger.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 157BC693F70

In peak_usb_start(), each RX URB transfer buffer is allocated with kmalloc()
and the URB is flagged URB_FREE_BUFFER so that the final usb_free_urb() also
frees the transfer buffer.

If usb_submit_urb() fails, the error path frees the buffer explicitly with
kfree(buf) and then calls usb_free_urb(urb). Because URB_FREE_BUFFER is set,
usb_free_urb() -> urb_destroy() frees the same buffer a second time, a double
free of the transfer buffer.

  BUG: KASAN: double-free in usb_free_urb.part.0+0x91/0xb0
  Free of addr ffff8881069ccb80 by task trigger.sh/285

  Call Trace:
   kfree+0x113/0x3c0
   usb_free_urb.part.0+0x91/0xb0

Drop the redundant kfree(buf); usb_free_urb() already releases the transfer
buffer. This mirrors commit 03819abbeb11 ("net: usb: lan78xx: Fix double free
issue with interrupt buffer allocation").

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Closes: https://lore.kernel.org/linux-can/178159320216.2154888.16953451793788581739@maoyixie.com/T/#u
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index cf48bb26d46d..079b23dd74f0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -470,7 +470,6 @@ static int peak_usb_start(struct peak_usb_device *dev)
 				netif_device_detach(dev->netdev);
 
 			usb_unanchor_urb(urb);
-			kfree(buf);
 			usb_free_urb(urb);
 			break;
 		}
-- 
2.34.1


