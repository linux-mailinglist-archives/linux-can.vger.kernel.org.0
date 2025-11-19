Return-Path: <linux-can+bounces-5502-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CDC6F179
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 14:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4A20358497
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F03364030;
	Wed, 19 Nov 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aoB2xggr"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3E3612E7
	for <linux-can@vger.kernel.org>; Wed, 19 Nov 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560237; cv=none; b=hOWX2V6fbzgncyjcm+X6hXnwE44gcu+Mr3Ulz1ubtLApczSweZRPJ9TQyi6EOv4yt0Cwlcdl6olgA3mefuhyeC7jSIET/TTRdjhNVCkod6MnKWondR2vVPNuUlXDCkWuVUdMOzxxZfwnm8RFyFnW0fOMue0rW5Mx2tyxNYd2+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560237; c=relaxed/simple;
	bh=VJi5h6hBafXwIZSOPdPw+Xply1Gg+HlfNsbPBhLxrd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntmoJnL817jvPED2QRJy+w8UjvIpfg+XAXRyMbzIwm7dQiHw+r89WpbTncuabCBNkORwJUtEUfzfSNKtu3/+G02onQUTUtF75VhOOrIAmzCz4/5stCknf4RdH0qemDByx/PhHFbxngVAc/sNDLuwKBXVdc5y0dLFxpvKOYbS9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aoB2xggr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7370698a8eso724972466b.0
        for <linux-can@vger.kernel.org>; Wed, 19 Nov 2025 05:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763560233; x=1764165033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QQ1ith8T48aMJ66D7+NVHIhrwJ6NpSItV6GndfoqnI=;
        b=aoB2xggrCwKWrRN5+wEWdoUL3KlwE1iLbpqGvm6Qk2OurVtb4pbq5qa7oU/QAhH+Kr
         iNV/pOAn5BaeLF7TBhueZ9+ctnGfTDo7w8QGg3fHvgEewBXJYeP70V1juzwBv/3PBbdr
         56kro4w8DfKEm7825W/i525daMV1ybkPQhWULA8Y+HOhn28XfH2xX3INEk7Teefd2f6g
         M3LUSsACxBSCQP02kKeo18hpVaeZhmRTs5Uf62tDYgoxqw8iD0cJcHcDfAzmE1we8BVy
         S56CAMiRa+K8khI4Se590xvzkCHHjI1MMQ5RFSBPxY5b2XsSnV3kH5CF06CcbSMpkwaR
         nqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560233; x=1764165033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QQ1ith8T48aMJ66D7+NVHIhrwJ6NpSItV6GndfoqnI=;
        b=TK6F6Ug3eEoPjKZOf2MceA0SnX2T0rqJ9tO9NzOo+qCdP7V2ilAZqHh6CCMTHsrLVD
         NkzmeVsmugWD/lxU5TquY+5ih9pEtPSm4qK6qbBg2h1yjExlWRFqpselcxLq7Yx203oQ
         BD/T6ybWl3b6HBNzjiANa9NdtCcIMHBkPf2+znkUdX/J81UJcez34pgjxE7e62XIX1KD
         kvLxnycgrXlmTvfgXBCatLx+dI924Z4YaoALMgo0FjYgtiVDIkxAhNIraMV5Qa2+snhr
         S29FIyI2H+t4HRgQ/wZgBrinN97IraH+Wji69y092QROlfBAYslQuDxb8QxO6H1MlYML
         8d5g==
X-Gm-Message-State: AOJu0YzlG3tTYuwAVUEwvqNgVwjdAJVaSaP21wAjVZwQ8M5Xn+XWqr0D
	3MuBjkGMelvD9pvjLHShIqx6exT1CSL/BUuM7D3F6jblJ9ZHL3R5dXEfXHgNRuICG6buaNYPCo1
	Jq8wd
X-Gm-Gg: ASbGncuLaRns+S4xP3QZjl9+VlCVMB/BAksk9L/JUTmEOMhKlBWtVdJTIDBJS7kvk4X
	ebdRl4XxyclSlHU8yVqCOEsQEtSXPiL5fjCs1u866RHxUD5tirXey6+zexbPhcgaRbehfxzDIDy
	OAEPcUkScC2Nvt6xzV06rz0yYWTjiPlTejp4fS6JNyuIX8vv+fBDDBHEq1othw4rUaFZwG+rocd
	Zcf1lE54c95tt6Mht8wjQCp6C0U5dGrZxuxaEyH2aJGYUo5FvIRuytaZ0uFZ5wSB1een/GAaFlg
	TJTXZjUgBs7V3zTY/GXW7Nb3mT3VNTOwcAoTwEdtL0fhQNl1e3tuHtCaE88uZ9ReSG/fxeCELiS
	ZeYcyQxy3Z1FV9ddly9YPeIfU0FLan3lgbLW+gHhtPPRrMFb0XZazNv0jUWXzYmabL84G
X-Google-Smtp-Source: AGHT+IFNnNgZVCR8rmduSH5yMsuWDuoUdPuMQRoRtjbJmeoujjPDEmk+k9mVS0NcmR7CkCT1FaTVWg==
X-Received: by 2002:a17:907:743:b0:b73:5d8c:dd0d with SMTP id a640c23a62f3a-b7367be061fmr1703824566b.52.1763560229288;
        Wed, 19 Nov 2025 05:50:29 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b734fda8d69sm1604128566b.50.2025.11.19.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:50:28 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 19 Nov 2025 14:50:02 +0100
Subject: [PATCH v2 1/2] MAINTAINERS: Add myself as m_can maintainer
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-topic-mcan-reviewer-v6-18-v2-1-f842c3094b18@baylibre.com>
References: <20251119-topic-mcan-reviewer-v6-18-v2-0-f842c3094b18@baylibre.com>
In-Reply-To: <20251119-topic-mcan-reviewer-v6-18-v2-0-f842c3094b18@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=msp@baylibre.com;
 h=from:subject:message-id; bh=VJi5h6hBafXwIZSOPdPw+Xply1Gg+HlfNsbPBhLxrd8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzZ05IlF2yXfJ4vNbvp8cK3lVFxvIUzj+7dLhq5M79Mc
 KVoA9v+jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIfTWGf8q8PHNdAu1f9oru
 WLnHuGt92oSoORLfv7W2BN85cYWlZjUjw52wr8tutnziihWTEvAw/tRdbKW2oXzu5c3lZuvyf3n
 GsAMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

As I have contributed to the m_can driver over the past years, I would
like to continue maintaining the driver. As Chandrasekar is currently
not responsive, I will replace him as the maintainer of the driver.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..cb4130f66bf80392ca7a0e77a9b930f32a126af8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15393,7 +15393,7 @@ F:	drivers/net/phy/mxl-86110.c
 F:	drivers/net/phy/mxl-gpy.c
 
 MCAN MMIO DEVICE DRIVER
-M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
+M:	Markus Schneider-Pargmann <msp@baylibre.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/bosch,m_can.yaml

-- 
2.51.0


