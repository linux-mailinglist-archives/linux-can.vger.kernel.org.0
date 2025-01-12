Return-Path: <linux-can+bounces-2599-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4DA0A941
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9228163016
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8422E1B4137;
	Sun, 12 Jan 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wcu/ZKci"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E31B372C
	for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685735; cv=none; b=GTBEyGXRgF9hD3SBHQWN/qKx+f+K3NRdSKuSThzDG93Oe28BrpmPkMGaf49yRmHtaOUx5lOYRjjvPK5rVUj+/aU8rzFyoV2jE0iFD0WBqca6F/soUkiWfpnlshzJ92aAdWw/IA7JjinGzzsINQt9HxV0fQ58dDt0G7Y5c8PTCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685735; c=relaxed/simple;
	bh=qrlM7T6H2fgnTJvFz41RiFpIAjbxzTfr0G3dabfPss4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iinyzIupIr3LMaTLESyJHvT9JK14dnpfzVPlF4N6PNk3A/hw3aRaFGzXj5YlxfQfT8mBUuCVA5FKh7j7GwtCCjk4Zft9ot62MBPLBtS1/sk6TPF/EbMzvIbY2wwivZTncbzIFz45z75fBpZzEjShmqIwqPjESvzJXTJkYs77nn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wcu/ZKci; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d44550adb7so591006a12.2
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 04:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736685731; x=1737290531; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLB4sikWIL/mIwFvaGMx91yjqGZImaXERP5FvxO4HLY=;
        b=Wcu/ZKcik6qRu5kVhhreDMjalw/oRBQ/TNmPFh53HFlUNavPjuaYPkhsrROhE6nnaZ
         qZYp0iPn4hGLru6HYBExN9xvY2b7E5fqUhKTMHhEUo2BnMMjLuprBJzDQqGhJ2uQ+2ZJ
         mGqV2DVOSZ7ER0CCVyv/CxePfP97xPPu/0TrQGfGe23DIHaPsTmZWMupRCNShba9Wu0/
         V6KfyfNQ3zPdSulh2oJ98pAlC7c4qGDB8YfWNOgYt2QFcf4qfhJy8++5RX3bIifclXIy
         4l07kkYK2UEivmscF04C78ThojURp+MPwG2MkKSeW/SQxhLSC/kuSdX0jBq/vZ4mlhF+
         kDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685731; x=1737290531;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLB4sikWIL/mIwFvaGMx91yjqGZImaXERP5FvxO4HLY=;
        b=XFY01+DCZUg09WmDCsOM+9wa3m0SPb1UZzecfMS7L3cuFBPPF3fJrpyJQIiRWhZN7S
         zzILMefCkFEtXO9myNoFybrTH/V2lZXz8ZPelZ0wLK4Gj9+/91rk8Nj8eohpnBtbavui
         7JwE8Xox3JX1ks1mvJDHHNo2PioP+cWVzDaS4RLrpWG31Dg3kwgiSQ6nLoymFiEeaXDm
         QKug8OZYH7HMP7GjTGJj7VundL3mTuZGLkBLvQ5M/xc6tmJbubEeQZ1uXwH5qofCdaO2
         vdE0PJkVEgs6oZvywiJ+QhfyGKFbWyBC69c/wzeJsJW3GvIjAwO3vKb3X2v6dRL0B9UB
         CEmw==
X-Gm-Message-State: AOJu0Yw0wflLNTdU4ObY7PfwsKT9K/HTGINar1E38wSJIa9XW8Z4cD5g
	FPmIbZt+OmAetGu/quyMC2P1oYxu4qpK73Xhw2d/S+WR6/Dc0B+J9F7XERpKqUg=
X-Gm-Gg: ASbGnctBBP/Gci+L3roQK4ui7loPXigV1/3I/ZlkID+UDWxjaOMzeMxIa3DiB/S8tKY
	fBZ5tO/ieanbZmhhPT7GEffEPVNC7AzEmBIWp7HU3Oe+MbdwkRoj00XGBygxlLi8IwKH6aWXVkH
	y+ZYCWNiqOCHgqZuH46NJ2231JFFJ0TtO30zmfd6PlXfEScUOJ2h06QWLvvwH9FCz17vxLyNsgZ
	7LdiTbz0rvJuUwzgYc7MhhRbVPP0kRuQrMKM6ZRd19Pykj+CHUHG+vcHky229TKJR/epKMY
X-Google-Smtp-Source: AGHT+IHWPKjE8d5iio71FeRs+5Ax3a9uZzeiXAhefF4Im9a52Wt7iMrccdfD48OB5oA85L4hl+3U+g==
X-Received: by 2002:a05:6402:2356:b0:5d0:d183:cc11 with SMTP id 4fb4d7f45d1cf-5d972e0276amr5722575a12.2.1736685731492;
        Sun, 12 Jan 2025 04:42:11 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99091e9absm3777087a12.45.2025.01.12.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 04:42:10 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND 0/5] can: c_can: One fix + simplify few things
Date: Sun, 12 Jan 2025 13:41:51 +0100
Message-Id: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+4g2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0Mj3eLK4uT8PN0CoGRKTqpuYlF6sW5yYp5uUopBkpGBmXmySWKKElB
 3QVFqWmYF2ORopSDXYFc/F6XY2loAzIinJXEAAAA=
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng7ia4H8DfbdWgfs4VUOUFaTEkO4fVFgast1gK
 8rbx6HOv9KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4O4mgAKCRDBN2bmhouD
 13aSD/9rmUe+WP4DZYBQQwHcI3f7+ATbbb75gdBi0gNGUD7fYs2ZjQjwT8NJx56ibmkQEIaWxAx
 2BT7IHYjyxIILS38UtMAZ61npoaYLw/5LF3pvuJLbYQI4dAdFFp5hJ79FmducEKAOhBN6i/BC7H
 LSj3+Waq8YFpuWmqIGEJX6SZnuCjvzffVa8X/SLAJQKpb4gF6hr1+zfThr3YuxbtSaROPrk7elC
 xOUG2i/bb2hIEXssjPoZ8AHRzbc545J4jhUAfKs5Uwh/cM3/ALM6NW8g0cmUYzGuOsG1F+cIfW7
 vJF8sQPILqLjo+kKEd2tEARsx8Vpo6UbqTTX7d1KwriTk7rhdP/wyNW/XISEa5aDNqK7xCHONso
 /Fn0o0pAq+fAqgzYvruovj1+q1ish64KKi2NmSvRtYFCrpZxcMMqrxLJeCeeaqgcf0MmYOgdbPk
 gm8xbk0H6Q+MZ58P8gxRYw9P3HrgxZNArs9T8lUz6zQaKf6dBzK6yRu7ixS6Ar0Of9ifODX0PK5
 TGgNTWEn3jp+nDizfxKFX0wdE/gpvCjXypyaoj373tkj4z4oFRMdxJ4J0zKwfrzyIAO+rl1PvOb
 g8zwnzRZINsn5DP2l+r5aVyhiXU4oUtrpfjWHC7kfJX/G/1PIn9A3kV+d1bP46mjAoQaxAmUIGQ
 A0CpZhGYi13bHKw==
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


