Return-Path: <linux-can+bounces-3571-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88DAB65A1
	for <lists+linux-can@lfdr.de>; Wed, 14 May 2025 10:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380404601D1
	for <lists+linux-can@lfdr.de>; Wed, 14 May 2025 08:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422321C198;
	Wed, 14 May 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b="uSOfGfQj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16E21C197
	for <linux-can@vger.kernel.org>; Wed, 14 May 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210637; cv=none; b=kvv3o/fAHtvtp2Cp/uKnvAo822ZHG2HVyLVKoE9Kz61q8ZIoRJ4M3gHXruuGCvEc0MSm6DEqW52/MerswFmbRSZMEW1ZZsK1Tzkq3yEAbLuS5Gb4PuNeDUgB+N3dnDwv/CFRE2qi5vpskhXzHq42laXcJ2uZHr7usyo42eo6T18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210637; c=relaxed/simple;
	bh=HET45+6WrF+FD7M6C1H3EBZgdv1Sp5bR0ecVHddspkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PR77XQouWEhY8+Smobg97DOApBf8ikqzHvqBsOzPzugkHz2xiqOU0ZiHhgqbKMMLxYvQzQxEU3Nt9/IrTgrGCBC8viNLFhL0ecdmYM8WTHlBSClU+lcwRvYhmH+TV3EuGDqQa9uXJgr8RD0GJyOx5GFfo1m+JKiQOwfTXr/6+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com; spf=pass smtp.mailfrom=geotab.com; dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b=uSOfGfQj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geotab.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-440685d6afcso72230595e9.0
        for <linux-can@vger.kernel.org>; Wed, 14 May 2025 01:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geotab.com; s=google; t=1747210632; x=1747815432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fehdiKm4UCDcID/tX2zPcm+e01vW01c3tXe+yT7l42Y=;
        b=uSOfGfQj2Lb8jQ7Svh5Relgczw3ZHmhwZycJgnAiZe/KXnhspYtZfGZAPi7jOxnNc/
         OgPkr9v67q/DpCyWvFr0M0n6VMGSGbufX9vzTvm6XHv8JXhk0Eu7gXxquh/0DU8HAhBj
         zsN+myypJklaaCtZK8l6uiBFHGDVQXBzgG0gdWuSJ/jVvZ3rlB0MHhfa54TF8IKfRc1J
         irXjRnb1H/AMxgPwC+7pdxCCy8IZvfb/qZtHOYiRF/FJ8y/w9aJc4kkoBJmE7/94ACTZ
         GYGTlCok05i/ephb/r1L30VHsr/fZUcPf6ZweiuRYBpagM898eEW0v+9CUFMbJvreh71
         bYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747210632; x=1747815432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fehdiKm4UCDcID/tX2zPcm+e01vW01c3tXe+yT7l42Y=;
        b=qj2HGaEUoA8Gqsw+IQfRytgdthMRUwlpTI/4yPXrr6liIN7GKTUCrL0lkSJnpCHD4F
         6v4wyZepAODwBfSrhxf7w9L1Fy+MmDqJ2kAbwUJKEgZvTIQR7Gs2rx4o2O4v+gfVh0aM
         CpDdLlTOjPaNiGDKG18XTHGM8r8pxe45cmY2QLit2mffFzBbW4lH5Q4T6f5PP8ClOXqD
         LL6GWnO8mrFjUMhmQ3wdIp18fa1KOyDOYi+jXb6aRmxzYNjxDWFQ34llRwk9cIbYRgfy
         Bmq8V9mVaGKr8sJjDzruDjpdclGlR3GXSb7U8dtVKRbSbSpk1WZhKv9vih/8vZh47gcM
         Hhkw==
X-Gm-Message-State: AOJu0YwEHxb412zv+MmUHh9fncDgVOlYtxWPphzRhvC8V8S8E04EmjrP
	fYhzLph4dInPeTfoHmHyUpo/F4rvzkFv60qedkpEBfwlZMOf/N/Y0dSztM7TAWY=
X-Gm-Gg: ASbGncsB3mE8LllYlwbViTos8/UngztebCUaa8g8ujG8Ll0K4T4oFFif730hj9NeHIH
	hFIALdFS3t9luRkUilYhFIntJEPTM60qYWOU6evppLpnM1c3+O13pAKglvcxO/i6Iyqts8pUar6
	/JZ1MBQeX1z9BNma+cAejeRhsgLnqgwYqbLTS6CIrCUFeUGwU6bT542/VLZhabKHCVzmDHFAEEt
	EonWzRyXiLLIBQFDdpR/2uNvVOvRwHmZUIn4D9TidxcvpHzC/ATL1mjlvwAu1Du6msVWB+4Z16o
	7loy/8KQL2BJ5WYYv8X34gLJJaVMs1vDm3iiWSN2F3UHXSO9FV+jxJBUZHB2kMkafGagcMHMKtv
	KsWFoxw79QI5/Nk2tw3PmnicLYpLYmn1VLw==
X-Google-Smtp-Source: AGHT+IG4tH9yqLVTre207DZTt9gmAow6y9znE5kDTFkGNQ6llktI5VwCcsUq8dtmrimWNdg5vU0M/A==
X-Received: by 2002:a05:600c:4684:b0:442:dcdc:41c8 with SMTP id 5b1f17b1804b1-442f210c9c4mr18376475e9.19.1747210632364;
        Wed, 14 May 2025 01:17:12 -0700 (PDT)
Received: from localhost.localdomain (11.red-83-33-67.dynamicip.rima-tde.net. [83.33.67.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c7a5sm19034840f8f.98.2025.05.14.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 01:17:11 -0700 (PDT)
From: Carlos Sanchez <carlossanchez@geotab.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-can@vger.kernel.org,
	Carlos Sanchez <carlossanchez@geotab.com>
Subject: [PATCH] can: slcan: allow reception of short error messages
Date: Wed, 14 May 2025 10:17:07 +0200
Message-ID: <20250514081707.1059116-1-carlossanchez@geotab.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows slcan to receive short messages (typically errors) from the serial
interface.

Signed-off-by: Carlos Sanchez <carlossanchez@geotab.com>

---

When error support was added to slcan protocol in
b32ff4668544e1333b694fcc7812b2d7397b4d6a ("can: slcan: extend the protocol
with error info") the minimum valid message size changed from 5 (minimum
standard can frame tIII0) to 3 ("e1a" is a valid protocol message, it is
one of the examples given in the comments for slcan_bump_err() ), but the
check for minimum message length prodicating all decoding was not adjusted.
This makes short error messages discarded and error frames not being
generated.

This patch changes the minimum length to the new minimum (3 characters,
excluding terminator, is now a valid message).

 drivers/net/can/slcan/slcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 24c6622d36bd..d889f6a43e29 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -457,7 +457,7 @@ static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
 		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    sl->rcount > 4)
+		    sl->rcount >= 3)
 			slcan_bump(sl);
 
 		sl->rcount = 0;
-- 
2.49.0


