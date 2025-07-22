Return-Path: <linux-can+bounces-4019-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B68AB0D0A9
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 05:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8472B3A613B
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 03:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF228A1CE;
	Tue, 22 Jul 2025 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkWIxvw7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCF1CAA4;
	Tue, 22 Jul 2025 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156448; cv=none; b=G2wAxRi8jKp1Y05PZat1EbDoU15pXzepupi/dFp7vYPWjYi7t3SKMuAZe6M5+l32yN/RMsJGLIXxIcc56dCSFEsZ2ezbF76iMJBcyfETDz1+YmGZ04vMYB4UxxysLQ40LuvWzm5O5KVwGyVo5LN6cMLiSgRcbKBPHO4m/ZtEpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156448; c=relaxed/simple;
	bh=hCdryV5QFRBfr2B0RVaRuQUdv/Q1jzCNPLW3U5UJdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrfLeTseXbCtON2UFXa2pJIu0cOFVtmmCC3bDJrXOJxWMy6qgM6AKuVAi5s+WD9COH4UpgYRVK2z5xW2T2QUuKd7jxt8p5a9rQvO8paw2JHos7dcrYoTstCTG2FTYr8o63YiD3VQWTVoiqLM/SwP6MRxQ51Gl12uGHJIPOQl4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkWIxvw7; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-537a0d384b2so155562e0c.2;
        Mon, 21 Jul 2025 20:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753156445; x=1753761245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21ekDrlNtK124pRxXdO9fUdOwEz2jnVWaTrXgj0bM14=;
        b=FkWIxvw7Y/Nc4vtk9hUSsHdRloFc52nNRDtbUDIoWCZ32cK134K/Kn2JRwMRk5j+26
         KTG1w6oxGSFUukILZnXohN0ZeXID/y2xiZXXOesyCiTZJE+YJd0Jm8vqOSkP/WGdK/Ct
         4wrYrZqJeqJxnog4AOcP6woFT7riMu93V3XMjmbPVXgITYfdXb7iTAXYz5Re7hDg8z/e
         chy+5m7sWF1wkwQYxvzxsPwLbMKWseDXo+c405FAN5ZWP6Xz/WLUhYzhMDYXDUjzWT5j
         Hoc67qtHqs28ueZaWD5wHFixmfvHcGbQzgozJWNOj+1rdXoNXvW/9knN1hVGz8igLAjP
         jZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156445; x=1753761245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21ekDrlNtK124pRxXdO9fUdOwEz2jnVWaTrXgj0bM14=;
        b=gayBaFwrQ2P3CMrrxMdoWE4n4Yqv5Jnf1d0T3OnMMC4E+Beh1tDKzg0Y2hLAsWirgF
         N6eRwAI9Wn+R0h4vP+DzZjkOjUdZstvbl/Ust9WvFAPS8i73weTpEhUueD3esFL6Nabc
         VjykNPCsLH2Tk2/cb6Sj5Rb1007mIZDCyFa/7PIRKiCfPucXyJn8kl9s5NZEMYeYg/up
         khNK+8QipmKIXmH38AEQsKw7HqAGHq2jXVi07kBNfPjY3rL4X0qGDkkE/XyAAJt5bW1d
         mvX6xizx52GNinCQxsuK6kuz+350Dn9uc9xC2XGHdJfYcerrlc3fL887ZZZgnJt16fhB
         s7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW04rMcE2Bf8cbEr5Ro3B3/Mz0qxradw18yoGAudXncDgYoq2RUTol9oeTxMCQodk6dSTZNUiyRYumKN7z2@vger.kernel.org, AJvYcCW0yUKtOaXFiFOSAAPfoo0euqoJYMIj+QhOrE+sXEJ7yTvIX5vpkI/FsaSq9EbUCWZUssivJGzMz90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHAocWziOUVWm63Qy4zzJH63EQktNOGiwQfhBdh1U7xByWKN/
	I8ca0pUte8iAcw0R92WSrpqLbcErvt+SIWNmAL7VVAJm8EYlsCZ0alZx
X-Gm-Gg: ASbGncuOYENCQN2581doiITMhZpOa8G8ZpZxKIyD4KNtc30yyzlWhDSY5qCuxXf/0cd
	wH4UMeRC94uDnRgjLxd+08Q0hXxWHsQALI4oO6j8RZKF/HqkAxjYuHkx8cfBAzW9fruDd6+rsPg
	fHQqNzMzjywvw/+1kojUrgSt5nC6f8Z3kAmvqx6Jsi7+HOjSCNxbh24XX4wTgMLwqQ1htGBjLAe
	wThJlaSnSOyg9wdVGcIBbkXUkHUNZ3DTSbrL5nH21xTDN5m5M91h5p7YHgZtTh+TJkq45FT6MZO
	twtCw7wPgQaxBy+Ch0LpcRX0cre3fJ+C2xkEUEVmJF6b+CeH9IwegWND2aiVjqhEf2By6zPMX58
	CyLlWpYU1Un9WJyGyw5ddZik49fxfP54BxHin3IasD79315qKFoPSHqip57cC8BPcUWNbkYiBV1
	C653JixQ==
X-Google-Smtp-Source: AGHT+IFuz0ehb9BOLO/9vlqICsYb1/rPA68CDWJySSMTqYmS9ifVuxgRbdtqjxGBix8ZzTUfvMHVrw==
X-Received: by 2002:a05:6122:45a7:b0:530:6e61:d1e1 with SMTP id 71dfb90a1353d-53764739eb7mr6529696e0c.4.1753156444711;
        Mon, 21 Jul 2025 20:54:04 -0700 (PDT)
Received: from 9950X.localdomain (syn-142-197-132-170.res.spectrum.com. [142.197.132.170])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0add3dabsm3496078241.32.2025.07.21.20.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:54:04 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Subject: [PATCH v3] docs: Fix kernel-doc error in CAN driver
Date: Mon, 21 Jul 2025 23:53:52 -0400
Message-ID: <20250722035352.21807-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc formatting issue causing unexpected indentation error
in ctucanfd driver documentation build. Convert main return values
to bullet list format while preserving numbered sub-list in order to
correct indentation error and visual structure in rendered html.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

---
Changes since v2:
- Focus only on CAN driver (GPU and I3C already fixed by Bagas Sanjaya)
- Remove blank line that caused unwanted 'Description' output
- Keep numbered sub-list format as suggested by Randy Dunlap
- Move changelog after cutter as suggested by Vincent Mailhol

Link(v2): https://lore.kernel.org/all/20250720152401.70720-1-luis.hernandez093@gmail.com/
Link(v1): https://lore.kernel.org/all/20250703023511.82768-1-luis.hernandez093@gmail.com/
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index bf6398772960..8bd3f0fc385c 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -506,11 +506,12 @@ static bool ctucan_is_txt_buf_writable(struct ctucan_priv *priv, u8 buf)
  * @buf:	TXT Buffer index to which frame is inserted (0-based)
  * @isfdf:	True - CAN FD Frame, False - CAN 2.0 Frame
  *
- * Return: True - Frame inserted successfully
- *	   False - Frame was not inserted due to one of:
- *			1. TXT Buffer is not writable (it is in wrong state)
- *			2. Invalid TXT buffer index
- *			3. Invalid frame length
+ * Return:
+ * * True - Frame inserted successfully
+ * * False - Frame was not inserted due to one of:
+ *	1. TXT Buffer is not writable (it is in wrong state)
+ *	2. Invalid TXT buffer index
+ *	3. Invalid frame length
  */
 static bool ctucan_insert_frame(struct ctucan_priv *priv, const struct canfd_frame *cf, u8 buf,
 				bool isfdf)
-- 
2.43.0


