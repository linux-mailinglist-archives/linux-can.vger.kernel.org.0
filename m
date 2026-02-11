Return-Path: <linux-can+bounces-6539-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CSSFG1djGmWlwAAu9opvQ
	(envelope-from <linux-can+bounces-6539-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 11:43:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4754123898
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 11:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 745D63022972
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CAF369207;
	Wed, 11 Feb 2026 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TrUet82u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TrUet82u"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21685309DDC
	for <linux-can@vger.kernel.org>; Wed, 11 Feb 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806441; cv=none; b=cEwVb3mqGOQv/pSckEnE7qt0jWMWCcGC3VjfI3ICw0x5tIr9YzUruWF97ypOztCcqAaB1ve4PovqOAXddZ+p4+RIQBIogRRhf8vYraFKjuhsDDQEPehZ8sBDP44K3F1nsCeHOYjvfsTKKl1QbZG5nDulsL+0CSMLh+f2cJfr9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806441; c=relaxed/simple;
	bh=D0RDPWhiYsD3V5Mh38qNbN/nguKX2Lksu+LvsRSov/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oee8idyHsoE/pDloFoGjeH721QvZmQ86ZihwWKJA92y2g/YAIrKgTEITzVB5n3Ww2WUaujbWP60fNGkHEgjZwaqyU/k8U4trSOdBRe//CmNP5aivBOdVnjcSp9AEXOtMo6TpUDWTW7qV6R4Kgpxf7emlOyS6ye9o8DTPenLbzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TrUet82u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TrUet82u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E7765BCC6;
	Wed, 11 Feb 2026 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770806438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CP9q110oDcuSLBo6RpJ+Ygu+0sfHV05K7sd02xWXlCU=;
	b=TrUet82uHbcQUAaKQ5jsTn0LCZwojoPSCp9iyi/tJrIHlnUj2sT1eXfjtMhG302jGXMMji
	Gyv6PBg0AJfjweaRfEvSHYC1eSScn/SCB9ibPksUV0HbNlkuebL/ksBPaZHm8FIjKMugtp
	Vrkb3SIi/YSB+bKOMDrPRNxET+tKqW4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770806438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CP9q110oDcuSLBo6RpJ+Ygu+0sfHV05K7sd02xWXlCU=;
	b=TrUet82uHbcQUAaKQ5jsTn0LCZwojoPSCp9iyi/tJrIHlnUj2sT1eXfjtMhG302jGXMMji
	Gyv6PBg0AJfjweaRfEvSHYC1eSScn/SCB9ibPksUV0HbNlkuebL/ksBPaZHm8FIjKMugtp
	Vrkb3SIi/YSB+bKOMDrPRNxET+tKqW4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F16B13A48;
	Wed, 11 Feb 2026 10:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +mYuEqZcjGnZQAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 11 Feb 2026 10:40:38 +0000
From: Oliver Neukum <oneukum@suse.com>
To: swilczek.lx@gmail.com,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	linux-can@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] net: can: es58x: fully try proceeding with partial allocations
Date: Wed, 11 Feb 2026 11:40:29 +0100
Message-ID: <20260211104029.83860-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,pengutronix.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6539-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: A4754123898
X-Rspamd-Action: no action

Since b1979778e985 ("can: etas_es58x: allow partial RX URB
allocation to succeed") es58x_alloc_rx_urbs() sees a failure
to allocate and submit the full number of URBs as a success
and the driver will continue at reduced performance.

However, if you do so, there is no point in abandoning further
allocations or submissions, just because an earlier one failed.

Fixes: b1979778e985 ("can: etas_es58x: allow partial RX URB allocation to succeed")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 19fa51821a89..9dc66932267f 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1706,12 +1706,13 @@ static int es58x_alloc_rx_urbs(struct es58x_device *es58x_dev)
 	u8 *buf;
 	int i;
 	int ret = -EINVAL;
+	int allocated = 0;
 
 	for (i = 0; i < param->rx_urb_max; i++) {
 		ret = es58x_alloc_urb(es58x_dev, &urb, &buf, rx_buf_len,
 				      GFP_KERNEL);
 		if (ret)
-			break;
+			continue;
 
 		usb_fill_bulk_urb(urb, es58x_dev->udev, es58x_dev->rx_pipe,
 				  buf, rx_buf_len, es58x_read_bulk_callback,
@@ -1723,18 +1724,18 @@ static int es58x_alloc_rx_urbs(struct es58x_device *es58x_dev)
 			usb_unanchor_urb(urb);
 			usb_free_coherent(es58x_dev->udev, rx_buf_len,
 					  buf, urb->transfer_dma);
-			usb_free_urb(urb);
-			break;
+		} else {
+			allocated++;
 		}
 		usb_free_urb(urb);
 	}
 
-	if (i == 0) {
+	if (allocated == 0) {
 		dev_err(dev, "%s: Could not setup any rx URBs\n", __func__);
 		return ret;
 	}
 	dev_dbg(dev, "%s: Allocated %d rx URBs each of size %u\n",
-		__func__, i, rx_buf_len);
+		__func__, allocated, rx_buf_len);
 
 	return 0;
 }
-- 
2.53.0


