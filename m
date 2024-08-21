Return-Path: <linux-can+bounces-1203-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272EC95A727
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 23:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87F31F22C80
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4E17A931;
	Wed, 21 Aug 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU1C85yw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA3179652;
	Wed, 21 Aug 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277244; cv=none; b=TqHSt9fhkkydNm53TClyyz3O56Z5rj+8MId7raUKQzwDGslcUZegivomBAAk4qvYgdYdKDLUVWZp+85iiP9F5oYPtT66ZyEfOtSRNGVKuiiEsFPhiSi3kSBOj78Kpm48lgV1xEOsZpRAyUkT7LBGCMleOi9sryh1O+IqR2l6qks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277244; c=relaxed/simple;
	bh=eP6nwvdKLnezrTV/XOYcwEApNIAT6pzmSTMv6dEmkGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GBtC/xpUrYnD+wZPHlB2Ze0kwmXfVlXLt+ZkRtPZvhr7O08Wbku+zFiwhavdUClgYg4Jw46G6Nb96mTtDnkw1ztRKoJS6aNgCm8Zkea5FdP1m4yUiIkKdiRREhBxvRPeotw5e1hE63vgZSPJagLOtmxyTQStxGbJ03hpoc+40k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU1C85yw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533488ffb03so189601e87.3;
        Wed, 21 Aug 2024 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277241; x=1724882041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rH+wXupdcEeWDpiy+UjjAtlMKoxWGKFGlfpWTlTHJhQ=;
        b=VU1C85ywBPCNQ7d3KsoGz3Na4Hbj0jE8aSGyH2xqwRpmbGR1DbWntAUsXcYa6nqG1r
         gd92xSFkN5Qx0NfSrnl/6cibsci8bb1iX8n3T+nEACAQW56hMatJFMy5E05LMTFWCFTu
         ZojvrYXDlU/Otc0jVR0baf+HE0IlTeM5/8MY0XIPpf+hP0b1z7/Tnnq6oqFBImR8SaH5
         1HYnAWf/HrpYhCHWAzOJeJYYBirbPuHH3vfHr0rSPBcHLqEts3o37nKtTq3b3yCwV0sX
         j+4dxfcpIvYa4L15iJ8PC0E5v0bFw8pJOkr6OIZlF7DquTVBgCo3huER3vGeesBWfHak
         v9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277241; x=1724882041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH+wXupdcEeWDpiy+UjjAtlMKoxWGKFGlfpWTlTHJhQ=;
        b=wzdSeVeCvbuboHG2vwPat5ruTDkCWIRDksI2ZWpyPX1hcBqI1H5gSWg8sAbJdeFmaL
         5IM9Qeut9VEvseTcF+ehd5YE7vLf7dd1nfSgkuQBG/kjraIhCqlGFFe7cR1pFEgLqe/i
         Rghgzhbip2Bq/BzJ9lgRZ/nwAPi+fUts/uzfPCaR4uIixNzUPajp//NbAEMWC7xR5UQy
         yrY6Qeoud4AxJcu0Gjtmth5KcMnF9clavpHLlRM/aIZgr/KeqERQhRV/H5CCDnC9kYwB
         wUtJOb4EARhAInjC32CDYggBpPl+6Dg3bD19UUAALaZrSEqqOOgIcArpt8bYYvZIv2RG
         Hq9g==
X-Forwarded-Encrypted: i=1; AJvYcCVme61hLwDTNNeiW4pgTb2SsGqk1im+rZr4otoA7DC3XOvfdsKP7SQkcrvm8Vqyz20rtNIr5KUY+cKv@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPDxZTOTVdKuf2IlaUsp/9vTOug/dDpLbqu7Bu+uk+2g8QGsv
	x3ynFg1Wi9KaiqGRYGMFQOmxV16O5HxWWPHPo1nXQ988MTPItcji
X-Google-Smtp-Source: AGHT+IGrRtTz0HBNaL45hxVnrFvxPbxlaVFlCrOhpoLUAniDrGhxVMVO4PJzIKURjs9bKHKKp+QjlQ==
X-Received: by 2002:ac2:4e09:0:b0:530:aa09:b6bf with SMTP id 2adb3069b0e04-5334855d450mr2500693e87.24.1724277239903;
        Wed, 21 Aug 2024 14:53:59 -0700 (PDT)
Received: from ilordash-vm.mshome.net (95-26-8-211.broadband.corbina.ru. [95.26.8.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea89004sm15623e87.274.2024.08.21.14.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:53:59 -0700 (PDT)
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
Subject: [PATCH v3 0/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip
Date: Thu, 22 Aug 2024 00:53:56 +0300
Message-Id: <20240821215357.20224-1-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

As suggested in the previous email conversation on this patch, I am
sending this new version as a standalone email. I hope this approach
makes it easier to review and keeps the conversation history clearer.

Thank you for your feedback!

Ilya Orazov (1):
  dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)


base-commit: b311c1b497e51a628aa89e7cb954481e5f9dced2
-- 
2.34.1


