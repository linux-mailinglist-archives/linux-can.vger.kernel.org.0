Return-Path: <linux-can+bounces-4009-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B133FB0B6A3
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7224178C14
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD11F874F;
	Sun, 20 Jul 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZxZFjP0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA51C6FFD;
	Sun, 20 Jul 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025053; cv=none; b=Rfj6Rp7VkX2vSjY0d7hdxYrIrsehQceS+1+uXbvgF3+3K+qqaoayP6f9ftXxFSzY0WplYn3qb2jDPgBnp7fjxLe0j8ndiWANaqQADWSe5p1I/ThODcPmJUa521DXeLNlrG8SoO9MbGkZ6mVNSJOaB6OCFlOs2im9YETa0W/Wvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025053; c=relaxed/simple;
	bh=ejLPH1uyFcaefJAlprHO4BVLW8FCx6dpRTX9z1JmQcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAn+6diIqJPW1GRmk2sGj6hUsD+5nawhwTmkTZeIMOgEjr6yrw/7svP7HiBx3qjMrIAV6xI8rtPnOd+DDo1iGr4k2UwhCL65/h5TcQ1nq6OgAS+KzPkkh9hVyuxqiZSxPs3GNWcS+tYduzMT+Puj/m7nDIeZ94AyOQ+r6jKWc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZxZFjP0; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-884f7d29b85so1889000241.1;
        Sun, 20 Jul 2025 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753025050; x=1753629850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NVp2kMB/w6wTX2T2u1oRumzIS3t/oXG521zmpwRXomY=;
        b=SZxZFjP0rVV1pjEH3UpUMt+bxP3Vqst3j6B+DJQtCoaQjhQwMqsdzYcyEXe2m06j2R
         I6aUjJynA9pA62VTInJiHFpmUCcsZFOc0OF+O8CCcSMerjsx1Mnpk1TeW7Qk4+dzy5u7
         zogTEixcPQwYCuNKOZPXMdPIkeVlX+pJkorz2zBRy+3exMuFyiEj9uMjVLXrdlcSCg9e
         alx5H/VubnCZ+BvH2wEUvr0t+0oqXiI0Mbh8A1ze3Iz1cVusKrISVGO5VSigvjNAPMHj
         afoEG/c337E0rO46uCDckY9GcXrmIbsKdT80dbY09xIR+ZLPereyh2NwY0AJDlMuf8OQ
         ygIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753025050; x=1753629850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVp2kMB/w6wTX2T2u1oRumzIS3t/oXG521zmpwRXomY=;
        b=JoqaQ5Fot6myp2LTz/AISbQTcyqkfYWmOaUQ5qTP/jU+PWx2a+9yAAu7GoPMCx5p02
         Il2twVLYCJE7qUNBx2pCbaHoD9yvShLhsD9Ma0T1ivqi/hVzDJweDVYztMhS6X9QuFov
         cvVZIDVNFv454F8MXu0w4fvaIIYftUzXYwsmba/QlAs+r6dMWx3zfobA2/wAEijR/yNI
         O34JYsQRmBcsWNDPSn09zqydkBoTTkCRKXLrTpbq8ICzBrrUGFQWOJlWjwyS9LfTLkjJ
         0N9RhuGfKH2C4TXc6kCW45ZQfhIDWvJ/Ur7yca+AZ0b7a/4U/1k0AmfA4QCzUAzQWzmW
         fU6g==
X-Forwarded-Encrypted: i=1; AJvYcCUPWjk3cez5/+ZCX3H/sv+84alKC4S/mmxgq5h6F/JE4EUiu3XILT2sdQIPQOm6Q1ZCDIfoEFaxmGs=@vger.kernel.org, AJvYcCXzXbDl9imxDdh54F+B/v6zil/rKrhd1q+p2L1MbHn8BqrHmtH/o3LrY4BfVEjkz7x7ABtY0m/+PRH/ssYS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiba4/zICHYwtj5qBQKNCBCKurpGOpNo7rMIPQ70JDYse4tO70
	GBDr/qN0nJNJnTTNf9taLgBonC+PErh5fo8dzvAhmET9VzstcBtXw5G6
X-Gm-Gg: ASbGnct23soKdOh3G0PR6bJl1h1iH385OvrZMKnWW8iFWpj/Zt6RCoAaDkccoX6Keu8
	tSdTQrVN9bEwU3a987C0gas00M6ES4ALn06Akv9C5E080q0wS9CP8/ZD24bvSvd/a+dC/woWZrM
	duoTQnTtzUz/eLcVeKTWYQt2HvE+Bp7+kao8m9n2oTieZzEkLgPK1VszIh2xUZ5qpyRKl/m8kCc
	Lx8l69tZrJMhdw/ZKxxy+caa6aYC5B9Wcs2BSMZF0rGxpYrnK0y2BnwzswUkhl14DsBHvIHZFnc
	D5LY/vBsJIbQdNuLdsxxbKX4+XJSkuhulNl957CbvCg1XZ9xZBfYosmB2V737K1Bt8QHDaJ6Hnr
	PCRCcbHNWZ+RMsorjXR+WJ4SwJYe+SN6Dx4jWUvfNe/zXx0vyfUdOV1Z0l0n0YJXFwycRyzaSR0
	ibTDdjMA==
X-Google-Smtp-Source: AGHT+IHRMhGcnZqIbnc4e1wX2YKxqCMc99MYrRIYYOQDLTChJMGHa152DiivvQgHsQw0yB1RXnRfOQ==
X-Received: by 2002:a05:6122:238c:b0:531:2d55:7f54 with SMTP id 71dfb90a1353d-5374f55bb40mr6219747e0c.3.1753025049669;
        Sun, 20 Jul 2025 08:24:09 -0700 (PDT)
Received: from 9950X.localdomain (syn-142-197-132-170.res.spectrum.com. [142.197.132.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53764eedd3bsm2157582e0c.5.2025.07.20.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:24:09 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-i3c@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Subject: [PATCH v2] docs: Fix kernel-doc indentation errors
Date: Sun, 20 Jul 2025 11:24:00 -0400
Message-ID: <20250720152401.70720-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the patch to fix kernel-doc formatting issues.

Changes since v1:
- Convert problematic sections to proper ReST list format instead of 
  just fixing indentation (feedback from Randy Dunlap)
- Add GPU driver fixes (additional files with same issue found on latest
  build in linux-next)
- Remove SCSI driver (already fixed in current tree)

---
v1: https://lore.kernel.org/all/20250703023511.82768-1-luis.hernandez093@gmail.com/

Luis Felipe Hernandez (1):
  docs: Fix kernel-doc indentation errors

 drivers/gpu/drm/drm_gpuvm.c              | 16 ++++++++--------
 drivers/i3c/device.c                     | 13 ++++++++-----
 drivers/net/can/ctucanfd/ctucanfd_base.c | 12 +++++++-----
 3 files changed, 23 insertions(+), 18 deletions(-)

-- 
2.43.0


