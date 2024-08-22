Return-Path: <linux-can+bounces-1209-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097695B336
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC551F2331C
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7217E918;
	Thu, 22 Aug 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeYCA8pS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750B17CA16;
	Thu, 22 Aug 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323964; cv=none; b=GJtLTjRcAGa4jWC1Wz9zl58WmZ0yfSek3jax3CPStgM0r7rHT5/CzNfnJvCAS0fe+9geLoRWtN2mTHznfcELWJjuk6LiRMLvpHp9qMbPGLjlLN9qmPiT3+wuN7enX0eif24wR2XwDJrKR7poDtnlZN0QA4Av9GrXALeLqvknxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323964; c=relaxed/simple;
	bh=Y8g+1lUqRX0W1fC3xTwgMjUUi1WKPVHiJa71JZRTFqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EM+2gF9V8A0rLW6UCzdVHYPr1mmQfPDGIVMPc1bFuz9vh2KvnLgLbLcu+B9kbPttpgUoPoFL45yUqzZIDfWPorYag1YrZBPJG0MxES3yjLrxQV8IyRC7caFp9MSHPbuF4IWx1P//n3XzEmtE5a5f1MTlSq6VAQA+T/pzJ7lWfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeYCA8pS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso2225001fa.1;
        Thu, 22 Aug 2024 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724323960; x=1724928760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxWPUFOwZqCM5Kx8t3Y3dLzbYEJ4j8qYd64u0k3UgAI=;
        b=AeYCA8pSoVDvhc9T2yagYdAdR6azb71HVotfI9Lfy22EGfn7X+47mOOvTqnlwf9lQT
         GLx5vzZU54Ue3iLhs2+C6bflLcYyvlGj4qaZis5zObfk3v1uDy7E6rgAW9bLWakhc9pL
         zh3zDj680ri+dAx5nlZ7ycFUaPKUFvGvhYnANqBZU264iHLy9SrZvsP5++FhTGvsWkLd
         te+HPg1adrFveC1s/ByflRM9BlYhoXmx/7dhlMy8hOJ+Lbv92P7ZXqgTEyTDK4i80WoP
         4MpGDzptFwIcZQ9OV2jFskmOFWceOoFt9Lh4PTJP8jnQ+qAGyW6rtmN+mOIfPYwdrRCK
         dCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323960; x=1724928760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxWPUFOwZqCM5Kx8t3Y3dLzbYEJ4j8qYd64u0k3UgAI=;
        b=kpzYiSqg/bgeFU3mogxgEvTCgWZQKfHioZll/bi9SQzT9UZnVz53Kg05U2L0MPNk4O
         RwmeGMo+GnN38PkPu7LuNk8On0blYTxZkKEgiHTtyLa7CX4dRjmg1q4HZ1vUZ/GBa7Eb
         dm/n93vjpHtgQvHfKg4STzSQ5Iau0CA2ykY+agAwS/NfCi+JE7V5olcrh6INSct86mtS
         N6v+vpY6tnjp6oG0kLywB4jaInXXdJqd8UIzq9jyckKjOSWUT6IIblxw2IxSFeg9CkVg
         vLcrJ5YDzmijAOFqtlWq0Q7MAg0DizwmDunxnBRqkARVT43KvEVgrVNyWKfTAHsJAl3W
         jT5w==
X-Forwarded-Encrypted: i=1; AJvYcCUpox9kt8waXso920yiJsufHq07+VTPKMZWQfkFTQh/z7QFBJBJnM+yt/zO9X4yikUMWhVwy/UwgGjf@vger.kernel.org
X-Gm-Message-State: AOJu0YycDczm2+/khhBEjq2VJy5Z4e5on/4vgSVOtEgCHrrhh5VlTAB8
	c8pvpBetRn3kdMmbfPZ3ii6luf1jiy1soRrSKbXwtU9syeBM7LZJ
X-Google-Smtp-Source: AGHT+IFL5+T2KdDfE/H1idX5/DG/etl+eJ+S4fyildCMF78SV1DFt2sCcYtkbFL82gnNt1ofEt9fpA==
X-Received: by 2002:a2e:8450:0:b0:2f3:cbc3:b093 with SMTP id 38308e7fff4ca-2f3f8b57b41mr27764931fa.43.1724323959744;
        Thu, 22 Aug 2024 03:52:39 -0700 (PDT)
Received: from ilordash-vm.mshome.net (95-26-8-211.broadband.corbina.ru. [95.26.8.211])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047a4f59sm1886261fa.13.2024.08.22.03.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:52:39 -0700 (PDT)
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
Subject: [PATCH v4 0/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip
Date: Thu, 22 Aug 2024 13:52:37 +0300
Message-Id: <20240822105238.213019-1-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

In this v4, I addressed Krzysztof's comments and incorporated the changelog
and tag received from Conor.

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


