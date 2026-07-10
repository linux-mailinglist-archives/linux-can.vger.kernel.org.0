Return-Path: <linux-can+bounces-8266-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id onysK2KsUGrl3AIAu9opvQ
	(envelope-from <linux-can+bounces-8266-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:25:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D7C738683
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8266-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8266-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EDAA305FF25
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016003EFFA1;
	Fri, 10 Jul 2026 08:22:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70306352C4F
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 08:22:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671754; cv=none; b=iPSA1C9x4cdFhJKC9Blwxq5K3QjYZmRFmt0Tu5J+L49YcE72nIewWSjGfC6JopGd5aZrZr3+UkxH55A0n0cyOUYiOUGOUHMvjDkDl9GCnNirdEUqFPxHE+ij9DqA3fOvXZfzGUiK790fbcdFXyOvXASdIUsNFHGTwNfgUuGFc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671754; c=relaxed/simple;
	bh=aED7ufYo1vygFoo6t2ncQD4nn7zxb2QWqvAIH0G29LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwqsR95rWbp44sJkrKXaM6oyi2J4Ra8cesNktlGZJU1RCjqiMG5JzFhe5Zs6Wju0cE/HczNT75G5aMkmT+cpuoR/uBt7VyhWnN059v6saKFBlGSCOUvzgaD3DphyYhpmEsoDfALbA3amQyU3cGowqy75uxGG0ilY8Q6P6htb9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8BxVerCq1Bq1jMCAA--.7809S3;
	Fri, 10 Jul 2026 16:22:26 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJAxTOW8q1Bqex0IAA--.25035S2;
	Fri, 10 Jul 2026 16:22:22 +0800 (CST)
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
Subject: [PATCH v5 0/2] Add Loongson CAN-FD controller driver
Date: Fri, 10 Jul 2026 16:22:12 +0800
Message-ID: <cover.1783670733.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOW8q1Bqex0IAA--.25035S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEECGpQeKwEYgAAsH
X-Coremail-Antispam: 1Uk129KBj93XoWxCryDuFWkGr47KF18trW5urX_yoWrJw18pF
	45C3srurn8Kr4xArs3JayrCF15Aw1fJr13WFZIyw10kas0vw4jg34Sk3W5uryUurZ8CFWj
	vrWfuryrK3Z8ZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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
	TAGGED_FROM(0.00)[bounces-8266-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:mid,loongson.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1D7C738683

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

Finally, I'd like to thank Bingxiong, the original author of this driver,
for his efforts in working on the patch.

Thanks.
Binbin

=========
V5:
Patch (1/2):
 - Fix tseg1_max const value;
 - Empty FIFO when SKB allocate failed.
 - Use REG_FRAME_META1_RWCNT as the playload read count value;
 - Only clean processed interrupt flags in
   loongson_canfd_err_interrupt();
 - Refact loongson_canfd_tx_interrupt();
 - Add LOONGSON_CANFD_TRV_DLY into loongson_canfd_volatile_reg();
Patch (2/2):
 - Fix dma_request_chan() error path;
 - Fix build error;
 - Fix loongson_canfd_rxdma_init() error path;

Link to V4:
https://lore.kernel.org/all/cover.1783391759.git.zhoubinbin@loongson.cn/

V4:
- Fix some issues from sashiko.
Patch (1/2):
 - Update commit message;
 - Use common APIs to calculate DLC;
 - Correct CAN_RTR_FLAG judgement;
 - Add skb check for CAN_STATE_ERROR_ACTIVE case;
 - Use regmap_write() rather than regmap_update_bits() to
   disable all interrupts;
 - Add napi_disable() in error paths;
 - Add `clock-frequency` return value check;
 - More comments for macros.

Link to V3:
https://lore.kernel.org/all/cover.1782787997.git.zhoubinbin@loongson.cn/

V3:
Patch (1/2):
 - Replace the switch-case statement with a calculated mask in
   `loongson_canfd_get_txbuf_sts()`;
 - Change `loongson_canfd_reset()` return type to `void`;
 - Drop old code in `loongson_canfd_set_btr()`;
 - Rename `loongson_canfd_set_mode()` to `loongson_canfd_set_conf_mode()`;
 - Drop `cf->__res*` usage;
 - Drop unnecessary macro definitions;
 - Add `netif_napi_del()` in probe error route path;
 - Replace ternary operator with `if-else`;
 - Drop stats->rx_packets and stats->rx_bytes count in CAN error frames;
 - Add ethtool_ops;
 - Add CAN_CTRLMODE_CC_LEN8_DLC;

Patch (2/2):
 - Fix W=2 warning;
 - Rename get_rx_frc() -> get_rxbuf_empty();
 - Put `loongson_canfd_rxdma_remove()` before free_candev();
 - Adjust the RXDMA probe process.

Link to V2:
https://lore.kernel.org/all/cover.1780908445.git.zhoubinbin@loongson.cn/

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
 drivers/net/can/Kconfig          |   11 +
 drivers/net/can/Makefile         |    1 +
 drivers/net/can/loongson_canfd.c | 1897 ++++++++++++++++++++++++++++++
 4 files changed, 1916 insertions(+)
 create mode 100644 drivers/net/can/loongson_canfd.c


base-commit: b266bacba796ff5c4dcd2ae2fc08aacf7ab39153
-- 
2.52.0


