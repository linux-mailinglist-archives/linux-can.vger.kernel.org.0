Return-Path: <linux-can+bounces-988-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC79352A0
	for <lists+linux-can@lfdr.de>; Thu, 18 Jul 2024 23:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AACB20A3D
	for <lists+linux-can@lfdr.de>; Thu, 18 Jul 2024 21:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B477E0FF;
	Thu, 18 Jul 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbjCwRyZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC56D1B4;
	Thu, 18 Jul 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336608; cv=none; b=E2b88kTZFWuGnLlkBypeB3Q2MnhJQQorx27Z1fHq94zn+gJw3u0/yaHYJQew+Kt2cLftzPCjTlKId9IxJycF3HHzEs8RyB4JxY1zU7xHp94bO56x8Nd82k090cTvneu7j7G1CT8fNO8HHkae80VrkLEPmMrZpJZzjzJ+qfsaQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336608; c=relaxed/simple;
	bh=93NYKxrj5rmt9VZOgjsI57F4VCPUaTp06b17TR7Dtws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NFGfLCtMdagmAMyqjJYlvUa029XWsUjDyo8BkaBjL6AbS7Ns1IoV6M5z6PfgiD/5ejiLYjVQd5EK5bANReDTqop8QAKxiqPpyzr/bY9nKvKGVktMwIaIhCKToTvsEdeNY6knK7YJXhbJyJFwZdPKHbSP4Ut2vGcbSaycY1Mq6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbjCwRyZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee91d9cb71so14997421fa.0;
        Thu, 18 Jul 2024 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721336605; x=1721941405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dxDbdzvY7eNqZGbwyiIl9uNuZ+ao9LaobEESaQILLo=;
        b=EbjCwRyZanliJ4EgyRnuB++cwkJgV89/QKE1bL6JZzb1DkkOAvr39fV2zm+DKt18vy
         Tt0pPxckN3vk4wqtb5BaimRVLdHLeoSR3GXE3QMq2Ty/exzl/BxMlUkp6SCgt4wwniJq
         yoxNGUhrOkjCNRuAcQhHWrKTCrqjurKL32TGHSOJyr8tXM1CvYucCmupugY9wgMl8KgV
         p1miz3MEZVaOIhC8w83s4uDVDZsniu6XHeJOYIImVlBDTHnDRP/yv3OYJzlK3a1aviDZ
         CPOb3uIDSQv3GFrj65o7eU0qJH8+HJ4j5kcJHZ2OsTgC+FYJAc1mpHaXItj0l2bhgAwH
         0yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336605; x=1721941405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dxDbdzvY7eNqZGbwyiIl9uNuZ+ao9LaobEESaQILLo=;
        b=UfyT3j/pmqODSmj53L/KrGgiCKLfPa27YXYBdl2wx4mYA4OIZk69Jnd992xXbQmaVd
         3CQ0bg6RRMO+Fseg6UZCdxuMyf/wmcfN57hFgGf2mEktIdjyjY9VtABwNzFnaVqbMJKR
         XIqYwzIYBxKDlsaH5Uq5nAirkIxd/IbS6V6NauiIuo4IH110pqcTUw+rZhY9HbW0Bvlq
         GC1U1Z+aQfYHvft59eGZNjjmHqTmNHnuB5lhC4hGyFdWyehMTXlvgFlqP4bKs9Z6fQUS
         ujxaGbdzEHFjbn/aEqZdY2wnXfNLhW3iDJxQdAgH+bAEnp/wrbO2RfSNB3CH6pCeh0Ef
         Pc0A==
X-Forwarded-Encrypted: i=1; AJvYcCUZZBRvvsSsFpMuPwt45mMkcqhY6AMQMFZ55HF6grtGFrEoygI0exMAoPT1bLi/6JoIKHDmThBcxbjHsnbCTRKHSJGu7iM1BBM4hg==
X-Gm-Message-State: AOJu0YyTB9TA2Jcp3OaUA+N9eJrhhpLNoGjCktwi/QKZZX+8OwNQhgWF
	Wzo3bgYSQyX7ftbtH6araY34P+xY6E1crjFMyU3xcTiZjlAtEpQb
X-Google-Smtp-Source: AGHT+IHj5qJtbIwhbNCUD4aF+OroIK+74WZEoQ2M0b6ONmmL3ysXNSjWfyZ9CFvwHf+jdtzfIx/7zg==
X-Received: by 2002:a2e:7314:0:b0:2ee:871c:bcb3 with SMTP id 38308e7fff4ca-2ef05c78cc6mr22757171fa.13.1721336604732;
        Thu, 18 Jul 2024 14:03:24 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-109-173-124-203.ip.moscow.rt.ru. [109.173.124.203])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef05c80310sm4516511fa.13.2024.07.18.14.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 14:03:24 -0700 (PDT)
From: Ilya Orazov <ilordash02@gmail.com>
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	a-govindraju@ti.com
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	ilordash02@gmail.com
Subject: [PATCH 0/2] phy: Add support for Microchip ATA6561 CAN Transceiver
Date: Fri, 19 Jul 2024 00:03:20 +0300
Message-Id: <20240718210322.37492-1-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

The Microchip ATA6561 is a High-Speed CAN Transceiver with Standby Mode,
and it is pin-compatible with TI TCAN1042. Therefore, this patch series
extends support for the TI TCAN1042 DT bindings and the generic
CAN Transceiver PHY driver.

This CAN transceiver is a popular chip that I have used in my boards.
I decided to add support for ATA6561 to the kernel, as I believe it would be
beneficial.

Thank you for your feedback!

Ilya Orazov (2):
  dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
  phy: phy-can-transceiver: Add support for Microchip ATA6561

 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 drivers/phy/phy-can-transceiver.c                          | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.34.1


