Return-Path: <linux-can+bounces-1720-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33E49AA0C5
	for <lists+linux-can@lfdr.de>; Tue, 22 Oct 2024 13:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A431D2849AE
	for <lists+linux-can@lfdr.de>; Tue, 22 Oct 2024 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2319925F;
	Tue, 22 Oct 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JMw7TGFX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//KssUk3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JMw7TGFX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//KssUk3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52F19538D
	for <linux-can@vger.kernel.org>; Tue, 22 Oct 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595084; cv=none; b=erpvaUZuPuo9lv1ox9ZyX3qjsKJk2ox6dqe0GMcnDgKV6mOkam0VnvQOSkOBBE7Vr4aFQwZw1YqJbYM17n+DvMllrz9nXCsr0LRk3uqD+mI2V+tI9xH5QDQmzGSOpzzWXvA7jDuKgi85FjCDhG4i4ZyDQS+MUs4MjCTmByKv5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595084; c=relaxed/simple;
	bh=xNur0RRGEFSwf8uR82j78/SMbSR0YzoqHmNLt04vCG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VVFWB2ePnnetYMGihC461gpf4fFmlQYMP8j0ajMA8XOzJWAJpeM6o81K842x8hi3nybg/TPa6RGOgLgdlMfxzEQ6XUdb7Gr+kE/pOi+Sm9u2cKYCMqmAHfc6K5yvICTCcjYXAdxqrk8z0IWeB9Hv0iPV0AuY9h6WmTj3NWW0gp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JMw7TGFX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//KssUk3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JMw7TGFX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//KssUk3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AA7021C13;
	Tue, 22 Oct 2024 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729595080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAw85LVEtY1vrhNqqkenMLlpAdV0oeGsi6OBgz/QADs=;
	b=JMw7TGFXadjWJ010HPEUwj6sIxhpeuvq4PPUZ2hbJwgoz9OM0+tuKUcW7s8qfEtsccvGDI
	feIwv9QDzWAlRWXR0ed8eZZ/h8H6s8qY91qJw94sgBrxoLokJ4ktPT1G/PKdRWyjd6rkZB
	TvIqn/LGy51OtVM6z2YCCd3L2ChxtTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729595080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAw85LVEtY1vrhNqqkenMLlpAdV0oeGsi6OBgz/QADs=;
	b=//KssUk3heZWGHhHy0OVS72vXzk8N8sg3Bnw6PHtacThJtAJ8GV5flb73SHy5z9FRwt+LB
	ipuOL37BUEnrPVDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JMw7TGFX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="//KssUk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729595080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAw85LVEtY1vrhNqqkenMLlpAdV0oeGsi6OBgz/QADs=;
	b=JMw7TGFXadjWJ010HPEUwj6sIxhpeuvq4PPUZ2hbJwgoz9OM0+tuKUcW7s8qfEtsccvGDI
	feIwv9QDzWAlRWXR0ed8eZZ/h8H6s8qY91qJw94sgBrxoLokJ4ktPT1G/PKdRWyjd6rkZB
	TvIqn/LGy51OtVM6z2YCCd3L2ChxtTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729595080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAw85LVEtY1vrhNqqkenMLlpAdV0oeGsi6OBgz/QADs=;
	b=//KssUk3heZWGHhHy0OVS72vXzk8N8sg3Bnw6PHtacThJtAJ8GV5flb73SHy5z9FRwt+LB
	ipuOL37BUEnrPVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2946113AC9;
	Tue, 22 Oct 2024 11:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w8cGCMiGF2dcLwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 22 Oct 2024 11:04:40 +0000
Date: Tue, 22 Oct 2024 13:04:39 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, kernel@pengutronix.de,
 Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: rockchip_canfd: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20241022130439.70d016e9@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6AA7021C13
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wanadoo.fr,pengutronix.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), OF
can be enabled on all architectures. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/net/can/rockchip/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.12-rc4.orig/drivers/net/can/rockchip/Kconfig
+++ linux-6.12-rc4/drivers/net/can/rockchip/Kconfig
@@ -2,7 +2,7 @@
 
 config CAN_ROCKCHIP_CANFD
 	tristate "Rockchip CAN-FD controller"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select CAN_RX_OFFLOAD
 	help
 	  Say Y here if you want to use CAN-FD controller found on


-- 
Jean Delvare
SUSE L3 Support

