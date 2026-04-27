Return-Path: <linux-can+bounces-7404-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAXRAyIO72kq4wAAu9opvQ
	(envelope-from <linux-can+bounces-7404-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 09:20:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EB646E401
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC3213001A50
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED3736E494;
	Mon, 27 Apr 2026 07:19:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA00368291
	for <linux-can@vger.kernel.org>; Mon, 27 Apr 2026 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274397; cv=none; b=qU3zpqbsczCvdvNpu3ZEi6jCnhBTInvw6O4WvW4f7vdiOcLIKfoF0RYTALGTYGgCMm7SNM1p204ui2QuAPi2H7151L9t5V3jsdCjaBe5WYBn9bvjC/NUgtu52qAmEpasbDHCqgY8ImlCiIA7SEIITsclhu0v4VDY+aj16vVm+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274397; c=relaxed/simple;
	bh=96BJvE6/iPLIOCZXP5PQGTbpMwT+AKMCvO+f9la0JiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgKYLU1fmZtzMsXuwhqr6qxwL6douJbes6uDtHZRRlGAQdVlhu8zgSlxqpPsG99zJVwwkZxw1q29/G5hXX3boW91H2NRVrcLUyPqTtqv5VcGERwgYu6fM+uyIC4vF1gXdlqG0vT7LS8FLmOveG1n4U2ymJrffcK2fG4DrQLHTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8CxReiyDe9pZ0MEAA--.8569S3;
	Mon, 27 Apr 2026 15:18:10 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJCxWeCvDe9p0pJ1AA--.27085S2;
	Mon, 27 Apr 2026 15:18:08 +0800 (CST)
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
Subject: [PATCH 0/2] Add Loongson CAN-FD controller driver
Date: Mon, 27 Apr 2026 15:17:58 +0800
Message-ID: <cover.1777273055.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeCvDe9p0pJ1AA--.27085S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEKCGnu+qgB9wAAsi
X-Coremail-Antispam: 1Uk129KBj93XoW7KF13Gw1ktFyxWry7Ar4fJFc_yoW8WF4Upa
	1Fk3sxur13tr47Aws3JFW5CF15CFyrJrW7Ga9xXw10v3sFya47WryakF1UAr42vr15CFyj
	qrWruF48WF15GFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07jepB-UUUUU=
X-Rspamd-Queue-Id: D6EB646E401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7404-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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

Binbin Zhou (2):
  can: Add Loongson CAN-FD controller support
  can: loongson_canfd: Add RXDMA support

 MAINTAINERS                                   |    7 +
 drivers/net/can/Kconfig                       |    1 +
 drivers/net/can/Makefile                      |    1 +
 drivers/net/can/loongson_canfd/Kconfig        |   16 +
 drivers/net/can/loongson_canfd/Makefile       |    6 +
 .../net/can/loongson_canfd/loongson_canfd.c   | 1298 +++++++++++++++++
 .../loongson_canfd/loongson_canfd_kframe.h    |  142 ++
 .../can/loongson_canfd/loongson_canfd_kregs.h |  315 ++++
 8 files changed, 1786 insertions(+)
 create mode 100644 drivers/net/can/loongson_canfd/Kconfig
 create mode 100644 drivers/net/can/loongson_canfd/Makefile
 create mode 100644 drivers/net/can/loongson_canfd/loongson_canfd.c
 create mode 100644 drivers/net/can/loongson_canfd/loongson_canfd_kframe.h
 create mode 100644 drivers/net/can/loongson_canfd/loongson_canfd_kregs.h


base-commit: f1359c240191e686614847905fc861cbda480b47
-- 
2.52.0


