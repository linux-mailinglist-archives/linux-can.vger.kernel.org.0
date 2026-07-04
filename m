Return-Path: <linux-can+bounces-7996-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hmgaDxg8SWoFzgAAu9opvQ
	(envelope-from <linux-can+bounces-7996-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 04 Jul 2026 19:00:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AED2770804F
	for <lists+linux-can@lfdr.de>; Sat, 04 Jul 2026 19:00:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=H26nB7E+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7996-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7996-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEC133006B7B
	for <lists+linux-can@lfdr.de>; Sat,  4 Jul 2026 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A35374178;
	Sat,  4 Jul 2026 16:59:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392582641EE
	for <linux-can@vger.kernel.org>; Sat,  4 Jul 2026 16:59:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783184393; cv=none; b=O2P56mcUTO4mW7qeX6FMEjBpm8tIW24FiBiSyZGnioZEvYrqhlcbxCNGv0NwFVJ04oPM8ec1+/KSz8t4u+vRnpBX3d/cVv+u9s9y6ZP+KGnhB/4GIHQZaVIwOBmOjwaWKjpDH+PlpLvXJweehOgw/+Q8yG9w+B7vS/zBk1zmOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783184393; c=relaxed/simple;
	bh=HEVVKRRtFEK07bdqaL55pH8VifBeCrrNWeA6YU2WtVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7BgBBwybsEbFAA9Or1436W59ebH4y+YGwsLtrLPsxBYLUi3DkbGdaYCvOa4p3v7oHCBUyppkbo6RyQy1ObFhnDc2WYTId2RWQhJXYK7I5CUedt0XNDmZqbUVehHWs0TtpvSZLak2U6SugDr53O5Oz5a8JFC1truHG8aJfkOzsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H26nB7E+; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc80b585bfso443905ad.0
        for <linux-can@vger.kernel.org>; Sat, 04 Jul 2026 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783184390; x=1783789190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGYt9Kdr9O3QYlwJbWJSnWPxgdY2R3nu6CurxtPWbAc=;
        b=H26nB7E+AnaHwWyZT60vLprH0j/d+0skSP0P0ke5qF9Wv4B2EiXkab7mGzEuDCftx6
         bL4O2oPcZXm5efGUtGrWTL+94PMLbK3rTGCT1+deX9o3oM8RH4h5rC4BCZIgBUUxp7ke
         klIqfKtf2EkWH8U4X47RM7QrqtTdh32LCKPFSCLLVlPdphU8D+NwuKwUXBVbzEfNu5yp
         H1m5qms9al/cbl2uSWPqo3txefleX2eYDJIfVaKrtMEzDEasdk9lcv179cxOTrVKbIa/
         szcEdW/HdLBMPhE2VYxVb217DYs++OEsZWyDlsXlAkINEYUf18kurKt0NKFWj6ocZ8yO
         qH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783184390; x=1783789190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGYt9Kdr9O3QYlwJbWJSnWPxgdY2R3nu6CurxtPWbAc=;
        b=So/wilBDDkaflXiSbkZCN0Fd1Z/O5bp1zbIiKomTUWde5ISABqb/mCZxa/PYdhNZu5
         cKD+8tvCu2PKmwO6SPRJspQUb3yjKX8S78SvDOiyG5FqwfGiRNQEGFVeJikariE6ge9Z
         d+zZV5JJiAYINwqUBy9PsHDIx2BVwwVIvBGCOXOKeKeyc1bnJcPllDtw0VpcwmiP2Mnl
         2U7UdPB1gxX4aFF77g1Zym1ctAdXv52aMB4KV3IqTfwOTcgt2R7X57EjOyAXSfmpxHX/
         zIH6s58UhRxEJVyF/eqy8EDgpKRyl8F9XdmFVmGspwOjA9ic7DYB2NtFQ+VpSbTzl0Mx
         CAvA==
X-Forwarded-Encrypted: i=1; AHgh+RqCn1moRN1o6dmVN9pc9tGaYFhn3O42GdwR6hNjr6BFWnmnne12m+yjTd5k4xg1ZQ86ugRIRpZuC34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxdNUipv6zOnsZFvk3kkreM/XR1aJRiuTXYT+/+CPDWKrnyPoi
	4ToJ33yO2+JBZJW5EixKtJ0VFvpgS9a11yTgN32tMan0EzMtDMSkmkijYJ9enCJtxUE=
X-Gm-Gg: AfdE7ckpGAfXA1AxnfacHmiG+iWFZ3JxArRcT0oEcKsW4Htqo0DNXwlr803HXfcEBm9
	pGvX5kHFFBapthdR9QO1p3wcSUmNXO4mp7UU+J1xptly2w6jbQVro6Xhs1mQYHBEVsbHxiNhyx4
	HvMwKSw4pRn6ASZnQ7tmfCIgXS9o0XeVGvNUbLQcA8hr4H/ciCIO6bHkGL1kksoHQpg3Iz/6//6
	+D1s8NC0Fyc4vyzWpoPQTCO9IP1Ki/EwGllnc9YUyGv6oWvIjSi0nbChPLuuJC32s3F8kTNRKPh
	y93/xzxBWM1BoLjgK7E9ig0n7UFHlbXocvo7lGismSO+ohc4oaJHRM3eFi3Dlg0fXD9Qo7T03xn
	hi8q7FxffMvtlas5Y648nzAW6JkjSdD0SkUCrssohVLyTmmMc+8GhpUsjFEO5CC5wfbw3U5M=
X-Received: by 2002:a17:902:c952:b0:2ca:1479:d9dc with SMTP id d9443c01a7336-2cbb9e38f0amr36956325ad.12.1783184390385;
        Sat, 04 Jul 2026 09:59:50 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad789cb15sm24418075ad.80.2026.07.04.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:59:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] can: usb: etas_es58x: Fix RX buffer leak on URB resubmit failure
Date: Sun,  5 Jul 2026 00:57:17 +0800
Message-ID: <20260704165717.248880-1-lgs201920130244@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MSBL_EBL_FAIL(0.00)[lgs201920130244@gmail.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-7996-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mailhol@kernel.org,m:mkl@pengutronix.de,m:gregkh@linuxfoundation.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	SURBL_MULTI_FAIL(0.00)[vger.kernel.org:query timed out];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[vger.kernel.org:query timed out];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AED2770804F

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
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index b259f6109808..da12a35dd2f9 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1476,7 +1476,7 @@ static void es58x_read_bulk_callback(struct urb *urb)
 		dev_err_ratelimited(dev,
 				    "Failed resubmitting read bulk urb: %pe\n",
 				    ERR_PTR(ret));
-	return;
+	goto free_urb;
 
  free_urb:
 	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
-- 
2.43.0


