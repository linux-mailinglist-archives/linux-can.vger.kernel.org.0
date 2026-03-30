Return-Path: <linux-can+bounces-7302-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 827TI4Gcymk2+gUAu9opvQ
	(envelope-from <linux-can+bounces-7302-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 17:53:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F535E361
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424CE305BBE3
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E769362156;
	Mon, 30 Mar 2026 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn3Cm7fO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F136B05E
	for <linux-can@vger.kernel.org>; Mon, 30 Mar 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885412; cv=none; b=gbS2ZomwIcPwiKqzU24SI+H61KNZ7RVwHkMsQMZnlXea5++v1kPeEuRvANs3UzA4R85sySLUgJWJwWszoN+iAntpJYZ72hBK1uIZy9W0rDVMAK/EiQe244teAi7dC6FcwpFq0zS0+fXAQLhsxK08l30tIE5PeIRkKp7kp1JIOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885412; c=relaxed/simple;
	bh=8AA78bo6gDi6k5n+uSlrguBGNGx2x4N4ETCxeBlmgUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duCZA1+5mjvTCq3Am/07r+ZEY0Hr8c+PN3VkIZLNDGaxveO5mvM/e0eW0KaiNGXjU9migp5SOvZIkbzirXc4nkvyhver8e9fu0OkU2CgRgxaB+fiti4u5QxTH6zOehcDSiARl1+8DcRGUib75JWe3RxrZi+mFWUbGeu3zpVBdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn3Cm7fO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf7258875so88659f8f.2
        for <linux-can@vger.kernel.org>; Mon, 30 Mar 2026 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774885408; x=1775490208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tO3ofX4oRPeqN1ii3JJFXpJAdRDWRpLKYddtaDkaAMM=;
        b=nn3Cm7fOFQykfCUMbjcKv0YNiEUm6VcNj2G+WNEyR1owWwYjH3z7h7zCC4ducD9irs
         GggNHe82eSfv+nqb+N2yV6CI21YLEiWReGzDlOtD8cbam5PX1ufNbXp6B25bE5XCTQxf
         3kST2IhLzMayuQAcecMiV71fU/NAVlJOCHk7p84uodcjVZWWp9Wr3SZpuB0LpTA9AfTy
         k+AmM6ki5DOqiCwxRB5/5lcTc02MaFlG8+bPonTFoTY2ZELaZtshDWPi3jNwtJ557DNw
         8e0+sUZsl35qFqbgIrAosREe9sNVBkOO5ijUnDqArhU3TvfZFoAEtnqvF+ROBBaAaaG0
         cDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774885408; x=1775490208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO3ofX4oRPeqN1ii3JJFXpJAdRDWRpLKYddtaDkaAMM=;
        b=NCckPwOHGIUZmQEmw3f4nLAlx1z+gov96F6HR0gSxtfn3jOFDRvxsCPsDisP+CVzzW
         7UYVC5F7fT5tbpHGZ993hru0k1hmXRToAZkdbo34iKyOP/43Xd0PJuNS1CzYVvsKZQY2
         AAi578WxvVQD68oyLwQm1Z8pJMkviXLZDMKwtSp6eCKVpB9NsWtbxZ3f3HJTYg5KIHim
         XQ7ok3xR+tddWzS+iutbtl3CeDrCwD2J2/gs8Hc6A531MMYdVHQVbjdPrxaXC6Il7hLG
         CcU8y9fYOmF+3k9k88GNaVCiPLqZVpwtkEAmbvXSWH0ERNRLpzh0ECmLnXtWK2+ntUUm
         mbOg==
X-Forwarded-Encrypted: i=1; AJvYcCXDKqPsSfvRVU8Jsldyd6lkWbUsFChLGnxTuiQhMw+diUkqAD3aPtQ+XUgSFlctscO+05I0eHjo/vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pNfDynEYlAQqD7/qBiE5lQL811uWpDsrDoWhnWArzKSXWQcj
	Y27mrER/Iv1TgNaNFb9r0vDI36n4Y8HL8VCQbJrtDyBxSMMpyc8/0MMW
X-Gm-Gg: ATEYQzzRMYpKJNYIDlWjjmm8m0ZpKp2JllQtDqsy22EoXVWwWhWev9kMS4WnBBEwWyl
	lyrxkeiMWpNdIymWxGjrdcs7dl0Jy7TqmluPVOg27YYWajEaspb/gc9RjbzDgkf/plaROHAZARU
	o4eW5GBNsJiSrwNIxZ1PJw6hzdNqo6hwTZLBtTAp7R3UfB8QkHfGS0uf3Xo8dyLgG0x6WFcACyD
	V244LPbeToPuMOQpM0Pk3YGEUN7Z5nykI4GWD+PpNKCWjeY+f/DlTzxjbpgFH9FiAaaQDHF3sOf
	HXI+CXm6094djWwiqCEoPNM8uadC3AP9BSmddfExuygJFxupIWs6nZNBmWRBIUbMF1SqNYQR5fC
	oiRU+FLFXsG+zTXOmvC7lObnr/ALDxR62aUbP6n2HFGa73O63UHC43AN9w0DbuPdhP8OV9Dv6UV
	i7SI0zgTYso7gZkOqMORfJCRaSvkbiBngYCuUE8qhn5attp06cDBcrNqCSbCm2EnKJinW7yEBww
	Y1SjyhcKdErm4OXxXAA
X-Received: by 2002:a05:600c:524f:b0:486:fb8a:fd9 with SMTP id 5b1f17b1804b1-48727c82fa8mr113297715e9.0.1774885408204;
        Mon, 30 Mar 2026 08:43:28 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-131.paris.inria.fr. [128.93.82.131])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48722c6b4d0sm281883215e9.3.2026.03.30.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:43:27 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] can: sja1000: Fix pci_iounmap() buffer
Date: Mon, 30 Mar 2026 17:42:31 +0200
Message-ID: <20260330154236.98665-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7302-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,pengutronix.de,kernel.org,grandegger.com,davemloft.net];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 276F535E361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The base_addr is mapped in kvaser_pci_init_one() and the pointer is
copied to priv->reg_base in kvaser_pci_add_chan() with offset
channel * KVASER_PCI_PORT_BYTES but unmapped without the offset.

Cancel the offset before calling pci_iounmap().

Fixes: 255a9154319d ("can: sja1000: stop misusing member base_addr of struct net_device")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/can/sja1000/kvaser_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
index 95fe9ee1ce32..213fd0eb07e7 100644
--- a/drivers/net/can/sja1000/kvaser_pci.c
+++ b/drivers/net/can/sja1000/kvaser_pci.c
@@ -161,6 +161,7 @@ static void kvaser_pci_del_chan(struct net_device *dev)
 {
 	struct sja1000_priv *priv;
 	struct kvaser_pci *board;
+	void __iomem *base_addr;
 	int i;
 
 	if (!dev)
@@ -186,7 +187,8 @@ static void kvaser_pci_del_chan(struct net_device *dev)
 	}
 	unregister_sja1000dev(dev);
 
-	pci_iounmap(board->pci_dev, priv->reg_base);
+	base_addr = priv->reg_base - board->channel * KVASER_PCI_PORT_BYTES;
+	pci_iounmap(board->pci_dev, base_addr);
 	pci_iounmap(board->pci_dev, board->conf_addr);
 	pci_iounmap(board->pci_dev, board->res_addr);
 
-- 
2.43.0


