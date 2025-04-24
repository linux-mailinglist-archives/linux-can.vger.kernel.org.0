Return-Path: <linux-can+bounces-3474-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615BA9B0EC
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 16:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC694A5C07
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E11D799D;
	Thu, 24 Apr 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="IqtCuEPQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792811C2335
	for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504853; cv=none; b=UIxo3379dF5qUcwdsXyKuDlbkjfoCdnmNkuDkTeD1ikRFGP5ZP3N8etp1akkrbuykP8l1dMxWYgFnNA5SukTamVt/HnAfqUuYh48nRVGKU8ALNvP3XpjiCg6NUjk3dP9obDFWXsnar750GC8Tq5dJyNeZs5ZIr/LaKSGRUgCn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504853; c=relaxed/simple;
	bh=F1YJqwR1H6hHO182e1YH6Y4+1p4GU9R6+42/wafryRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6y7BONTwl/MQJpszdnXSpAqEbUKikmgWN/gDHlancoLiRtje2ZDMhWNuu4oaXUyUqxqixeO/LoBMd3AnSNYmqDOAZ2QzgI6cZgisTQms90Sr8Ar1Q0VA+Jvcy7ORxqNgCG2f9PxGEXl0h+yPvHe1GhX3hc6Iep4jUwbovcle50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re; spf=pass smtp.mailfrom=mwa.re; dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b=IqtCuEPQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so17407555e9.1
        for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1745504850; x=1746109650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9d7NqJO4EtxlTXgpDiP0f6RU3e65rl//+9+R1L+ng+k=;
        b=IqtCuEPQUpQMNLHzsOc5SxDZc3t5OUcDXKalghqn9t5FE1T5lKx8XoeMMYefBlf2fQ
         ffo5qyIphy+Fv0O+koPexCt0JvkyQkGswz1S9Hr95iCZ5Ttlt/PcDlRuJiii9+kfrxqR
         m//xbEjJNhQglkjL7Sd4fdMYRNqxH6xzViXGN9GPTx+klAuRyK5dL2t21eco5txZMM8S
         04PpvcR833x+J7zcuYoRL3ymrDMyZiWQGlOqkiQvGlItRcFiB9QU/6MPCfArP08pBlKK
         mr7ziVj6ous7cB2QvA5IazY0jSiQVa8igOo3HFqs1WY0PkzQHu1HKeIg063FZ3ZrhNx/
         OMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504850; x=1746109650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9d7NqJO4EtxlTXgpDiP0f6RU3e65rl//+9+R1L+ng+k=;
        b=LqRteXO0AS0eIUx+Q0CTb7n7yxPKXubyiZoCazLewtuE5rgzAVcsmo4wDllv+EUy62
         JkaJeNyB1MEO44RdQlMa43FIwSFdcbXc5OmIRguwDzJX9gDOpSmdrWGNSZNOoKytx6Qi
         BGcGdmDjqBi9x9gbHJe3vlbDLJ47aIERbhmx/tVW9gX/lt6FETlt/5fQuXbHwBplT5gS
         3QQH6ACjMAn8/oB3RWqHh05tUY6FFuGnP0oRHRBDucIm21OwaHmzmHUAlhd5FpCrUvzG
         3i7DTexjbjzU1YRTbqBdzQcTkkTDOUOoKnJxWrUCzZ4m+ldt2gNqeF+R+5D10igaKMR9
         eY4w==
X-Forwarded-Encrypted: i=1; AJvYcCXFXDugytTwAwTOaWmYokoE1BvxhRMSyy+/4SmFTJ3uzhZYrrRYfTfMzHfw/gnLEwR+MomA9wVlttY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8mPT2+mFYxgV2PqM2gEswllUOGLt4B1sLJPRkL3S3nB9UhGU
	3TPPxRZ5F4WO1/OkSP0saWg2o2DQ+xEkzgtximzDkFXcDVUMTA3P0FeCqVet4mzpOOQYDuruqcw
	1QEw=
X-Gm-Gg: ASbGncsB4MirA7k5H4JVIw9rj/8IApo76+z2WjdrxCUuYdfzzECA15fImxQWe7wbGBr
	d79+ng3V2O/H8mF4wBoCBQje6HM7QbxA9ZWpt9/mxBbtYihYrNzOoiUrsrNvM1ihPWRk1NxWssj
	Alk69myUnYT8alxMG3eGoteht2jWDE9ewQzWU91ztO93m3XN4U+fmgyigXzo/rM4bkPvhHMFAgR
	tpTXF9jdPIhx4jHm1O7XWm1SCqK6NDpOVmgMzuin1f35lEpZba7pg+NYsz//ZwBAYeXzzqZSIzh
	8+MJgbylY0xnpTbu4boKl8s9zHLagDr2SR/CG2S2+WkflyANtgoYULfGgNs6T9/fXxch6UFRzmB
	u
X-Google-Smtp-Source: AGHT+IEMsAKqZvQKv1HURFPLcJMP9q2fFIiW//bzYr0WFnNqRgNJbE3RCkzOZJu0K7dFBbOpVgGL1Q==
X-Received: by 2002:a05:600c:91a:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-4409c4938ebmr19886315e9.9.1745504849577;
        Thu, 24 Apr 2025 07:27:29 -0700 (PDT)
Received: from mw-ac-stu-3.corp.mwa.re (static-195-14-251-13.nc.de. [195.14.251.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2b892asm22807565e9.32.2025.04.24.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:27:29 -0700 (PDT)
From: Antonios Salios <antonios@mwa.re>
To: rcsekar@samsung.com
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@mwa.re,
	jan@mwa.re,
	msp@baylibre.com,
	Antonios Salios <antonios@mwa.re>
Subject: [PATCH v2] can: m_can: initialize spin lock on device probe
Date: Thu, 24 Apr 2025 16:25:26 +0200
Message-ID: <20250424142525.69930-2-antonios@mwa.re>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spin lock tx_handling_spinlock in struct m_can_classdev is not being
initialized. This leads to bug complaints from the kernel, eg. when
trying to send CAN frames with cansend from can-utils.

This patch fixes that by initializing the spin lock in the corresponding
device probe functions.

Fixes: 1fa80e23c150 ("can: m_can: Introduce a tx_fifo_in_flight counter")

Signed-off-by: Antonios Salios <antonios@mwa.re>
---

Changes since v1:
 * Move spin_lock_init from device probe functions to classdev alloc function
 * Add a fixes tag
---
 drivers/net/can/m_can/m_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 884a6352c..12e313998 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2379,6 +2379,8 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
+
+	spin_lock_init(&class_dev->tx_handling_spinlock);
 out:
 	return class_dev;
 }
-- 
2.49.0


