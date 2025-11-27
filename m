Return-Path: <linux-can+bounces-5749-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D170C90000
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 20:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26AE34E1A5C
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB9F304BA6;
	Thu, 27 Nov 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT/CnrYh"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9B2F3618
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271146; cv=none; b=hxhZNYpfGXVhAPEuuyyy+SwJ2hrZozBrxthTgaeAMY60JQrw0IilE3Dzkokdz6Rnp8nvX00FiihUvF200mXBIAUOAp05zCuteAg3Te3GwOQM/i/nSj65s6TI4Ww/eFfvtal4wMXsvSZ4PssQ6lPG+dC47iig3k5fUByDQTqLdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271146; c=relaxed/simple;
	bh=/QE1RVALkE88Yh1a6KcQNX4EHbhhm5ilrBvnj6nOjhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPQln8vFIz8w7GyTKLd5RZfZHB0x3+XNbAq+HUvnGJaU4oiazgyua04HDjmuLjd3VV6Yemy8sHsKrQzhXKY2s52Pz0Iuml8uqg41INsvmpAQykqN1eZGaFa4hj2VN4kZ9dNTAzzvVVYSHmWMUs+DXMq2daXD5teQN+jnwLbFkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT/CnrYh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1341464b3a.0
        for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764271144; x=1764875944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F23WvkT7Mp8prCP9vsMQmwjTYVVmBHQ0+fJlOv02XNk=;
        b=TT/CnrYhJO9bgoaYEYi+GeBW0FjN9ypu3Y2+AOmjBTXccig1G2K9vZJ9TgOc/vXgLz
         jspHDR/3dFOMQpHohOPZkN3EKZxrlFHKtFRfYIJ0F5LGQ62QUL0yBggtRzi9VeVXqU/o
         PZk8Bim4gCTi5J0EdSkMFV27PAe9y4X9ecGglCCKEmYb/DMzAeXL1BDcQAYErSUVbazo
         aWWzs4B39P56thLbL3zRJVuqk2EZ5WhNwAqTMFlwBcNZdcmhQFpVCefLTPpQ8CU4wDzZ
         2ZRqXlAHPHHjsswHaqaSJbaBBDUOaFLyu0vBlBZDglD0/oZigJcjoRhZaU2PdpihFdJc
         Jd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271144; x=1764875944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F23WvkT7Mp8prCP9vsMQmwjTYVVmBHQ0+fJlOv02XNk=;
        b=olql0AYJubDt4/d/h8sIpoMYqimaivTg5zpuyXRL3al76IcxRk7FQoCe59YNVgmE6D
         am4Mmv9sMGxdm+gc+qHhW9Gm+Jlu0DO8pooBsWkxMtQfSeA42by2IputT+2wSFpaxY67
         85ngxSbsu20w5VKMrwJ+I/D076neDg6G1bn4a51ZiirGLw4JgRwMGJ3p1WN5aWd9A0W6
         t1tkJHFpYjFQIciTtSR8UndKvfHWMXGdKBhMRB2MBrCbk4EVfrsXzn4BExGXsEOAmqHH
         JED8DrmRGWV5mdZp5D+LzoOYkEn4spfxZy6vWXNq5nqZeyPj9qrdX50ZlXDYSn0NRXiC
         VxAg==
X-Gm-Message-State: AOJu0YxoCPule3BGdk1dIgLYUE7jUfYIvHUotWeVGFH43EYDPs3qvVRt
	uuoewm4W1sFro+L3GcbC2mpWrCyLabXi42cL9YzhhLV3UchhfLVbp1+ZDwX88m7iMIM=
X-Gm-Gg: ASbGncu4kg5qvkQtLaUhNvx6YduQ70TA2baLpSBc8yFpKZbW/tVzHEtpjiTepMuHPCA
	+03R0mqsN7bjl9cmRrPeuOoDIbLqNd8/fdfIbR9oWfrblbNzX4LZCo5zAi11gWkpu+cfloWQldj
	H+5ggfbQSXLrOKHK7mzYkp2bKXjeMMileF9az/dJn3sr9Rzib5HLCaiiT74Whdci4W2NlXsqDlY
	B5EG1uLq+Gyd3WamFchY7I7faOyBk7D68nHRIX/tGfXZjFjeDsPv2Z/NmV7NA8kGd7udy62VHoW
	0NSx4ZX1Zc0Sc9h/BwuYlJ3QMmbfdE6BUZlNDrZS8fM/oqNUZRty48YyfzodEqjfFLXLpVFxTHX
	aoH+zlHt4KuoeMThm20C/IavMho546tjB2jZstYRHKb6g1QtIkmH7LtwkFEPuONhrfNnUEE9gad
	sHbibsi540G+55asLt
X-Google-Smtp-Source: AGHT+IEfkxUrALhru/LYVIRVemCtN6SfsCS/++SjEvlyDbNUtwQTOvkACQT7kp8/L72AzSrboRrBiw==
X-Received: by 2002:a05:6a00:92a2:b0:7b8:e02d:d5b1 with SMTP id d2e1a72fcca58-7c58e609950mr25715904b3a.16.1764271143791;
        Thu, 27 Nov 2025 11:19:03 -0800 (PST)
Received: from rakuram-MSI ([2409:40f4:211f:b50d:1190:e256:8b21:a462])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f176096sm2620703b3a.57.2025.11.27.11.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 11:19:03 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	socketcan@hartkopp.net,
	mailhol@kernel.org,
	khalid@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rakuram.e96@gmail.com,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [RFC PATCH 0/2] can: add dummy_can termination and update SocketCAN docs for CAN XL
Date: Fri, 28 Nov 2025 00:48:06 +0530
Message-ID: <20251127191808.144723-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC series introduces two changes related to CAN XL support:

  1. Add termination configuration support to the dummy_can driver,
     enabling termination testing with iproute2.

  2. Update the SocketCAN documentation to describe CAN XL operation,
     including MTU changes, bittiming/XBTR settings, mixed-mode
     behaviour, error signalling, and example iproute2 usage.

The goal of this RFC is to validate whether the proposed behaviour and
documentation match the expectations for the ongoing CAN XL upstream
work. Feedback from the maintainers is highly appreciated.

Base commit: 
commit 30f09200cc4a ("Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")

For testing, this series was applied on top of the following patchsets:

  * "treewide: remove can_change_mtu()" (Vincent Mailhol)
        b4 am 20251003-remove-can_change_mtu-v1-1-337f8bc21181@kernel.org
        git am ./20251003_mailhol_can_treewide_remove_can_change_mtu.mbx

  * "can: netlink: add CAN XL support" (Marc Kleine-Budde)
        b4 am 20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de
        git am ./v8_20251126_mkl_can_netlink_add_can_xl_support.mbx

Testing was performed using the iproute2-next tree (canxl-netlink branch),
which contains the required CAN XL netlink support for validating
these changes.

Rakuram Eswaran (2):
  can: dummy_can: add CAN termination support
  docs: can: update SocketCAN documentation for CAN XL

 Documentation/networking/can.rst | 470 ++++++++++++++++++++++++++++---
 drivers/net/can/dummy_can.c      |  21 ++
 2 files changed, 454 insertions(+), 37 deletions(-)

-- 
2.51.0


