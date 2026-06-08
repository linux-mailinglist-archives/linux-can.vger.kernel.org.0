Return-Path: <linux-can+bounces-7763-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aHJ+MeSFJmotYAIAu9opvQ
	(envelope-from <linux-can+bounces-7763-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 08 Jun 2026 11:05:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 096786545E1
	for <lists+linux-can@lfdr.de>; Mon, 08 Jun 2026 11:05:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7763-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7763-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9BFA3048F05
	for <lists+linux-can@lfdr.de>; Mon,  8 Jun 2026 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B93B1014;
	Mon,  8 Jun 2026 08:50:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1E43AF677
	for <linux-can@vger.kernel.org>; Mon,  8 Jun 2026 08:49:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908602; cv=none; b=sDssKcYjUiR3k8jvQmB5vXrcv7m3y8IECLsMT4OsOXjM6cB5Wi/fsiqM3zMg9NFVxb6dskN9TJzZf5DQxp2yDiaDu3M9Vd8MCttqOtC2RNVHsh6ujgHy8TtCVE2bpcjeEph4GvHeuRmVvNbHKh97EWwLjREJgQPDVFw/qotP6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908602; c=relaxed/simple;
	bh=u3TcOrtG/1G4YP1UYa9yBRw8eamGsPA7cCgE0s2xbeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WI/U51BtvYgwjI5G2Mq/f9rPekbclDHfko33vUyKdBaNxSwXGE9XFkTLgnuE6/pS8Q55EiFZmc8rSTV5v/XMxY4GxjROnClCAlu0lIvHdmZGiLeB/A5IWsYDjtiTjbU9FLKoEfXhVZNLHcs0hK11uBhw+vwX205TBA/mEZVoiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [223.64.68.59])
	by gateway (Coremail) with SMTP id _____8AxAus1giZq970RAA--.47726S3;
	Mon, 08 Jun 2026 16:49:57 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.59])
	by front1 (Coremail) with SMTP id qMiowJDxTMIxgiZq1I+fAA--.37894S2;
	Mon, 08 Jun 2026 16:49:54 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Bingxiong Li <libingxiong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-can@vger.kernel.org,
	jeffbai@aosc.io,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 0/2] Add Loongson CAN-FD controller driver
Date: Mon,  8 Jun 2026 16:49:45 +0800
Message-ID: <cover.1780908445.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTMIxgiZq1I+fAA--.37894S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEMCGomWeACYgABsQ
X-Coremail-Antispam: 1Uk129KBj93XoW7KF13Gw1ktFyxWry7Ar4fJFc_yoW8AFW7pa
	1Fk3sxur1DKr47Aan3J34fCFy5Awn3Jr15Wa9rA34jvasIv3W2qrySk3W5Zr9rZrsrCFWj
	v3yUuFyxC3Z8AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU2MKZDUUUU
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7763-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubb.aaron@gmail.com,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:zhoubinbin@loongson.cn,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[loongson.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,loongson.cn:from_mime,loongson.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 096786545E1

Hi all:

This patchset adds support for the CAN-FD controller found on Loongson
CPUs.

Patch 1 introduces the basic CAN-FD controller driver with support
for classic CAN and CAN FD, including bit timing, error handling,
NAPI-based RX, and multiple TX buffers.

Patch 2 adds optional DMA support for RX path using the Loongson APB
CMC DMA engine, which significantly reduces CPU load under high
receive throughput.

The driver has been tested on Loongson-2K3000 platforms with various
CAN/CAN FD traffic patterns.

Finally, I'd like to thank Binxiong, the original author of this driver,
for his efforts in working on the patch.

Thanks.
Binbin

-------
V2:
Patch (1/2):
 - Put all code into one file;
 - Add COMPILE_TEST Kconfig option;
 - Rewrite Kconfig description;
 - Use `regmap_test_bits()` to simplify bit field checks;
 - Drop odd FIELD_GET() usage;
 - Don't use FIELD_GET() for a single bit;
 - Use an if/else instead of the ternary operator;
 - Use the CAN TDC framework to get the SSP value;
 - Use guard(spinlock)/scoped_guard(spinlock);
 - Use netdev_debug() to be less verboss;
 - Check for memory allocation failure;
 - Add CAN_ERR_CNT flag;
 - Drop unused REG_DATA_xx_yy_W_DATA_yy definition;
 - Add more function comment;

Link to V1:
https://lore.kernel.org/all/cover.1777273055.git.zhoubinbin@loongson.cn/

Binbin Zhou (2):
  can: Add Loongson CAN-FD controller driver
  can: loongson_canfd: Add RXDMA support

 MAINTAINERS                      |    7 +
 drivers/net/can/Kconfig          |   15 +
 drivers/net/can/Makefile         |    1 +
 drivers/net/can/loongson_canfd.c | 1935 ++++++++++++++++++++++++++++++
 4 files changed, 1958 insertions(+)
 create mode 100644 drivers/net/can/loongson_canfd.c


base-commit: f1359c240191e686614847905fc861cbda480b47
-- 
2.52.0


