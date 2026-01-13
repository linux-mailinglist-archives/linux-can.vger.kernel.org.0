Return-Path: <linux-can+bounces-6119-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A6ED18005
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 11:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C8BA300384E
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF873314DE;
	Tue, 13 Jan 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K7Fir5jN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K7Fir5jN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262938946A
	for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300044; cv=none; b=VKJGrlPpDafWRJ7+DeQd4/8tq1EwkiuqnSlh8aCxYUgUfFM8NW5yVAHbcj8NRQ05gf6qSko6TfDDuvTasxmPJUglZkzP9H3muRpjUmtL+vNPqA1h/bKkaAlx2Eha7yIDcOa32luQBKJL1ag6HEagF8cfEk7oETdBrjjJcEY83xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300044; c=relaxed/simple;
	bh=C/bVeNXI9VWr7lQwFhn9Ob/7KFvHoXBtHx8Vtz1vOrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFnmohMYr/SRzAHlmbppap5vGYa9O0XCF+l4H7/GmLOR1KuuUrSvgE3sntaHPIRO3IQM2vig0YXRCdgpX7bW6FI2hX/1mh+E36tCipa3EJyoeOm+KTgf7arJmJNv3ctP4SHwsaZ1MOsWf01rsNkNS7VT6rZVd09jkb/CuicWREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K7Fir5jN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K7Fir5jN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8870A5BCC1;
	Tue, 13 Jan 2026 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768300041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XLCVHmmRVJC6nRKcu3kPUQ4gpA/y1ofNVULfBxxmA0k=;
	b=K7Fir5jNJwSDAIIocam2fhisfmzLIve+aHIYiVyalbrvTxA5xC4ZUhThenEXVzcRFTm62e
	bTTjPAZor0tjxgVpkalOCOdhS+LeLjnSRlkw6dnWrM+RstkEgpUqEBsFUWfI00cZbAX4q7
	nd7bevc6EJytT/L4qOG0qlH1iTL8h0U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768300041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XLCVHmmRVJC6nRKcu3kPUQ4gpA/y1ofNVULfBxxmA0k=;
	b=K7Fir5jNJwSDAIIocam2fhisfmzLIve+aHIYiVyalbrvTxA5xC4ZUhThenEXVzcRFTm62e
	bTTjPAZor0tjxgVpkalOCOdhS+LeLjnSRlkw6dnWrM+RstkEgpUqEBsFUWfI00cZbAX4q7
	nd7bevc6EJytT/L4qOG0qlH1iTL8h0U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BF163EA63;
	Tue, 13 Jan 2026 10:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kbIAFQkeZmneWQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 13 Jan 2026 10:27:21 +0000
From: Oliver Neukum <oneukum@suse.com>
To: mailhol@kernel.org,
	mkl@pengutronix.de,
	linux-can@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] net: can: etas_es58x: full cleanup in the error case
Date: Tue, 13 Jan 2026 11:27:18 +0100
Message-ID: <20260113102718.1018804-1-oneukum@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Memory allocation can fail in the middle. Hence the cleanup
needs to be called in every case.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index f799233c2b72..8a8764374713 100644
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
2.52.0


