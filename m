Return-Path: <linux-can+bounces-7599-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNycNz8AA2rdzQEAu9opvQ
	(envelope-from <linux-can+bounces-7599-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 12:26:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 832DC51E832
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 12:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E824302472E
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237E395AF5;
	Tue, 12 May 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF/2FFbH"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752F349CD2
	for <linux-can@vger.kernel.org>; Tue, 12 May 2026 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581536; cv=none; b=R7Zjw0DQTCHAaNpbvro8zlUChs58NW12DDFhhWj6DjBVS9dhlPmEYvqN+jrJ6A71LQ00kPZfCC17p+7sizhz3Tlb6nTuUKTfXPtI8OjKx1Zr9VKiijl5FV8PzYr8pJNAJA1yOswf8zdQ1dMx4xML2aBN10HNg8PCVg7c0sjY5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581536; c=relaxed/simple;
	bh=IhoNvmD9JQin3UMraTdtwtbPSNmcwQ2gPL9MrmHEZHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AN/iQ9pqYie62iTNxgLI40/d/kNNSHbRa487RYDtqgfxGE8Zxs1SDFIF7HJ7DIBvSAlig1gf79rGakp5HVNCtPZ0SYzmpAf9c8twuoFH8ag60McyEpRG+DDqbExdv9hZiqoVwXhchTg7BicI2Op3AVJUZQM9bIS6n32lywE8Gi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF/2FFbH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so2140418a91.2
        for <linux-can@vger.kernel.org>; Tue, 12 May 2026 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581534; x=1779186334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4z7+etNpHPOWPeEaC540614m4lrLw4zEKLTP47movss=;
        b=OF/2FFbHxe787aONHbSv0oU2QF1sZPl/UdKRsqovoIawN4UrbcladnaQ6qP0GmeGv6
         gIj+MG1zocJuMlphfU+CH5NYcKCyfmAJAbvJKl9UpmzcX0o/hTfbf7oVm0n5a4opkRcd
         B8IisjcOBPNkcxiHifGy6o/MINDuKhQjJH6zRy7PTx0YFQ7ra4TBZXqeUn5XamRwFZ3X
         JmZ+ME2HOJjOmUUlu4RQd991NO14yGfEHknAlOt2GS3vJFEOVHI4CMzBpkFTrbb/jlVR
         OA3bJYxDVv4uAm18ajSKfqZEM9AyAfKRc/ffMy65J1WyZKCju1zzYOaj6TpUb98+7v4J
         nbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581534; x=1779186334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z7+etNpHPOWPeEaC540614m4lrLw4zEKLTP47movss=;
        b=jw5ck2S+lYKGFT7x8NMVdgj8XpdFepVeqadi9ZoCgn9G60a00EEOWTUkpu+4EKf8q+
         ZQqIpxUYUu1N3fLJQis2A9ITqsfRR170tZSB3yiWTUft7uXwJYBtJN82xlYrjjwrPG6q
         sYiEsdcE593Nu4xZIQrCZwxk7lLxmIHkD0sxoNNV9mIe3UsYbZRr4126EOxfsJB5SXsx
         aMbOS749mBPvgeipMP6axEWx/bCOn84Pr4Y/4+AXbi82jEThurAumB7nEDwpzzb28T11
         tY4B2SpenoPA2GAt8NFZXZTI2lcNwhF5rpH80uHlRV1Hb/7aGK2Jb1bim9ypzpKuP98+
         GmCw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZO978W8za747cJuj6PTpu0eh2tJfisCllgG/zgnajdixM6s7DtNc3QcTpDvOQTkUibO++HzpMzrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4Z7PswWDURQ5qlDXbQzz8GdZV7oiFJDl3m5qalYWY9Tm+iw1
	EOrnuqcRsMUomBmyo5zPb0rtIDDWhrozbDcLOYTSnEa7LA8WLUx/iqSr
X-Gm-Gg: Acq92OGHZmLXD7au38oa6KAoKh7BVTszqs6OWvSK2AnvL7XxyDlOh/0piE82CcVX78Y
	tPfUIkZwoZE0RqMMlwk+vmgYN9rZTxt3jfcuQuWMcH1BUhA6Y7+7ctd5EaQ0FlSjIwI/1yrobMO
	BIQrJqV7rMTixJhDS0l1zNsxj67d1lO8RU92gr6VDGheHi6/IDotGCwuH78KeCRBmDE703pFv+T
	gdt+gOHtAJ09RR0s8XHsoKdB0C3g6V4QKwbFbMp52itTRGq94nTL/pyov8VwjJi8jyz98RexNxl
	8lco1FD/pzgAOA6X3gUMOLuH+LLkejt3I1TKE1Ff4MW1k73aXg0XOKQUj7KzV0TqL94i2WdYicX
	t4eyMwRtMUEROhm4QscsJIKHhe+Z5wVzi1mpfoEFNFsT677/T5YfymBXIdqvLw+vrT8NlTtRxpi
	DXk/tS7bPzo3lfn4qY2+49nkPeeZi8/+FhF3exHjemhgbW254UwCzvaWTolw==
X-Received: by 2002:a17:90b:3f8c:b0:368:85fb:7b8b with SMTP id 98e67ed59e1d1-368b26bfb62mr2613874a91.22.1778581534554;
        Tue, 12 May 2026 03:25:34 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ac4c3acasm1294457a91.0.2026.05.12.03.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:25:34 -0700 (PDT)
From: phucduc.bui@gmail.com
To: msp@baylibre.com
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	k-willis@ti.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2] can: m_can: Use of_property_present() for wakeup-source
Date: Tue, 12 May 2026 17:25:18 +0700
Message-ID: <20260512102518.25471-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 832DC51E832
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,ti.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-7599-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phucducbui@gmail.com,linux-can@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Action: no action

From: bui duc phuc <phucduc.bui@gmail.com>

The 'wakeup-source' property is declared as a phandle-array in both YAML
bindings and Device Tree source files. However, the driver currently
uses of_property_read_bool() to check for its existence.

According to the function's documentation, usage on non-boolean property
types is deprecated. Switch to of_property_present() to comply with the
recommended API for checking the presence of a property.

Fixes: 04d5826b074e ("can: m_can: Map WoL to device_set_wakeup_enable")
Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Add Acked-by tag
 - Add Fixes tag

 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index eb856547ae7d..16f80607e150 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2464,7 +2464,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		return ERR_PTR(ret);
 	}
 
-	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+	if (dev->of_node && of_property_present(dev->of_node, "wakeup-source"))
 		device_set_wakeup_capable(dev, true);
 
 	/* Get TX FIFO size
-- 
2.43.0


