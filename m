Return-Path: <linux-can+bounces-5729-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BDCC8AADD
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D174C3A6ABF
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED130504A;
	Wed, 26 Nov 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Ol+VqS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B33C1E231E
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171369; cv=none; b=VeRPmTcYwu/3yZs9t+quQ3xeKO4UW6sAo5unkpucMkp+8BatVt2XyxnHUJ9v9krSsT+N5DToIxd06h2NJSXhuEHhOUB5cHeHJjQZWdvW+EqtaU5Zm9EhBITQbFbxunBk7MPLI6xGUsH79xLo7WkckJZQlN8DQ3J8N9T27rf7W+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171369; c=relaxed/simple;
	bh=Y0m7XkTikj6ospUwLpKvLK5W/cenH+bYDK4ibX8N4fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHhQLV3RTiHaGmUmNJoc5cZfTg/NndHT0x5eEPU8eQFnL1x7buMmHnMnBOXJtkdumJq8lQQ3DmXtSoM61bUWef2n7TIU37fSBX++j2ZASfL9/g30JgZcZoXnnG3vTPEhqHMmW0FlLE7NzrPJ0uZLvS6dvtbXBoQmruspvAT0pB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9Ol+VqS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso67091235e9.0
        for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764171366; x=1764776166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l69M0FfGvAr82YipFqTveTpBnfUfX0eUrFYwwvzwoAA=;
        b=A9Ol+VqSohRx80s8BpyHIInrvCHA81ZKZMaNTk3tWiJl7On/SeQy9EJtdPF8ZyG1HW
         WOmBkgYXM+GzQ5yfDQEp5ZItKoCkqMWzGeRf0Y8XKpUKystUBkk8V0N0mqiPIBoGoIaI
         AN1K9/Ap9yAPlQM2Y8oQhWS2X4xO5NwqdORrdNl8AY5dj+4d/al+7t5rQHtKweVbPtXo
         ftH7lUtl/e45djQ7+hazLtM7PJqMhxKcbQkoySGtDthOXY3mck00ZM0kk1bY6DdyOArs
         QxKYk0m0S6uGjMMc2CeM771M1dPW9YQJc1bjP79Zn7BHUMiZXc8Uh1L298PvCw9qvyw/
         SiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764171366; x=1764776166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l69M0FfGvAr82YipFqTveTpBnfUfX0eUrFYwwvzwoAA=;
        b=TgEPTiFt0/zlCqndiYhmcrSPkgFwm87funP57q45hRYTSgTK9J+iCftuvSrg3y3BwO
         o4p0iCRUoGGJ5AMbeb5uIJQApxAPWhnVPch85t7/xO/QPEUNlL7YfxJIJEnx2yD21oNm
         DWFcrkgkXap7o6iFWvdGBcgijIOfeMFi8A8C9TIR+Niq9dk6W2zUhRMfGP+MQRNk2EwC
         RMt9HtOEi9JUXNS8PsNC7BI4iBQOuTnp5D2yVipXQEE/z3dXCdKJtlRwGyBqDGrTEvI0
         kvknE9e2+IoQeSLKpRrpi3K9wPDjeRFVfEWUAk8QZmX8pOZbnd+EdSB8Kk2UlboH0ngy
         6bWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiRlyn5u0JTodj/7AhcPNhT4ZHUH51vyHQO1tT1YyLu5QB+hSS3IL2pyWMkpubrjtWklj4w5txPkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HXhN8g3n1O/ruC9uViTuReyx95Tq9dvRn8M028HsGrG7ElNF
	EFtuJQcdEMGdwJN5Hg2d/sw+HhnJInBYSCgZo5nGhlFtVl090mtj5X39
X-Gm-Gg: ASbGncsUNkijATCm4njiAVnyrO/I5EBgJQocA7DhHhqbYIlBqI6VMfiMHEGUg4CuD+N
	YGfisJgZdpkU3hI5gdT1YCiJMq/zkhHu1UvMiMe+tNxUlEIPK/uxWnk52z2+0x33QXHg2CdEiLm
	0lFIXMVzWj6g3zl4lCIC1BQZV8e5SNw7yuYQ12HfMyxK0QbYkMG60nw6RmD4SzIOEtMG0pwwMWR
	LYUaHCxjPME1yMimQKCoiKRhk0R9vXXIvKkpgfIFcVfDQvh+Y4TZ/4NhykLeplW2YzSiMqKxhK/
	/Hd9JAvqRbk7UHEbpOQl+cQlT6XjGxUbJD5hC8ecqtNsryaJpNQGNZrm7buMXHkdW7Id+/zeYY0
	PB8fQWvQerhD5jeasKQ7QhqmIetWUO99HH/qpWrwICyVXNI47AIqFwVuLKF1tfgnFU2v5b48n1C
	2M+zzNOGbUgn3+dYRwyZYzvAW3r9Wewc2Sc/+UIicBTC9HTkciNDLVvVgjnOLi+hGA63Xn8P+P2
	+s3B7So1T2Rag==
X-Google-Smtp-Source: AGHT+IHMxbJuNqRMLXan+uNmkq60wu9fS1SvjlHE8P/M25jeGqpRmxpAH1/jCOTWsBqAIVRGO3ZyVw==
X-Received: by 2002:a05:600c:470d:b0:471:1717:411 with SMTP id 5b1f17b1804b1-477c01edab1mr255084475e9.24.1764171365683;
        Wed, 26 Nov 2025 07:36:05 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e454sm41223775f8f.2.2025.11.26.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 07:36:04 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/2] Add FD-Only mode support for R-Car CANFD
Date: Wed, 26 Nov 2025 15:35:56 +0000
Message-ID: <20251126153603.312265-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode called
FD-only mode. In this mode, communication in Classical CAN frame format is
disabled. Update binding/driver to support this mode.

This patch series depend upon[1]
[1] https://lore.kernel.org/all/20251118123926.193445-1-biju.das.jz@bp.renesas.com/

v2->v3:
 * Added check to disallow the usage of both fd-only and no-can-fd.
v1->v2:
 * Added conditional check to disallow fd-only mode for R-Car Gen3 in
   bindings.
 * Dropped has_fd_only_mode variable from the struct rcar_canfd_hw_info
   as it is checked by the dt schema validation.

Logs:
root@smarc-rzg3e:~# /cip-test-scripts/canfd_validation.sh FD-ONLY
[   13.914196] rcar_canfd 12440000.can: global operational state (canfd clk, fd-only mode)
FD-ONLY
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
FD-ONLY
 [INFO] Testing can0<->can1 with bitrate 500000 and dbitrate 2000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
FD-ONLY
 [INFO] Testing can0<->can1 with bitrate 250000 and dbitrate 1000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer

EXIT|PASS|canfd_validation.sh|[00:00:19] ||

root@smarc-rzg3e:~# /cip-test-scripts/canfd_validation.sh CANFD
[   13.914196] rcar_canfd 12440000.can: global operational state (canfd clk, fd-only mode)
CANFD
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
[   37.246104] can: controller area network core
[   37.250607] NET: Registered PF_CAN protocol family
[   37.291606] can: raw protocol

EXIT|FAIL|canfd_validation.sh|[00:00:04] Problems while producing data from can1 and consuming from can0||

root@smarc-rzg3e:~# /cip-test-scripts/canfd_validation.sh CAN
[   13.914196] rcar_canfd 12440000.can: global operational state (canfd clk, fd-only mode)
CAN
 [INFO] Testing can0<->can1 with bitrate 1000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer

EXIT|FAIL|canfd_validation.sh|[00:00:03] Problems sending data from can1 to can0||

root@smarc-rzg3e:~#

Biju Das (2):
  dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only
    property
  can: rcar_canfd: Add support for FD-Only mode

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 74 ++++++++++++++++++-
 drivers/net/can/rcar/rcar_canfd.c             | 14 +++-
 2 files changed, 84 insertions(+), 4 deletions(-)

-- 
2.43.0


