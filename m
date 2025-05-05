Return-Path: <linux-can+bounces-3533-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97AAA9521
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05501794D3
	for <lists+linux-can@lfdr.de>; Mon,  5 May 2025 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2025A62B;
	Mon,  5 May 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q77tO/Fc"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB825A347;
	Mon,  5 May 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454321; cv=none; b=k5OzuUdlS6tNF9reAr9P0wts15pNBRGfdAj0l5jqd6sbz56+PYVAZ0mTTEB+wbESMk80XRHPf6RBbWMSIean1AGpryAN1O5Qr2vQAXdfCNwdhodu3/FlibncrlmXnM6OEHAij3AKmzWvOi3KVwS+s6YLrlpVd2V+9HI/BMJptaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454321; c=relaxed/simple;
	bh=BTWJbvtEnXkKEvmHaXNtXyFzO/kbUh+PwIlY1ssRUxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtL0cK3t23fLRPC28h1YbzaprosZKls1n3YNI+OaN0hS+KplxplLgV/GDte2VTf+2rAdi8a+nCIBzGOnOzhTCKNk2cUtuNhxQ8CUN3QqY861/9atLXm9o6jv+KnGQbjLkb7Zw1jb1okynXCCSabvW2nqUC8XwyQU8idSShDfkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q77tO/Fc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af589091049so3151956a12.1;
        Mon, 05 May 2025 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746454319; x=1747059119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fn5MKJLR7azj6ncvVFO/CDl6rBZRH4MiC47Hn4Xq13A=;
        b=Q77tO/FcOpgTM8J/RVc2lpOHz0ODMJPfUihP+Cz3xDy5ly4fCahAJkNGwepmYfYthS
         i5JqCElajEYkGtwakO6MvEHIOleH0CUfKngOrFIbdoQiGudhlIEI88cpCktBotnvaHZi
         H0Ym9jXJ8HAxlChOaBaPYHdTO2PLSluW5WAY/LIGHM++3Q2RcmH/63wKDWpmM+E75nvl
         MOr+DNosTNG+8KHAl2wg7rbqeZCmpkN1WJCDUOqtnRN48DQiTPSw2R19eNw3dPB5s4mG
         CYP9W+hjZHIAKJvxfBBWZKcj1sT1fEnVqIHxS23N5b5mK3v4F3I1vfN/ku5L3nQw9r+8
         rT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454319; x=1747059119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn5MKJLR7azj6ncvVFO/CDl6rBZRH4MiC47Hn4Xq13A=;
        b=l8sWmB3B5OwDk2Fg7aEDTqcF5B6d5XLq9RMUlB/3Bg9rjvgN0XNI0tE3YIR/tdCwzT
         pWN2EZ3DT0dNXWNAjGdoPjInk3JfX3qBQaFErqRqlyjXi3jpfUAv1XoV86Lds01rYpSd
         8sMFkD5GYWf/jaRNZb4Rx/2jIgX+Fg0pXe/iCgzTj7j3GzidMR3w9uYI0/PC2jX67pxC
         qZqels5A/S84VqRtKZ9SXuLEt7kwzdnneivDBeHjpbxC/vE3FJrokj+kDF3Pu/tcD34U
         AXSO8mta0zrGhmQqhlKBajm+nVojHVjwHgm+z/EG2s2No84BIgmjkGVuWb/8C9TPXoyX
         1NXA==
X-Forwarded-Encrypted: i=1; AJvYcCWvNEnoCg7G/bguGb1Tv5TPVSUh6aB9nnObOeQzJXBzy8mrbzjGZUxEL9ChuXbuvkgZc1CZDJElm7M=@vger.kernel.org, AJvYcCXIzO9qaYASN6AB3a66xQERW87YLBVbcQ/qX6Oamg1FMoGWx44+0eBpf3XEtUCrDnnK7+Gkz+9Zk8orq9Sh@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRuGiwLsB+lgax6s7q8m90Rh3/63DbKCenkDVRWmfFXTtxzHv
	uVqLhNE3bMzw7wrxo7YB8T5mpLe8L7hS0uFFsHgaCfxWZg/7gDnq
X-Gm-Gg: ASbGnctfS6oi9ZUgMA79zHARrosEsnvvg0zXYM3Vl2yi2I8VEtZC/tjwSj23J4Cgist
	TZNh8IssqWvUAySjDGeEbm7xMWlChAGM/F45KWLeXB4q1413yM2iQA8/nfi2XhoUyvv0rlEHqtw
	ieVTIrost8uvN/CEedpf/r5VJlD31uI3xSNxSNufxUiu2yaUMB1KopBHedo4FsBfgBX9rdimyIW
	YctJVrwQtSKj8t1LTG1fKALlXaCXi2qhWZ9x7f5+GlzBcuUyjy++SswtgDHlpSpocYtUP4pLjV1
	XGfgik4HxA90cFz7FgGLeUfMI6x9iyNbfu2JXY23bJTcuxTZJYV8acbeW3TATq23yEHjvg==
X-Google-Smtp-Source: AGHT+IHKqRuuX7Zzw40XE5YTylHTC/7eJCZt76O3bWHo0w0+el/U/vIlZShG608xW2VRiRR+thvl/Q==
X-Received: by 2002:a17:90b:270b:b0:2fe:8a84:e033 with SMTP id 98e67ed59e1d1-30a4e5626f4mr21790919a91.2.1746454319172;
        Mon, 05 May 2025 07:11:59 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:afa:5db4:54e4:f59c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4b21514fsm9232099a91.14.2025.05.05.07.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:11:58 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: mkl@pengutronix.de
Cc: mailhol.vincent@wanadoo.fr,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] can: kvaser_pciefd: Error handling for dma_set_mask_and_coherent()
Date: Mon,  5 May 2025 22:11:54 +0800
Message-ID: <20250505141154.673290-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ammend error handling for the use of "dma_set_mask_and_coherent()"
inside "kvaser_pciefd_setup_dma()".

Link: https://scan5.scan.coverity.com/#/project-view/36179/10063?selectedIssue=1631256
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 drivers/net/can/kvaser_pciefd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index cf0d51805272..e5b67e92f602 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1106,7 +1106,12 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 	/* Disable the DMA */
 	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
 
-	dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));
+	int err = dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));
+
+	if (err) {
+		dev_err(&pcie->pci->dev, "Failed to set 64-bit DMA mask\n");
+		return err;
+	}
 
 	for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
 		pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
-- 
2.43.0


