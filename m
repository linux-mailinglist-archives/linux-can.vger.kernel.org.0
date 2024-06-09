Return-Path: <linux-can+bounces-715-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D413901474
	for <lists+linux-can@lfdr.de>; Sun,  9 Jun 2024 06:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9676281FB1
	for <lists+linux-can@lfdr.de>; Sun,  9 Jun 2024 04:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C001171C;
	Sun,  9 Jun 2024 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwU0YvI4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262FF4E7;
	Sun,  9 Jun 2024 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717908893; cv=none; b=N02WGQYdxGcZp2LlT/XWGa2d9GFqJfzzLLTWgsa3gkuOTsX4yrQl2+xu+hOhJe2oONKr/4lIx66AgBF36DZRrmv5auFBtI2K+QzrDW+NH+t8HSJwlhfVD+8h8qcXIJ89crHFGL/mJc1N+2qMNnHydpWG3O6b2Xd36smUGKVGrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717908893; c=relaxed/simple;
	bh=FInk916v2m7Zh7+cgwypSrU7ivM0kVr+jqvRdof8/CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGoT9yEgXpDnh65RaODD7fPr1qDQARha7E2329VWhm0Qi/nnr03WnGB4oneNvPwnTM9sCPMLoIq+DfsCgzEgMFxPMeUoqyFxkpolnp31L+jvnHlcnu4rFNnaDsKUrZZsd9bgJ7SZDEoAbjbDyAfu8RBWWGRL7/xUrJqw6BEpVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwU0YvI4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70435f4c330so146910b3a.1;
        Sat, 08 Jun 2024 21:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717908891; x=1718513691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uc81iOGnINBSW07LGFje5b0VrHCOBORcUMbmc9odnls=;
        b=QwU0YvI4nq7eZPLibDKdaDfcZeqkP0gpyQzvkAdEdg/fh1GKTRJqQjG1O5ruBb/q+x
         urEZAoreGdXqBvKX/jzyjhsY7jancQGL42YQiJYaijoM4eWJYCHIAy3XOOIqMmnRJnwP
         ACuVY5pG/E7osypHbdcCtBWS34DdNqTZKgdPrx9vESgsGIyLp0T3LvbvOXHgZUaOWQQS
         bNzKY4sAdkX+UrBWmS0xNaaVqFEZ0MTVI9DNSujI+7QpA0VW0ZTMw3U93PbeecQT94v0
         aBv1wiNTtujW+w1wdTQg8bvtfTkkmj3uDXwN55bICbNXjy/hT4wKdkqefFTt2QYNBT+q
         yKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717908891; x=1718513691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uc81iOGnINBSW07LGFje5b0VrHCOBORcUMbmc9odnls=;
        b=mz7Kkshyu7URqd8eGVEYPiXujH5Fpbqv8XYSR7SaeZh4//Z0/ADnhnheGYFTEX1W8u
         Ik3ztumRmi2OZTGN9JbaDPAmvV9qxgwc3TGVnA9g4tW9C5svT4OQHNUUBnL2qNFaDV+W
         KsrzBWnZ4KAHcKuPTr/wbYE59SX0XD6J6zQ0tB72oCl8Yy+2PXk9kh9jgoZrzxUAOEYk
         qUNXBn1GMh6FXsTT7bu+gEVYD2kl5+zfTW5gbhG4BHHcs2zF1UjkhcjwIqXgZ3bywq/a
         4IgiAWYZ1Tltu9AF2q+xVlWFIvSv6dMYdlnUoJkJ/WK0vYpOIfph74YqbqTsXPeInPqy
         rJDw==
X-Forwarded-Encrypted: i=1; AJvYcCUftTXBfAuon8tM9wTDi+w0hzyhQhl1UgcT/KNBKKP6CH7UHLZW2YEOdAUIST+mhRbv334c6GzNda6GUfFBSFN155ctYj+/NEE82GLiASERhO0KFMavFknYIzofWrNrkzlbxLw2UWhpqNDPtMYHeW7RR99MjmVryGRKaT+Rn9yQxeUa
X-Gm-Message-State: AOJu0YxGVzsT1XIQZtYZe6yxICCRd/efkG887o7UJP/WpINUjMprQID3
	WaYsoBzTItgNz+0MB+lfX+MvgA4ZvGrHedOJRhOzr6nBMM83utbl
X-Google-Smtp-Source: AGHT+IH++yGmRIHsSRLOhbaqBfY4S5ssBnHrO5XjYlIacCU2GTuP5M1ap/QcAxYhZV1/HpMMjnSjEQ==
X-Received: by 2002:a05:6a00:4b14:b0:702:2749:6097 with SMTP id d2e1a72fcca58-7040c615dbfmr5874482b3a.1.1717908891126;
        Sat, 08 Jun 2024 21:54:51 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041ec6f9cesm2284887b3a.78.2024.06.08.21.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 21:54:50 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Thomas Kopp <thomas.kopp@microchip.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 1/2] can: peak_canfd: decorate pciefd_board.can with __counted_by()
Date: Sun,  9 Jun 2024 13:54:18 +0900
Message-Id: <20240609045419.240265-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609045419.240265-1-mailhol.vincent@wanadoo.fr>
References: <20240609045419.240265-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new __counted_by() attribute was introduced in [1]. It makes the
compiler's sanitizer aware of the actual size of a flexible array
member, allowing for additional runtime checks.

Move the end of line comments to the previous line to make room and
apply the __counted_by() attribute to the can flexible array member of
struct pciefd_board.

[1] commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
Link: https://git.kernel.org/torvalds/c/dd06e72e68bc

CC: Kees Cook <kees@kernel.org>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 1df3c4b54f03..636102103a88 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -190,8 +190,10 @@ struct pciefd_board {
 	void __iomem *reg_base;
 	struct pci_dev *pci_dev;
 	int can_count;
-	spinlock_t cmd_lock;		/* 64-bits cmds must be atomic */
-	struct pciefd_can *can[];	/* array of network devices */
+	/* 64-bits cmds must be atomic */
+	spinlock_t cmd_lock;
+	/* array of network devices */
+	struct pciefd_can *can[] __counted_by(can_count);
 };
 
 /* supported device ids. */
-- 
2.43.0


