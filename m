Return-Path: <linux-can+bounces-1507-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B25B97970E
	for <lists+linux-can@lfdr.de>; Sun, 15 Sep 2024 16:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28761F21AAB
	for <lists+linux-can@lfdr.de>; Sun, 15 Sep 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0011C68AE;
	Sun, 15 Sep 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeCzMfME"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8F1482E9;
	Sun, 15 Sep 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409923; cv=none; b=kzdi4yB50EAKjH8DAW37uV02RHmPL2847D8K8FyxJbV0MGagDob1gEyoeVmTmy6yBasnp9o1hk13cVL85NGR9Xmv2l1c2zznwPC0MQUzfdscr2SmVhjrPFedFcEZDn7FLS9SKAWma6SRWN0Q6wqldxB2gaK7omJ4vzQu5JTmfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409923; c=relaxed/simple;
	bh=88y25tEyOErulFJtKZhVzD9mReemQFebEhhHaQNAJ9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k67PnwHnaZ2bHeHGof7J6WZKV9YiltV55HejyytHgbaPea5XltHf2M6ms2msp/1MRWyhVzQ8CooGDrBhfEaJCDnCJI+bBojbKFfINqhYNF4LCqHd5zI8ZhwjU7ZtJo6KeAYisNAg6+V643Yl/s1gnXvA3Rcpz+f1QE/NU+KQVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeCzMfME; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso2581370e87.2;
        Sun, 15 Sep 2024 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726409920; x=1727014720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tm8EdfBqA4EbIk9KtCM7rf2FIUblxVnn9AXeawcKhA=;
        b=HeCzMfME9oMNc7pll7dB75mgVZHUQeCvHeKU4CwcWiDE6ri0GIvydmx1peahX7XNNN
         dPLLAesF0LvLbsxQ0lEipqP0tNu8eT/fQVU3pDYvu3OqoMemfUa5/nibpuluq5D+0Q2n
         QTJwvi5p2AZdK6rQYakQi4mDPTWgah40HvS3XQmmrwdK/Bm41At6EOZi7wu6qazo8Q8i
         Zb3zbiznj3GkM9zhlP06pfoUoAZuSxmjBnj0bAgnq61QiVZdyrcWst07+o/mBZL4Hs3P
         yxb7hpWLDf4Niyia1EM0gAL9dY3wsQ6iqXJP6yBQgjSvQgCsyaEZTX6+wX7Px4nK/dCy
         Wbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409920; x=1727014720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tm8EdfBqA4EbIk9KtCM7rf2FIUblxVnn9AXeawcKhA=;
        b=D/Y+a0Fz4KMjTJikasyKyfFmpx15+VtRyogvV0z0smzMcnzvlGqJiYh+IVnECsJIFh
         90d61FZ2c86MNCoFW3O5SJmV5lKjco+GyKhlCzuq0VkgB3SwQ7S9DfrfmhgNxAvFdze/
         /e0FnvrVsfcDu4Bnp8IRS5Oxez/Nu3myVYcMzGwiy10SdjEi2kq/lHjeTixWxZN6Is5P
         PVscFg4OpK8RKGhJsmjbd7uifdEBBReMEwpJsD8fvI5qIYIH0luqF+MrODbVHhYqicLJ
         zWBhpYnLd8nqTP1c0KBGEr9B/fVJ7EobXxg/JkyFP4guW3rHjONgNN6re9s3GEbD0L+Y
         iWbg==
X-Forwarded-Encrypted: i=1; AJvYcCV71h2/S8VDbv+XCuny5sJz5aDv3PVuMvusrnD1zFCFbpAvzkEiHnpjfSQf5koQ+Kc9F7RbSVCukiE4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ig1T84snsRuDBMwZmb374pAb7tMK0Mr9j3L0538YQZOe3nPK
	eoW9K31tRnR91r9wyBOOMjcv/BaNmhhvlo4Z18IwUIulCK3DfuDY
X-Google-Smtp-Source: AGHT+IGChd773bHzvc7VyX7LAnk0ViOaR+F14Aq+UPxCr7/Rq2wjKe4SWEYiP3WjqyOMh1wSPY7/7g==
X-Received: by 2002:a05:6512:124e:b0:534:3cdc:dbfe with SMTP id 2adb3069b0e04-5367fee526cmr3351616e87.28.1726409919516;
        Sun, 15 Sep 2024 07:18:39 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-5-228-117-203.ip.moscow.rt.ru. [5.228.117.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870968c6sm568967e87.125.2024.09.15.07.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:18:39 -0700 (PDT)
From: Ilya Orazov <ilordash02@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	Ilya Orazov <ilordash02@gmail.com>
Subject: [RESEND PATCH v4 0/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
Date: Sun, 15 Sep 2024 17:18:30 +0300
Message-Id: <20240915141831.2809208-1-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I wanted to kindly remind you about my patch submission. Just to clarify,
my patch doesn't introduce a new driver. Compatible fields from
ti,tcan104x-can.yaml is used by the phy-can-transceiver.c driver, which is
already part of the kernel. There was an issue with my previous attempt to
resend this patch. Please ignore it.

Could you please review it when you have a chance?

In this v4, I addressed Krzysztof's comments and incorporated the changelog
and tag received from Conor.

Thank you for your time!

v3:
https://lore.kernel.org/r/20240808191735.1483572-1-ilordash02@gmail.com/

v2:
https://lore.kernel.org/r/20240807180210.1334724-1-ilordash02@gmail.com/

v1:
https://lore.kernel.org/r/20240718210322.37492-1-ilordash02@gmail.com/

First of all, I want to apologize for the silly mistakes in my patch
preparation. I wasn’t aware of the need to include the changelog and
received tags in new versions. This is my first patch in the kernel,
and I am very excited about it. I am eager to gain experience in working
on FOSS.

I greatly appreciate all your feedback, and I will do my best to address
and fix any issues.

Ilya Orazov (1):
  dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)


base-commit: 872cf28b8df9c5c3a1e71a88ee750df7c2513971
-- 
2.34.1


