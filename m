Return-Path: <linux-can+bounces-5271-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A52C02743
	for <lists+linux-can@lfdr.de>; Thu, 23 Oct 2025 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7180189B0A2
	for <lists+linux-can@lfdr.de>; Thu, 23 Oct 2025 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256C239E8B;
	Thu, 23 Oct 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFIxpRiU"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9DD515
	for <linux-can@vger.kernel.org>; Thu, 23 Oct 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237073; cv=none; b=JjmLrnXmis2x9LV4xrTPWKDz576Yc2OnYafF0sfP2KETppnO0IhIid0VzbX9AtxDL9eCmqsXR+7g2GIwHV/gYcIutqw7VYyP5bLeRYyhVgnCdC5rJM6eQIGXL8fjfW89yfoGBCogLSbNGBni/c3SLeF69bxmAlKsyNO/+Ac5038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237073; c=relaxed/simple;
	bh=d9phPOIoXS1Mylr572coFt0mkocsbLyAVoqf4evoUog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A05DDOqWuXs74UIEaR1OUO/xidnEj967WkZP0SYACcgBVlxUzKsUeRBk+WlEVSvW/XblmbMTZ5ncgomv/IWIkIqjLy57ataHx12hM6nH2dSf0INjLFmug3z0ywL/wWodTCQA+Y0aDq9S5jCfgwAZg4Zi6nFCenJe/vbZ51Vq5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFIxpRiU; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-932b71d812bso514678241.0
        for <linux-can@vger.kernel.org>; Thu, 23 Oct 2025 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761237070; x=1761841870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aJn+juvkfPf0gBRifqdOc31eW4SLDMd0Q6v5JVV+ZE=;
        b=MFIxpRiUtzuQHmibqhKU8jJcLk/5q9j7Qr7NwOui4hQPZtEzsTTgfS9HeL7F1lp9FN
         R1FVzqJn17hDUWVkVxTv6qkgSQ3YNVcYtddgTbcHxa93MsYyrZPrdG+Qqw/V9HQ2dPTd
         OXC314TCKKEYeT0tZHqGxKeLpEbROzQaVT75wIMYgHH8aGdTRVYCFECPXghs/H93UIGt
         ml61097JTIUkFPbMT/3+kP81quW0QsCZhLY9uKv1pWYG1ULdEVTU+X3DOgZjijwvbCX7
         587aDHrGeQ9q9ZxkiHLadNHFd3sS2g4DsJuY6VJEBsALg5Mwe8Xr/fQevSu+bn0hZ+q7
         j1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237070; x=1761841870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aJn+juvkfPf0gBRifqdOc31eW4SLDMd0Q6v5JVV+ZE=;
        b=dfrtQjaOBKtUevxsy7wDwdJoDYLsEsPqFyVBTL00lMHn+DEN6etbvAHylPTZKX/Btn
         Q5t3rnzSe3ksKflGvNzuu5UmPSR5j1NtWCYo6zKc5qV5koGf99NhCV774kdo3JMTL5p6
         RE9vgJ0iOpUQsOH8kC3gbQJFb5AEifn4b5xjSAc29eTZS7cMoQcOI5EtGdsXYT5D1IDC
         2MRJLPdFUTigvyP7+bH0jjGopDqEUvhp2412UCdE/PTM8bW8iELt1gXGRlHT8zC9rgKh
         Gup10XbIs7j6ukvziRrdqbXELfYbjY271U9oBicXLyw2aaID1SeEQRt5KeFaHRp3meyR
         3QjA==
X-Forwarded-Encrypted: i=1; AJvYcCWLWfQyoUMDbP48n3vNBNRbY7BDtMiiCx9lAdHkBRCkihyq234fyrm8UrPWIySUJRIaP80JcPWyqvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfIlTXsXk7g/0hhaqDuaDurqaaWuNrkcHyIikf1oCE7DFUwn7
	LePjeB0CXvzi8yWqpyg/LVhsTzY73jgbX+F8YLes4uxsBjjJhnHBA/4n
X-Gm-Gg: ASbGncvcBXSFsebubRS0EsWkNhuN3fzh6HMtvkupF/w7zAWdLALHLtIfuIUbnfjsiDi
	kYS6Z/g5BJtssRiIQUJMI5ULCk5dJMt5EgwNxtHP/iSz/s++qFZEN2iPq4m5txa+cx1L3EAkKpW
	Lyp5EBoEvKdCg136xcmws0BoUJsKQjI9+EJli2JyO4WiBLEUbvLMwRk8jWPWrz5L++fMKNVIkNc
	I+EaNN9uixidLnJ+BACvSzLnSz74gvYX4E0xmPIn29zsiAN9N+FtAOPABYGl8aMFJOZ6yJtOzoc
	O0K0SUUqw6+8XtWTXlqPzQXgEdYWLJtFgo4FGpHD6vjpOKBgeIMMtWX+uD8yfzyFVT8vNV2rHMn
	ecgJgY3ItHuM4kxm0BtiswIFOE2uFcUB16aEL8WDdnpCzza+9lG2MH3QgLkKLntIfHz20BhClOG
	vGlThm+Xbzz57GA6nT+/cE1oehTYO+Nzx9O3Ox7H3Ai+erMgiNe/gVWde4JKIgszQCL0AaNpMnU
	Y0je0L/EslopxoOIWxL4axBFaYVaqgO
X-Google-Smtp-Source: AGHT+IGrVvs+TnclUt0e8B7CFqCvUQf6Cb4TKo6WF2EpRnGombTba/6VdXIkUXDiaJc1GXH7IIHQLA==
X-Received: by 2002:a05:6102:4496:b0:5db:2715:d029 with SMTP id ada2fe7eead31-5db2715d99amr2100695137.43.1761237070297;
        Thu, 23 Oct 2025 09:31:10 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0dbcce43sm191757485a.5.2025.10.23.09.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:31:09 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jimmy Assarsson <extja@kvaser.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] can: kvaser_usb: leaf: Fix potential infinite loop in command parsers
Date: Thu, 23 Oct 2025 12:30:46 -0400
Message-ID: <20251023163046.349300-1-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023-athletic-courageous-pogona-1405d3-mkl@pengutronix.de>
References: <20251023-athletic-courageous-pogona-1405d3-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

`kvaser_usb_leaf_wait_cmd()` and `kvaser_usb_leaf_read_bulk_callback`
functions contain logic to handle zero-length commands. These commands
are used to align data to the USB endpoint's wMaxPacketSize boundary.

The driver attempts to skip these placeholders by aligning the buffer
position `pos` to the next packet boundary using `round_up()` function.

However, if zero-length command is found exactly on a packet boundary
(i.e., `pos` is a multiple of wMaxPacketSize, including 0), `round_up`
function will return the unchanged value of `pos`. This prevents `pos`
to be increased, causing an infinite loop in the parsing logic.

This patch fixes this in the function by using `pos + 1` instead.
This ensures that even if `pos` is on a boundary, the calculation is
based on `pos + 1`, forcing `round_up()` to always return the next
aligned boundary.

Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Apply the same infinite loop fix to kvaser_usb_leaf_wait_cmd()
 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c29828a94ad0..1167d38344f1 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -685,7 +685,7 @@ static int kvaser_usb_leaf_wait_cmd(const struct kvaser_usb *dev, u8 id,
 			 * for further details.
 			 */
 			if (tmp->len == 0) {
-				pos = round_up(pos,
+				pos = round_up(pos + 1,
 					       le16_to_cpu
 						(dev->bulk_in->wMaxPacketSize));
 				continue;
@@ -1732,7 +1732,7 @@ static void kvaser_usb_leaf_read_bulk_callback(struct kvaser_usb *dev,
 		 * number of events in case of a heavy rx load on the bus.
 		 */
 		if (cmd->len == 0) {
-			pos = round_up(pos, le16_to_cpu
+			pos = round_up(pos + 1, le16_to_cpu
 						(dev->bulk_in->wMaxPacketSize));
 			continue;
 		}
-- 
2.43.0


