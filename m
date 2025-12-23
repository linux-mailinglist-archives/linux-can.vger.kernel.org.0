Return-Path: <linux-can+bounces-5906-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9932CD79F1
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 02:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E32F30248BE
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36121ADCB;
	Tue, 23 Dec 2025 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2jp6rqZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2F142E83
	for <linux-can@vger.kernel.org>; Tue, 23 Dec 2025 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452667; cv=none; b=KIsxl1mXWZrfppJ79qsoTMb568g7QXOoiKgx1gFeF5oCVOcj+9psJPOzjDJzKKgzGWaz4oDyHasDzUycM+eXQjcdrPMqbJWOIaesTJiJhVqBseoEdQ5ubXuaVOpSRcrpdJKJZmxaPG1nd/S6sWSFQ+18P8iyth1nSdCqq5AhgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452667; c=relaxed/simple;
	bh=jT6hiLBq5q4z51RZFocOcIDwJLOFWMHSJ9DOh2olhbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqTYGa7nDoutQcL1D08Ol9ldGWve11k1dltKUa4HeTrDVfV8P7Ck7aRD4GxjEsIy5JybJMBcLA1iV+8W2WVYBu+0iQttQbAxnvqoBqpHWYXKuYyWGy2p+9KKGXbSkXdJefx64eLFF3/DBd4O0iKo4lnwiv8Dde5Zz+9WOQTMJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2jp6rqZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so3625368a12.0
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 17:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766452664; x=1767057464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgl7WyQT1L+2/9hOch0QFHkfuodi/5zfl/ryOv/mbIE=;
        b=m2jp6rqZMGfSO5ex0LOmn2R30StxAQCc3ptlyytwbqEqAPrsVst6W5Umh8qIB20Gnz
         qgxFrc0vxmNTxd2ntWGuvBs18mqBASOIDc5Z3mQ3/waun5s7huKvFZNlKaDQRO+Zh6H0
         SKTcRIS1uq0slxhTREVbXOjwHOpn40f5neAS5RR7z2j17U4Ne5i7sxU0mqFLhA+uduIn
         E6EeBM2VqLKa0YDB83N6x2cgYmtDRtDXBhCqrCrKfdNwf0n6yrKU+jFQzN4hUPor9XhG
         c+xdBNcvobGbE+M37dKaWl5lZUnmwxDIfi5KPW3sLiP/8f4cwJ1/qLA4NL0dFaOfIL92
         B8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766452664; x=1767057464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dgl7WyQT1L+2/9hOch0QFHkfuodi/5zfl/ryOv/mbIE=;
        b=X+b7hzJB6K/CnPnS8zuRFgrNOi4ZGAUue8EcwFLxLaXaKq1rfMzb1QCYEVTiMjWsUK
         81g6Cg486/vkfZYIejPZVhyZiPhfg55QhFQDbLanBtZTMOa7u5QsM3VV/mm47pTZTpmm
         vxO3CTixHqYfEWTJgYXxCm5LOAwavbU5v4ijxkelEv8diCfWHLJHxgXZUt16y/vn69AO
         rJ+qiklbWREFAELmUfQn3ig5TlK7ciBytRIl6Hx6DdqsCTJWpr5DXKvZpN5mWbiMK4ED
         OahoLMsyLPHjfC+NEpQNbdNhHQEXAeqbb7OxEhtSECzLIFNo44Cvzoa5DoYMRYA+/FMD
         NqCg==
X-Gm-Message-State: AOJu0YzDre9oj42BL6km4ogBRt+LPYKEe5uAw+W1cfuNrE/AyaMLRed2
	iq4hfxD/6Be3dzBIid71gz3FmAc8X8hd8eZGx/CFZQH506su+bTSHMYEUFGGln1U
X-Gm-Gg: AY/fxX5dY1yFikCnukq0n5ioSv+0zkr0JV7a6qFFXOpQ0lGOxrAyIM3RaPh6GcDMpBW
	qKZx2CB4GTq9CQIRePYA2IRN1/KCRb2rRZ4YwELQj2CpisIVoLN3pv9M1+oxVvMPA3Gdi1R3uz4
	RLHtbI1gFy5aADDLQwD1EnsHbJao8tbnODB7QiFTS1YSz4gyL19eWjAeGZ2g8U/Eo2Phhl7Iyh/
	hoPLrVgs2X/7lCeIeR2E6xJo4ITByDoCYyhi/uzgy8hAKkC5rqOgOku/RwSPwmJ7vXQ8V4zqc1W
	sfoXbQCUATnIRP3B40Silm5zrsnQaS0Jf4Livq0ohyWP+D+RoS9CUkaQIQ3zR6QroDUFZ2rExzH
	xygKRx/SZpJ8HWKBLu1CwgC7f2FguWsANK1bcWwR2WFW9+IClzTQK2VBTG+ElQB1VQL+NZ8c3RU
	w=
X-Google-Smtp-Source: AGHT+IGpl94Gzv/b9Ya4Ce30svn3/eP76iGOuseQDwrnjJp4YAVElMVa2HL226jZFYvOFfWc5SnLjQ==
X-Received: by 2002:a17:907:9809:b0:b71:ea7c:e4ff with SMTP id a640c23a62f3a-b8036ec9e3emr1191177666b.6.1766452663440;
        Mon, 22 Dec 2025 17:17:43 -0800 (PST)
Received: from prometheus ([85.11.110.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a604f5sm1257217066b.11.2025.12.22.17.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 17:17:43 -0800 (PST)
From: Szymon Wilczek <swilczek.lx@gmail.com>
To: mailhol@kernel.org,
	mkl@pengutronix.de
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Szymon Wilczek <swilczek.lx@gmail.com>,
	syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
Subject: [PATCH v2] can: etas_es58x: allow partial RX URB allocation to succeed
Date: Tue, 23 Dec 2025 02:17:32 +0100
Message-ID: <20251223011732.39361-1-swilczek.lx@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222154208.22117-1-swilczek.lx@gmail.com>
References: <20251222154208.22117-1-swilczek.lx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When es58x_alloc_rx_urbs() fails to allocate the requested number of
URBs but succeeds in allocating some, it returns an error code.
This causes es58x_open() to return early, skipping the cleanup label
'free_urbs', which leads to the anchored URBs being leaked.

As pointed out by maintainer Vincent Mailhol, the driver is designed
to handle partial URB allocation gracefully. Therefore, partial
allocation should not be treated as a fatal error.

Modify es58x_alloc_rx_urbs() to return 0 if at least one URB has been
allocated, restoring the intended behavior and preventing the leak
in es58x_open().

Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
Reported-by: syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e8cb6691a7cf68256cb8
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
---
Changes in v2:
- Replaced the cleanup fix in es58x_open() with the logic fix in
  es58x_alloc_rx_urbs() to treat partial allocation as success, as
  suggested by Vincent Mailhol.
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index f799233c2b72..2d248deb69dc 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1736,7 +1736,7 @@ static int es58x_alloc_rx_urbs(struct es58x_device *es58x_dev)
 	dev_dbg(dev, "%s: Allocated %d rx URBs each of size %u\n",
 		__func__, i, rx_buf_len);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.52.0


