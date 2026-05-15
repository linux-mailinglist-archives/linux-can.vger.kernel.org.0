Return-Path: <linux-can+bounces-7636-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFGYGoMeB2rnrgIAu9opvQ
	(envelope-from <linux-can+bounces-7636-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 15:24:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9655065D
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 15:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E45301FF89
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8DC33B6FC;
	Fri, 15 May 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="UGqt/vKA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDFF231A3B
	for <linux-can@vger.kernel.org>; Fri, 15 May 2026 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850943; cv=none; b=TDaxqq05YEQLDvVj2vHq0An68kQsWW05XjDC/hPnyVA0BiobDPmjSrI/7DdSAbuAdTHkaDPwGcYUrtQF1FpNI/KFeU8ulSj220ldYeddLtXfJelQoKNjiNtSZcH6YMz4SJld1GXCihNwRT3jvoC/C/8QfnUr9pT4EcowVqOStm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850943; c=relaxed/simple;
	bh=AWTUitl93lD73gnMfvcUDhXeOQbp/DOjxwsI34zrqmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=toFXzs/RrF7rPO0a57cdiS9ST/tTxyX61F4G/1dnX1aBr7C2ulflpAw8xuJBSObkZ4cL9oRgNFL17EL+cKG+xg7UdHC8rr2QZ9G0z+j9ypjGkeQGug+4lNa3eqjdyh9DmQuCYKWBX1eC3hCKJjnUo8LRL1r0pKqrGTI7sN+ENLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=UGqt/vKA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so50561035e9.1
        for <linux-can@vger.kernel.org>; Fri, 15 May 2026 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778850940; x=1779455740; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91oT2C7HzmvRl53jPBN9VogksJHgfQpyopVk/xhZKRM=;
        b=UGqt/vKA+OPUedHeLdWolCmwycH5HnmBx0TVhyKSHzw7Lnwk/Ro9XLQg0Ex+eVvxru
         iRVsziLefhhRhqi/bmc+y9zAGbkXOnGb7IShanRyuveCke8Cgs85UECOyTWZT2w2JhTK
         QWr2Hfl3HQH+NUG+MPqB6yT14bezW+0ThfZpp1+wp1kzCYFong9lXbyjivse0bMUIh1y
         jEfP4RNK4Xz0LuqhdsnjdypRegQmqEeRCPCCGtUgBJ4EPuq7WFg5zf6By5KJkFvAgGte
         rR8DZxfZMyEtnEOlF4ClUaWyqPX+WdisTLfkIURGBfnryaSr/zxtBpjFlWSXQ850Rfff
         n+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850940; x=1779455740;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91oT2C7HzmvRl53jPBN9VogksJHgfQpyopVk/xhZKRM=;
        b=Q46e4YmzIwAUkswrmIWcsCgT843zBn82e7UMUb9bHqA2tEtM3a0euQv58KPG+TQS5e
         vk6E85cXNqX9nKBySrYEsNymQnBRH7hEWYVUuy1fcTDeDFxkp7Ns11eVk7YGi4mWrJQr
         F9u/uWZgBkdTXbVPgNGnOJHaRw9yK8w09I66UzIrA+aOhUDro7DgGVStGT0PapSizFs6
         zwFBCRhjDgFIXnR08I3VE4c6N0kGumWwF6cSjzZjFIy4NhQPL4YAJcAWYiFeoVS7q/qa
         zEmiLvQvIpqhT/GpyMI0pGZTkIOVkgOwif8vruUCDypFdJ+/Mj05/IXv30UyVXldYoHv
         TGrw==
X-Gm-Message-State: AOJu0YzqgVUjyELuMcR2/tHhuw8glZqw5eF0rhdiMXcqhncHUbK6eScK
	T7b7A+TBUlowfsi44c7aDHZVNxTxmhXyutv++mds2rH2KZjbVriP02YUbDHaKbNi2BRSdjw3dQJ
	4n6ZC
X-Gm-Gg: Acq92OFUMY9IEerZ2edDHgwmQQH7Fo0zyvHBX4sX3nJjrdakjnZL4HbpuYU+8avrxvg
	/dowmxCWVeBSu1wgV9E3sAfBHsAngrYfGxcIskqxk1O/9ftG8tMUTH4ctFu35b6oIz6bUEgR5L+
	lL4eTmImj7q9KJdCR2rqsj3Q4IwdblxCv8Jzg3OUlWzdmKPClKBFyDRYpNd661ltGp3PPLLphHQ
	oYaHNqdMZOTrc80wVj0ESrHkEvoWCkdCAKWXo4bteOzL0kxGLUCzheiHvdbcsLPgkoiUsRsFz15
	NR3Rhh4maTguJqwvVWsG94RQbTHamJun/JMScBK73qUuRvwcYHXdKQEM6pViZCJORpDHCMStoXI
	hcNO/w6ZMcV9xOSraXg2zgQOvQJO1UD45BzGnvjUwvGrEG8JpZ83Fz8BzJJgEVM8Nolb/glyclP
	3gN4sBF2nAm5WL4kR9PCEdX9b0TRzyMgo=
X-Received: by 2002:a05:600d:8:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-48fe61f291cmr54533725e9.14.1778850939915;
        Fri, 15 May 2026 06:15:39 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe83ba2sm13027605e9.35.2026.05.15.06.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:15:39 -0700 (PDT)
From: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>
Date: Fri, 15 May 2026 15:15:32 +0200
Subject: [PATCH v2] can: m_can: pci: Remove driver_data
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-topic-mcan-pci-driverdata-v7-1-v2-1-e33e014ff328@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHQcB2oC/42NQQ6CMBBFr0Jm7RiGCKgr72FYtJ1BJhFKWtJIC
 He3cgI3P3l/8d4GUYJKhHuxQZCkUf2UoToV4AYzvQSVM0NVVk1ZE+HiZ3U4OjPh7BQ5aJLAZjG
 YWiTk2vbu0rd8LQWyZA7S6+cIPLvMg8bFh/XoJfq9f6sT5bnZlhpyxCT8sGZ9qw1ydn6Ebt/3L
 4fq0cTPAAAA
X-Change-ID: 20260511-topic-mcan-pci-driverdata-v7-1-d5bfc4f7d80e
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=msp@baylibre.com;
 h=from:subject:message-id; bh=AWTUitl93lD73gnMfvcUDhXeOQbp/DOjxwsI34zrqmU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhix2mdLEWrkVZep7P3T+OREnfW67p+Lzlrd6xoernOJ6X
 eKMNkzoKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInsfsrIcHtHTf2MwKur7R4b
 sCoKrRY9z6ckvyg9QmHh01tp81M+fmFk2CZse/ytuf1MC2f1f33fjc13H2aalPy5O80h9mO11qV
 f3AA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Rspamd-Queue-Id: E0C9655065D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7636-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msp@baylibre.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

driver_data is set to M_CAN_CLOCK_FREQ_EHL for all models. This change
was already five years ago, I don't expect any follow up models that
need to set a different frequency through the driver_data at this point.

Hardcode the M_CAN_CLOCK_FREQ_EHL. Once there are new models we can
evaluate what data needs to be in driver_data.

Acked-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
---
Changes in v2:
- Remove commas that are not needed here
- Add Uwe's Acked-by
- Link to v1: https://lore.kernel.org/r/20260511-topic-mcan-pci-driverdata-v7-1-v1-1-9b7161c1d1ed@baylibre.com
---
 drivers/net/can/m_can/m_can_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index eb31ed1f964491ab41c7811be317706a09951390..d11a7c88fc32fddca5e02f0e489b8bb7cf0f3020 100644
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
+	{ PCI_VDEVICE(INTEL, 0x4bc1) },
+	{ PCI_VDEVICE(INTEL, 0x4bc2) },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, m_can_pci_id_table);

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260511-topic-mcan-pci-driverdata-v7-1-d5bfc4f7d80e

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


