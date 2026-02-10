Return-Path: <linux-can+bounces-6536-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAUVK9NFi2mfRwAAu9opvQ
	(envelope-from <linux-can+bounces-6536-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 15:50:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B68D11C1A6
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 15:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D2FB300D755
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82F32A3D7;
	Tue, 10 Feb 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZZUcFHDM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZZUcFHDM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549743803FE
	for <linux-can@vger.kernel.org>; Tue, 10 Feb 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735055; cv=none; b=DkucjLWEh2RwWLG7a7EjTKvP0RmbOq+VyDMi5rHsWjn9VLtJviacGdu5BZFEYrQwjZVVj3SFM6YNN2nOfpiGXC7n+DR1R24pAppS9VSpI6MEhFrWPVbSSUA4Tio7yvEikJD3W+dIH88nBAH3DNa/N8i0s7xRSiCD8A4A9BZdqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735055; c=relaxed/simple;
	bh=9c1S3H8X8QsSP4kraC55PPtdYkNUt5JhUIat0IXzrjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bR9Fl1CEokSP00InUh2aDsKG77fArBkvGmCgfwtjbtLrFQEv5KVw7noCgibcK1qIy9Xu4D9u5vOeq2MwHgi7QQy18g/ZQQKFXZKsqrHN8jyrf8sZyerLaSDKTP1XwViUQZzk/cy/VTLeLR4AMoRbH9EaLqeJp9fgzxo18bflTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZZUcFHDM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZZUcFHDM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72C7F3E6FE;
	Tue, 10 Feb 2026 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770735052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qeIKpw/9UD/Nq07hsfUEx80wf+G0vaHtEGXpJB/mjXQ=;
	b=ZZUcFHDM/OK9SAoz1tTexb1rQpEIVo94rtJkXbLlKDScb6963HpR3Hy7iUfoR2HBTWFSVK
	dJg8sTH6+7FM5TRgV1Xy39LveD9lo1P9Piaw96EgH+nNSteagATpnj6YWbHs/NA/FgetLt
	EANWbOfSg6lT31tIdbKUm2iFJkclmdc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770735052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qeIKpw/9UD/Nq07hsfUEx80wf+G0vaHtEGXpJB/mjXQ=;
	b=ZZUcFHDM/OK9SAoz1tTexb1rQpEIVo94rtJkXbLlKDScb6963HpR3Hy7iUfoR2HBTWFSVK
	dJg8sTH6+7FM5TRgV1Xy39LveD9lo1P9Piaw96EgH+nNSteagATpnj6YWbHs/NA/FgetLt
	EANWbOfSg6lT31tIdbKUm2iFJkclmdc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39D533EA62;
	Tue, 10 Feb 2026 14:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YQlVDMxFi2kMXgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 10 Feb 2026 14:50:52 +0000
From: Oliver Neukum <oneukum@suse.com>
To: mailhol@kernel.org,
	mkl@pengutronix.de,
	linux-can@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] net: can: etas_es58x: full cleanup in the error case
Date: Tue, 10 Feb 2026 15:50:49 +0100
Message-ID: <20260210145049.40995-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6536-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B68D11C1A6
X-Rspamd-Action: no action

Memory allocation can fail in the middle. Hence the cleanup
needs to be called in every case.

Fixes: 8537257874e94 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 2d248deb69dc..19fa51821a89 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1783,8 +1783,9 @@ static int es58x_open(struct net_device *netdev)
 
 	if (!es58x_dev->opened_channel_cnt) {
 		ret = es58x_alloc_rx_urbs(es58x_dev);
+		/* can fail partially */
 		if (ret)
-			return ret;
+			goto free_urbs;
 
 		ret = es58x_set_realtime_diff_ns(es58x_dev);
 		if (ret)
-- 
2.53.0


