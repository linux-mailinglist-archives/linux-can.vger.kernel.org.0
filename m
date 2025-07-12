Return-Path: <linux-can+bounces-3969-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A2FB02AF4
	for <lists+linux-can@lfdr.de>; Sat, 12 Jul 2025 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E570A7ADFFC
	for <lists+linux-can@lfdr.de>; Sat, 12 Jul 2025 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACD0223321;
	Sat, 12 Jul 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5yLnv8t"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988621E489;
	Sat, 12 Jul 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327376; cv=none; b=KxIgxXGqcMQBU2/T2qSZV8a5XDmV8L+Drx9wrv3D+PSbJid3L+zXoOizbFP4P0ZB1SkyMn9aj/jDfTyTy/2vu/Lz7Rz7wFc9MxiNsPDLhgvqAqdpY8q/4psIepEt2W0yX47ZkUyer2ArFLNQwa+ZD1G8U4WpnsaR1mVe1uGai38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327376; c=relaxed/simple;
	bh=fI+EHGaEFFccDbypWav4Dk55fmRU1wtd6n3cxWUVsGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U439KiG4rknwww6n2M9go1h8wn3reehqk3fyAPGErOy4K7oAk6IPcl2fZxwf0ojIejrMZHV7lfHyk2JD/2ZB+Igxtnm92XbsHsVPp2ZsyogysNu3BS0vvduI3dR7vEvJePic7PEnB+IJvBEe2AN2qJz7Hfh6Ocb09dBCM1Tl6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5yLnv8t; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45348bff79fso36926715e9.2;
        Sat, 12 Jul 2025 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327373; x=1752932173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8pUZ0sv18MpoDhK/ify1e8p2zlKRVv2EfUxVJ1Ymfrg=;
        b=R5yLnv8tw+8eOuyOsm6GIghqgbIXaqK+q4D76x+bFsLQKrAX1H9ZU0wTcc1j3/tsIh
         5s2Uf22F2+L8t9hTc0UGKRIQ3SPav0n4vgn1GuqP1OA4JjjTi0y4Hs6JsZRZ5OgMc1L4
         EWCg9Z46F2FvCHABugB5/qwLDpiSXJIhKLKSAYtPU7kA0XrBl1m3h+DMqXZwdFoYZLUg
         u8FCmgeQDpCuxGWiWrns3HavC4HMhwv2dTYnG85IdgTJI3wKJPiK0uYpTtY/D1WHhvQm
         hSvHcCfkF4b+Xifz9tV4bmL6gOM+l/bdDbKPyg0nS1s1SVfAzmn+TUNZ9uJhwJvwoeQi
         qzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327373; x=1752932173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pUZ0sv18MpoDhK/ify1e8p2zlKRVv2EfUxVJ1Ymfrg=;
        b=W7a4zdMUSoeH6mCilwXBQyRN+LU9i2JRIxGILcEJfQplXQJXEln/ZUVw8ohhsMOIA/
         2+jthgiP+yejJqNNi6wZjPdrvHnGku3ZRaehkODBCu1hnWb+zdoHCbLWnrhZ7S2p2m4J
         kiqk3fqHuYwIfHcZ3PeomwkMgPjbJDd6yS/6SYTKpnl4d3RXcb5auZeFhFkHI+VZZT6O
         1KwL6phSW7266eOQ3tnpAjkTcDZubhjfAdlaueEyJw7/0kYQNWQ6rWMVXBlbzj4oTE+X
         2mqTvtN47qEU3mzIAdKkrXvvWyyof8DrvDlDOj0BuY+NcLgZmIf+SidjtjLu+SIn4HIP
         mJNw==
X-Forwarded-Encrypted: i=1; AJvYcCW1yDX2LAN1fQvDWebHgdxMWJXEiJ6dLBg11OgxqWR+b5G7r7hag54KMUG0NM8yo7tqXSp8IrCtcQQ=@vger.kernel.org, AJvYcCXjpkzgJ2vqK6Oc/yFW7RV1clANM8q4MAhXiBlfJ88VRevR2Ko3zwzDY7wCHVOKmJj7rIpMCkcLT39YKS7i@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkZ35Z8HTd74yOwEUerbloJZcGp/yNSxVtza/nzp/P30jWR4t
	1n0bB0g6cLkj+DjFgvJWTj9ytEo8XHlT107lEP6sNz/VOLALLNVQGGIm
X-Gm-Gg: ASbGncuTmhAvw3lYUj1gvz71kweqytpdmmfBglNYuqyTkrt+7A+wb3a9qcD+znfSy52
	Q9IrWCeaRFClrOiOUajWxZYISAt/lLUOvB9Hv667aopJMH5dOG8IL/8p6m57bKYoxWlbTP75oiH
	2Or15trMfxcvDY2YESMkpjYSnnOFN3CcTVqev8qzV6H9l/19hL6RjQ+jTYOCHwOzj31zHhNrHxT
	KPXapKX7rivkLOe1cyQ6ZL+dYFNOOqffLQ3BHnLh0MZcdinu1yAReCU9qCAa7baQAnybddkGkLd
	UvefIG9S5bGQfwFwB37FQ+T6Lbd44NL8bIBnhW3vLXfEExESHPPs8yyLiqqo5HqFrJu1+K67OAm
	XaIIPK9XNkxmZ14ze4LwVUD5tShq2B76gQd1mVpkAG83pmyA=
X-Google-Smtp-Source: AGHT+IG3HASTYf7cc5krk95istZ2ht/IcmtfyDDIqZ4We3a9kVh2QzYvzU9kqhCv8kKwdXp7OVDDlw==
X-Received: by 2002:a05:600c:8483:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-455bd87a4a2mr54822445e9.4.1752327372582;
        Sat, 12 Jul 2025 06:36:12 -0700 (PDT)
Received: from localhost.localdomain ([154.183.63.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm7241267f8f.22.2025.07.12.06.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:36:12 -0700 (PDT)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: janz-ican3: use sysfs_emit() in fwinfo_show()
Date: Sat, 12 Jul 2025 16:36:07 +0300
Message-ID: <20250712133609.331904-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As recommended in Documentation/filesystems/sysfs.rst, show() callbacks
should use sysfs_emit() or sysfs_emit_at() to format values returned to
userspace. Replace scnprintf() with sysfs_emit() in fwinfo_show().

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 60c7b83b4539..bfa5cbe88017 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1867,7 +1867,7 @@ static ssize_t fwinfo_show(struct device *dev,
 {
 	struct ican3_dev *mod = netdev_priv(to_net_dev(dev));
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", mod->fwinfo);
+	return sysfs_emit(buf, "%s\n", mod->fwinfo);
 }
 
 static DEVICE_ATTR_RW(termination);
-- 
2.47.2


