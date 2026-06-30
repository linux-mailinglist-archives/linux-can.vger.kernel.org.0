Return-Path: <linux-can+bounces-7908-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ENWpCKwxQ2pjUQoAu9opvQ
	(envelope-from <linux-can+bounces-7908-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 05:02:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6D36DFF26
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 05:02:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7908-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7908-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D299300E262
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 03:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2A3C552B;
	Tue, 30 Jun 2026 03:02:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6D72F28FC
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 03:01:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788520; cv=none; b=g9d8JRQ35Kwnv23OOIWoSb06BlHNBWZSV/8X6vt6bdbqTEFDjqU7g3wKt9YXJ8GRxMArjEVjh+CEaGmnqNVEqdVjNMLtPET6r4dREnEo1qTtuQh8LDhRdYJ93CRijod6PR1PBjMkZsvjTGt3yvNgV3mWFq20ySaIAWIRJ+Ypjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788520; c=relaxed/simple;
	bh=LNhW0c1bJhR6LZlA6GfUP3CL5jcQ92LEgGB4Bcz9a4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfonLSr5xgWWj2YRrOM73NlrlWQJyJxq/6MxOm22ybsyHipxAKVyhvtrNWIYGyNo4lASlswgjqlT15mPwfotWUCCHCGoJ7y9bMQ/Zuk2Rexxts8yqYNJR2ipeurtTC1Mx+0yBDFTYolBr/E16xBNS8raX/E2Kk6Cl5cyyM0GX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8Cx9OijMUNqCHsZAA--.58977S3;
	Tue, 30 Jun 2026 11:01:55 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJBx68GcMUNqG4e4AA--.19681S2;
	Tue, 30 Jun 2026 11:01:50 +0800 (CST)
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
Subject: [PATCH v3 0/2] Add Loongson CAN-FD controller driver
Date: Tue, 30 Jun 2026 11:01:39 +0800
Message-ID: <cover.1782787997.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx68GcMUNqG4e4AA--.19681S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgENCGpCCTEOsAACsq
X-Coremail-Antispam: 1Uk129KBj93XoWxCryDuFWkGr47KF18trW5urX_yoW5Xr1kpF
	4Yk3sxur1DKr4xAFs3JayrCF15A3Z3Jr43Wa9xtw10kas8Z342gw1Sk3W5Zry29rW5CFWj
	q3y8uFyfuFn8AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7908-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubb.aaron@gmail.com,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:zhoubinbin@loongson.cn,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[loongson.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,loongson.cn:mid,loongson.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F6D36DFF26

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
 drivers/net/can/loongson_canfd.c | 1859 ++++++++++++++++++++++++++++++
 4 files changed, 1878 insertions(+)
 create mode 100644 drivers/net/can/loongson_canfd.c


base-commit: b266bacba796ff5c4dcd2ae2fc08aacf7ab39153
-- 
2.52.0


