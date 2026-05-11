Return-Path: <linux-can+bounces-7589-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Eu7IhyYAWomfgEAu9opvQ
	(envelope-from <linux-can+bounces-7589-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 10:49:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2150A529
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 10:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24F2B300898D
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA27F3BA235;
	Mon, 11 May 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="n9D5jr2A"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222D332907
	for <linux-can@vger.kernel.org>; Mon, 11 May 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489368; cv=none; b=lfcO8W2wXPkwg5DxouR8g9+hI2Fd9luiX5hSmQ8UGmKOkhHbOnt1MjNwZM6b8RsKoEwFB6UcW21QHtlYDLhk1VcvqbAJrVxUYT7sBouSSmFgwsf1BZKR0BvA0CJgEH/LfoXFVg7pkg8mgPE9lK326rjLYI32VaYk61gQs7GrJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489368; c=relaxed/simple;
	bh=GyesdMEd/9PhVYvjQgNaqhYmATzIN6OiJsBw2DBQrmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EPsRdboihbkSIQabMd07lGrkYHNF6tT7CdDbr8CFoKzHzuZNnroOFdrWkiKpcs8HtMhapHVcYYUyqV6kBQUJIS4fCNBamtdGLKY3ENEA6HtSUmeXsARd3NEOWxFL/7nEQHcAKV+GR8OfulOlz1nzMZj3iboSVJ5wyxV4VZ/ofAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=n9D5jr2A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso36562995e9.3
        for <linux-can@vger.kernel.org>; Mon, 11 May 2026 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778489364; x=1779094164; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YnVpeQZjIdFY4xO++atAMWiNiP8iV3HqELoXbMYyL0M=;
        b=n9D5jr2A7NgiqHH20lot2w63YrBDzb8Jj2p7SsxtMyIoOIMXwnZ7ga+85GJKAsL98a
         LwuJSwke6r1R7XnPDIPaAUKP+zA7QcEsSEMKi0jff1biW3WJIrjMw1OdlPDAc3a7qYvn
         7XcU5R5f7oGGAtJ1bxPJSkWWrbb8P8EtRvnf4+IQH3mL4OlkVcdQ8gn6NKRF8GUFoALV
         Eji9QDacazZ73+KuKLI8sunPShKxbiglLyNWssyBuKjlDL8TJlV+K3f/+Rn13UVMfie4
         mYdIfvxhthbEEl4cxG67CAo3RYN6yTV1m0gYCRleq1hARaiOWhnOi6m0bi+CHA+Y3qsa
         ADyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489364; x=1779094164;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnVpeQZjIdFY4xO++atAMWiNiP8iV3HqELoXbMYyL0M=;
        b=L2Ee3JxoOJqHXgX5mwLFSJbQ6dNvJwNmbv9Y0DJ/7YKquQUf4/LNKMxGr+uvd6o7hT
         i8PBUoB0L2DXb3lQe4X9j/ADXLOH4+gRHx5egpUF05S0BIXMkEpg+T/3Tm39yLS9VTtm
         Iw3cQEYztc7u8FdRtUQW4DmBPMMxLDsP8pAPwl493byIDzMKE0nnXQrJ74CPnweB2rw0
         eCCexE45Qko5jEhF6X0j6ldWKcU8m+0oFa9hYpZalGT0RBmiSvo/yi2gVw/K9nDdK6OM
         aeGSDHSghJFXcsZmrB2xN5+Ve1on1VBPdUqwlsqIYorIhkis+XP9UXjpgaY10ZjaQeDM
         qvfQ==
X-Gm-Message-State: AOJu0Yz9fZBGOXsvMgCwVpp7lBS4f+K5gYEAEPCoCytnyjZwe9ylS9Bz
	S2ZMBRb1UhCxgQUvkupBNp+39z3PiAC43yy8wH3cuNq36bbtYFBNyrUz3d+1YHRibCSsvcHkgT0
	QSiS7
X-Gm-Gg: Acq92OHI9VlEAMh2T40fH4jM1ZpelRp51aLbYJPjAIzPoNRAawvqNvmDKwfuVKKSl+U
	rRR4Tjn59Bz0crl7E2J/eM6mu0UafE3pb50MPCo7yvAckcBeFR/v+ktDKhB6pQwiZMUj0k/xQQY
	ZUwv0/89G6cf1ICQw3iFpRxRIncRQu7X0W/oHcgzzVEj8egCNSISTN5sBqmjlauIuKPCeqRoi7l
	BCPQm/cWxJwpT2yWzfKTfgZNd8CoB8a7eUHD1UWKIY2opmCJ4ry6ETInLC7wwDjDRR/BSIQUO31
	R3UbeKnhA4BXIPhOT8tSBlx9CIOiainHCa7jc398tc08gFjG7hn/fuOlW6DLtqyLhHoGuo8s0+0
	EiWOrwX1RDbNymCHUpERnOa0j9SQ+jpn8wyzkZjElLqQu0WcbSDFsPHVywnmZItOfU69D5Ajnf5
	tC0OsgmMMlJn5tqvRfgdG2J9aKw98pgMM=
X-Received: by 2002:a05:600c:a307:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48e51f4111fmr282102665e9.19.1778489364426;
        Mon, 11 May 2026 01:49:24 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702f407asm172635785e9.13.2026.05.11.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:49:23 -0700 (PDT)
From: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>
Date: Mon, 11 May 2026 10:49:16 +0200
Subject: [PATCH] can: m_can: pci: Remove driver_data
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-topic-mcan-pci-driverdata-v7-1-v1-1-9b7161c1d1ed@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAyYAWoC/x3NPQrDMAxA4asEzRHYofmhVykZXEluNcQxcjCFk
 LvXZPyW904oYioFnt0JJlWL7qnB9x3QN6SPoHIzDG6Y3Og9HntWwo1CwkyKbFrFOBwB64weeXx
 HesSZFyfQItkk6u8evNbr+gPnhtLvcAAAAA==
X-Change-ID: 20260511-topic-mcan-pci-driverdata-v7-1-d5bfc4f7d80e
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=msp@baylibre.com;
 h=from:subject:message-id; bh=GyesdMEd/9PhVYvjQgNaqhYmATzIN6OiJsBw2DBQrmE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizGGXyOx//mfW/XOnrpyBbRFruWWZc2tEwN3s0WwVf9J
 Gbp3xeLOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiJSkMf6UtLFdOTMlasoLb
 +lPsCh7hz3YPeW+Yhc6bkMWd11hubMTwh0ecI6n4S+DRHDvOqx62KgaXvi+PNjq36N06/u5HG95
 l8gIA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Rspamd-Queue-Id: 2AD2150A529
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7589-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msp@baylibre.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,baylibre.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

driver_data is set to M_CAN_CLOCK_FREQ_EHL for all models. This change
was already five years ago, I don't expect any follow up models that
need to set a different frequency through the driver_data at this point.

Hardcode the M_CAN_CLOCK_FREQ_EHL. Once there are new models we can
evaluate what data needs to be in driver_data.

Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index eb31ed1f964491ab41c7811be317706a09951390..8cd235c4f85c5fa2fb0bf299c950619ab52e6d88 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -126,7 +126,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	mcan_class->net->irq = pci_irq_vector(pci, 0);
 	mcan_class->pm_clock_support = 1;
 	mcan_class->pm_wake_source = 0;
-	mcan_class->can.clock.freq = id->driver_data;
+	mcan_class->can.clock.freq = M_CAN_CLOCK_FREQ_EHL;
 	mcan_class->irq_edge_triggered = true;
 	mcan_class->ops = &m_can_pci_ops;
 
@@ -183,8 +183,8 @@ static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
 			 m_can_pci_suspend, m_can_pci_resume);
 
 static const struct pci_device_id m_can_pci_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x4bc1), M_CAN_CLOCK_FREQ_EHL, },
-	{ PCI_VDEVICE(INTEL, 0x4bc2), M_CAN_CLOCK_FREQ_EHL, },
+	{ PCI_VDEVICE(INTEL, 0x4bc1), },
+	{ PCI_VDEVICE(INTEL, 0x4bc2), },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, m_can_pci_id_table);

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260511-topic-mcan-pci-driverdata-v7-1-d5bfc4f7d80e

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


