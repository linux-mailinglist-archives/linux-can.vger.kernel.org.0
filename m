Return-Path: <linux-can+bounces-2597-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33DA0A930
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 13:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089203A74B5
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B071B2EEB;
	Sun, 12 Jan 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTdjstXJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618953C1F
	for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685522; cv=none; b=ipX9+9YxaKkNQrt4xHHB00E92p3xxcmXmXGzAVdZt5p11W+axMkPrOj4zlEJIfbQ9psasiOJ70uqrqPn7MPaZVdnBO1/2/O7lxnykNzCc0mN8A6Syi7PwVqbGGNcw4UbGC4zozpr2O0qt8b3ntCVor7OLjS81RGFHkwYdeg60mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685522; c=relaxed/simple;
	bh=qrlM7T6H2fgnTJvFz41RiFpIAjbxzTfr0G3dabfPss4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aSS83D0m6P7TycH8Wv6PKTZit9UdNBHtSplpe3Zjjx3jqNfUTzzebBr59AeWWMzdu2dygv17h/malTEbooRrZmtwCWQfb44dQ9dl5GTBaw5RluyA5SrFAA9Bewr0132SkRj45vq80C/7cerMmdlJZlVlkej/+imjWqg/GPwoMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FTdjstXJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862c78536bso161704f8f.2
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 04:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736685519; x=1737290319; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLB4sikWIL/mIwFvaGMx91yjqGZImaXERP5FvxO4HLY=;
        b=FTdjstXJuAI9B1w1aYgVM1aUk2hYTpmZ0zRZ0TyR2WmxFTsDOYN02pfFmbeD8c28cV
         WxJkXxGwQxXNoC/1Ew4gTDWsnL3wkxcLwMsGoQ5gzUKIFw7mQaG7I3vTNi3jhBW0tpGj
         GRpQimoWjgvGoC0GxszI3mUhDYdgAt24mqJXa8E8QG1FcBCFI47ciGOUYC+IcXY5MAu8
         GDQ6/A57yLrgzaiUjULQUNWBmNboHcaWJDveUK3+bvIgFxrOww9bO/6E66i7Qm+N2sve
         XLhrrVWRoHHLj2mGxJttRzcDidESjDa1u5PxRoNaBKDBvAJBDVpfwpnF1Pwy8l1ZrMVe
         fghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685519; x=1737290319;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLB4sikWIL/mIwFvaGMx91yjqGZImaXERP5FvxO4HLY=;
        b=o3FpsbYYsl9tjkTqejdJc89GyEyULPgVwpVd7SkCrbzYtR+xC7cuxhjv3hljn1jdYh
         pjt7VA672LX2x8fg8mZgHqog9ramROpKsdA1gBVTc7CXraYoKZ9Rvbkl6GVB7nJx3UvX
         ZzGT8AFO0D63w0iyZrtOtNTJFGFUGEWIfyUTWyzIil22lto2JFXMSTnvSfKYvoKmGHzm
         qDtjmY5g+98YnWQZxyZGpLzN3eyOjGvp8CrtGMZfvJYJpLGEgbYeZwnHnHSH3nZOQxH4
         tlJZlUpjDnGv9XTauTJEi6eIV0+cj3UQGlpHzaiywotNEp67OvYNPm4qpva3BSPLQZhI
         w/iA==
X-Gm-Message-State: AOJu0YyeUIX+HDBE2YVP1SHQIkMdD2s6dhq1NAV4KwLXSC+o835Np5qR
	PEiqq+yRqtXpK+Iwy/UVX4sBwp2+zZDLeb5nlxlskujW2Fo7LzfiAcRSKL8V2DU=
X-Gm-Gg: ASbGncte8+qH0MXPW9ghm397RKwR5or5lkx2b5HM5e0E+HMUoAtwFzXCRHXqOFz9BxS
	D0skNxK6E8LhrvKjfpT/ItPC19E/F2zQ29NlAwR9Mw2nxzHaEyWwRekRDmv9/LYVyUDP+lVmhAv
	IFwKM6ojsXdwDnol61fKNH1a5dF21NdYZoiGLbYpsrMcKBANGCxu3/DINcSPmSDflfUIBGID9dX
	ZHLvd9M8BbapLBkCQevBTi0zBpiK7N8wGPyRnSJsfr/Hl/A2dww3bdNn3az11rUzhE7gfRk
X-Google-Smtp-Source: AGHT+IEENxPDjWDHb5WXQq6QQexxosG0L61jxya3/pAQjWwmnY65k5QqKjCQQ9/lNogwi+jpO7naCw==
X-Received: by 2002:a05:600c:1c1a:b0:42c:bfd6:9d2f with SMTP id 5b1f17b1804b1-436e26867ebmr65847485e9.1.1736685518168;
        Sun, 12 Jan 2025 04:38:38 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d2dfsm9400573f8f.7.2025.01.12.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 04:38:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] can: c_can: One fix + simplify few things
Date: Sun, 12 Jan 2025 13:38:22 +0100
Message-Id: <20250112-syscon-phandle-args-can-v1-0-cb8448bf51d5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL63g2cC/x2MSQqAMAwAvyI5G2iLC/gV8dAlakBaaUCU4t8tH
 odhpoBQZhKYmgKZLhZOsYJuG/C7jRshh8pglOmV1gblEZ8inlWGg9DmTdDbiC4oZ9Qw+s4GqPW
 ZaeX7P8/L+36nJeIWaQAAAA==
X-Change-ID: 20250112-syscon-phandle-args-can-bd0b2067c4ad
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=805;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qrlM7T6H2fgnTJvFz41RiFpIAjbxzTfr0G3dabfPss4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng7fDb7JbXOQC6VW02hYpN5r5VNJdznk02jk7L
 J96qeX2w4aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4O3wwAKCRDBN2bmhouD
 1z/7EACJneoVW+zToG1wZ1lF/HjBQ1OBiha5xIx64yNj/oU5SoEvkuxtOCvzJ2oafWFxUPysKvz
 b5ITIWXaA3zyPZXVkcyJcHo0fqZUusl98a0Dd/k9XodNRCugDf7CfNUJEcjsWrLSN5khP3AJmc8
 /47CdNtnmQ3SigXZC3uAkXWuQpZwR6mgOAykwn6UzXXhBkpJlYSV6T8GbSw20qliv7yqRfxzf4q
 rMIdRQ2HqkH/C1qiRPZYDskfPr6j8wcpn1IMWKfyuQmmH+aoDs2HlsDwS2gybiCCkDHfNiyJcPY
 NXvjMWh1xmGBSiAqX5HaguHSdQM8XP4tBOE4sHh1M2YZLSrmC9kUwc2uR5RgTq8cFIDxdcr2ntv
 XyYTnXd5xWdxV++/zC2gylLtdF/kO3l8TdlvHcHxqkI7tUGb6VPSvWyHoqIyzSuFyak725ETRqS
 vX5l8/ORkohdQ6ErzxpU2Qg36u8PQXT7J8WEnTSBrj8mOzps+rW7bKwe4tNZLVfA6C5E93tCi+T
 Q5QNt3spxZAtGTecdtPLJ7gxfkEkLi9A/2nYFzAq3a0Vab+Q8y+MBWQeLxdar24dwri0vDrwMQ3
 Bz9Lv4UT9Jp6KcTaB1kb/lHpvQnAdkscFwURdJVZHxv15TPNOIlIpaMeOc2RxK+4alGAKMQbptD
 2NNWSL9jHT4QxwA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One fix on which rest of the patches are based on (context changes).
Not tested on hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      can: c_can: Fix unbalanced runtime PM disable in error path
      can: c_can: Drop useless final probe failure message
      can: c_can: Simplify handling syscon error path
      can: c_can: Use of_property_present() to test existence of DT property
      can: c_can: Use syscon_regmap_lookup_by_phandle_args

 drivers/net/can/c_can/c_can_platform.c | 56 +++++++++++-----------------------
 1 file changed, 18 insertions(+), 38 deletions(-)
---
base-commit: df04532eb4413cfaf33a8a902d208f596ba7c1b0
change-id: 20250112-syscon-phandle-args-can-bd0b2067c4ad

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


