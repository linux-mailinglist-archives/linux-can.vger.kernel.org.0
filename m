Return-Path: <linux-can+bounces-7694-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IafHZYGFGpSIwcAu9opvQ
	(envelope-from <linux-can+bounces-7694-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 10:21:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C55C7A58
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 10:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C909130055EE
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3673E1CEC;
	Mon, 25 May 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbdoETWZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111173E16A2
	for <linux-can@vger.kernel.org>; Mon, 25 May 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697275; cv=none; b=ijSq0+GQW1sz8/X3IY+hFvFTJIzGci9UnlJ0h4ToTxWuU+hbNS1uUl8Tcg8Ncmr/w2Fyzq2cp/0kohNAunfEZdS7JYnrleGDuKG46fIWoaB1FsRBxrNnORtLSRci5vRds7FCj0LVFXgYqYpm1XlT8yQ+Ea3TpMn8K+5E5Q8ZIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697275; c=relaxed/simple;
	bh=cnpeNyrRTMfn71Iw1My7ZiOgcb+W5DMHV+tEtk3Jprw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j9p0z2NcpVZ0UwqvKl8Z2xTH6Jz7OM3P987aGXBsTqfFGeDLI4n8NI+rubpKTBBUw28E7rYpTuLrKuiSkJfZ7+NrkDoe9WlSLbDVw8hCyR2jMr/GV0zllTBNDJ7vUrsdLRrAPVe77ZBuPFk8ogpLockEcop/5R/nEjRxNKGpanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbdoETWZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bea7176c72so30508105ad.0
        for <linux-can@vger.kernel.org>; Mon, 25 May 2026 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779697272; x=1780302072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h73HPPR4b8cE2zhlXM66PdYigBOxMozGSruLRQEyEiQ=;
        b=MbdoETWZnVu54cAdDYI+IcH7dP3KiMFUYIRxUXnG2Ab/xV7Ss0URUFR6Odm+pBRpqf
         PekTC9McdvzdVJcyapSELOrilu+qAdhIZMQkgfX3bzBJJlSpBT6lOJBe5RnBY06WK+t2
         XcXOt6hEq2rJaZMJP1daWYE41gC3xYCUUWXRW9vF3PdL7iu5fQyrjtJypt/BqxaRC2nl
         ltjyta0KdmPnzj7zUjF65Er4+TvQHtZi3QA19E1SbY1lC9pjbtnhxyP5GQQTFBDbLZcw
         D0wII5njH1rwFNM3iByK1cDPDckSOx6/yR5JW5IADz2NYgTq+koaLTdKR4mlCbSeRsuj
         1bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779697272; x=1780302072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h73HPPR4b8cE2zhlXM66PdYigBOxMozGSruLRQEyEiQ=;
        b=C3yy7rzpfKugZIQQXcTNRpjjXrAmRXByQSAikuGbGFL6xP2fhxTxst6DTDHJ6ukGXV
         Oaajoi6KfH7NGC/iMa1aXjqkopFKEEsNseSQVQId5YlLueRilmM7Irjkq6dWRF+8j5dE
         BmiAN3bCFJYOIcYwjUlkq0miTK5tLdh4fdVH7DbzIxNAvSalSK98/MR9/eNovSTYj8QP
         +GNsCc3iqAEzBLWdQLbY1nj7ESp3b0+UTXQ1zAW77RNCFYskmebTud4dugCR+oEi6qkD
         EiELLg/XTZt4kJdb6lE8zPvE09TAsxkPUw6nylp04aixWAKKCvGw42t4tWN11x41EXcy
         K7og==
X-Forwarded-Encrypted: i=1; AFNElJ/Tpi0gvemQLL/Snug6nXLaI23Ty/CW4dMCNXSS9b2Fn2vjRr6guY8LB7lgY9apbFN+revmVfWG9Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysR7qm6iKac0u9+/XFPsx+fAEExf3cdbOsyH79wdpmUUN5kV85
	rTPeioFn6xM/l5mhKjNesEKmDtuCr/8ejfJxNTMg3QtMoZyfGAiq3BEx
X-Gm-Gg: Acq92OHowR+7eyA6ENR0sjgfObq9WwdHYRs8Uoh3v5/Kmx6hBRWNDZoDKwty/LHpGxv
	8ASHADTJqovauznIh2s7OFEXPl0bGQGCqtlmcgx40deSE4iR7Zv01Z4Tenz162/JJ82D5MgwCZh
	/KeQ62DCsw1DfsouvUSUAAWf6JeK03rsCetr710qsc6u9nSC3yaowoj9y3O+y7revNZYxDK36dw
	OTloxzfdz2jGoqBHtNxyTEaX6JTK4MmDYbwTbjaY9T7mpXl4BlaR2u5GUeLUcPhmqaTuhNob7Ki
	x1DEh7S9/fWM1VoLJhipWV5qMctiV80SOrx8BfL8w6CXjNO4Y7VJ1Z1wNO5nghWuIyiijyeSiq2
	F6OoaXsUUrDxfzx1gf/gipuQSUoJ9kgHuff6Y5XBUQI7IWgzVz19mmkQDzpZoFzC9RoR2TlDtdp
	7QslaW3rjtvXnWy6g6YDObBVDoUKGd5NNA5D436K868T6z9bXF+eHVpJ5aed/hufpabg==
X-Received: by 2002:a17:902:e74b:b0:2bc:7d09:dcef with SMTP id d9443c01a7336-2beb06bc155mr153249445ad.29.1779697272248;
        Mon, 25 May 2026 01:21:12 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3bb6sm88798165ad.47.2026.05.25.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:21:11 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	linusw@kernel.org,
	brgl@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>
Subject: [PATCH v5 0/7] mfd: nct6694: Refactor transport layer and add HIF (eSPI) support
Date: Mon, 25 May 2026 16:20:49 +0800
Message-Id: <20260525082049.2906283-1-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-7694-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 861C55C7A58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ming Yu <a0282524688@gmail.com>

The Nuvoton NCT6694 is a peripheral expander that provides GPIO, I2C,
CAN-FD, Watchdog, HWMON, PWM, and RTC sub-devices. Currently, the
driver only supports USB as the host transport interface.

This series refactors the NCT6694 MFD core to support multiple transport
backends and adds a new Host Interface (HIF) transport driver that
communicates over eSPI using Super-I/O shared memory.

Changes since version 4:
- Split the monolithic refactoring and HIF support patch into a series of
  smaller, logical commits to improve reviewability and adhere to the
  single logical change principle.
- Decoupled USB-specific data into a dedicated 'nct6694_usb_data' 
  structure.
- Abstracted device I/O operations by introducing 'read_msg' and 
  'write_msg' function pointers in the core structure.
- Renamed the existing driver to 'nct6694-usb.c' to strictly identify its
  transport boundary, alongside Kconfig/Makefile updates.
- Extracted transport-agnostic device management (IRQ domain setup, IDA
  initialization, and MFD cell registration) into a standalone
  'nct6694-core.c' module.
- Added the 'nct6694-hif' eSPI transport driver clean on top of the new
  core abstraction.

Changes since version 3:
- Remove redundant module type macro definitions from sub-device drivers
  that are now provided by the shared header <linux/mfd/nct6694.h>,
  fixing -Wmacro-redefined warnings.

Changes since version 2:
- Restore per-device IDA and mfd_add_hotplug_devices()/PLATFORM_DEVID_AUTO
  to avoid child device ID conflicts with multiple NCT6694 chips.
- Validate irq_find_mapping() return value before dispatching IRQs.
- Check superio_enter() return value in nct6694_irq_init().

Changes since version 1:
- Reworked the Super-I/O access helpers.

Ming Yu (7):
  mfd: nct6694: Move module type macros to shared header
  mfd: nct6694: Refactor USB-specific data into nct6694_usb_data
  mfd: nct6694: Introduce transport abstraction with function pointers
  mfd: nct6694: Rename static I/O functions with _usb_ prefix
  mfd: nct6694: Rename driver to nct6694-usb and update Kconfig
  mfd: nct6694: Extract core device management into a separate module
  mfd: nct6694: Add Host Interface (HIF) eSPI transport driver

 MAINTAINERS                              |   2 +-
 drivers/gpio/gpio-nct6694.c              |   7 -
 drivers/hwmon/nct6694-hwmon.c            |  21 -
 drivers/i2c/busses/i2c-nct6694.c         |   7 -
 drivers/mfd/Kconfig                      |  38 +-
 drivers/mfd/Makefile                     |   4 +-
 drivers/mfd/nct6694-core.c               | 136 ++++++
 drivers/mfd/nct6694-hif.c                | 529 +++++++++++++++++++++++
 drivers/mfd/{nct6694.c => nct6694-usb.c} | 185 +++-----
 drivers/net/can/usb/nct6694_canfd.c      |   6 -
 drivers/rtc/rtc-nct6694.c                |   7 -
 drivers/watchdog/nct6694_wdt.c           |   7 -
 include/linux/mfd/nct6694.h              |  63 ++-
 13 files changed, 821 insertions(+), 191 deletions(-)
 create mode 100644 drivers/mfd/nct6694-core.c
 create mode 100644 drivers/mfd/nct6694-hif.c
 rename drivers/mfd/{nct6694.c => nct6694-usb.c} (62%)

-- 
2.34.1


