Return-Path: <linux-can+bounces-7766-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dJ2nHpOyJmpRbQIAu9opvQ
	(envelope-from <linux-can+bounces-7766-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 08 Jun 2026 14:16:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C443265609F
	for <lists+linux-can@lfdr.de>; Mon, 08 Jun 2026 14:16:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gdegK4Md;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7766-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7766-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC0C300A8E6
	for <lists+linux-can@lfdr.de>; Mon,  8 Jun 2026 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8DB37757F;
	Mon,  8 Jun 2026 12:14:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F614A4CC;
	Mon,  8 Jun 2026 12:13:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920840; cv=none; b=fp8/3Q3c2fnRPqgOmyi4FARzk8LIRokwiNwQs+SyTx+6a93sHxtz1RGReTFlC0zyMhVVDyuv1DABIKOoyZGRLx4FjjedyrOLe+bLYx63fyMxc10utH2hsfoMvNwJbX0qophhAIWmq+KdvyGEP1P46Asly770N76Oj4oV7alCWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920840; c=relaxed/simple;
	bh=OM0KkLoX18gUbeIF8cFsoz7+KyqE93gaxQyb9ZKRufI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0ntMhDxwfQI8uamI1TjjwHKorbA6kbYStQpVvSymuvBuUfiebeF1+hdOpA4jec9zLgxzN6gm9S2ble1bpIweIAsuSjKmlnSq10S+kJ/xKu9V2t68YLLG0Q5fSnRrqq6gT24iXxPa89WAQKKtaVdi8k4Xo2ius+qJOZkq3LqmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdegK4Md; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA6F1F0089B;
	Mon,  8 Jun 2026 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920838;
	bh=4WeP0mvdOI+RatPP38HIEDZBygq7NQAILIdFAZsEKlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gdegK4MduDvlCFnPwEzuStElV/tGd0hs4VpoZT9M6y73aboPXUkDgfmL5U0jZuxNm
	 e809NnHmjV8UjscsTc0z00tfnNtflySKXQrUPt3HKyP/MRoO17kbCW+03HWzDdleN/
	 R7XEFipszTvdSnbdPbnwNeFfRRus5YDgxJ+jV1xmmJOhSNuoUp6NAYBug9edcBLH1I
	 FGnmyqW0seCCfP1XFNjPawEK4djSbSVylj2DUPW4JvtyeoiQ7Ey6JbzNPL8sDppsNw
	 aZ7HrUIGaJ/waXCywmcyjw3fWbAmE+4P2s9odq1D7hIPrP5YWp3+xdd0szGXs/GwwS
	 ird+gTKruAPpQ==
Message-ID: <11d8ceff-d05a-4446-96cc-f9f97538d12e@kernel.org>
Date: Mon, 8 Jun 2026 14:13:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] can: loongson_canfd: Add RXDMA support
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
 <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Bingxiong Li <libingxiong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 loongarch@lists.linux.dev, linux-can@vger.kernel.org, jeffbai@aosc.io
References: <cover.1780908445.git.zhoubinbin@loongson.cn>
 <9af2c912e0afd439ea9562ea8aa72ee0af3f2ed3.1780908445.git.zhoubinbin@loongson.cn>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <9af2c912e0afd439ea9562ea8aa72ee0af3f2ed3.1780908445.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7766-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:zhoubb.aaron@gmail.com,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[loongson.cn,gmail.com,pengutronix.de];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,loongson.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C443265609F

On 08/06/2026 at 10:49, Binbin Zhou wrote:
> Add optional DMA support for RX path using the Loongson APB CMC DMA
> engine. When a DMA channel is successfully requested, the driver:
> 
> - Uses DMA cyclic transfers to write incoming CAN frames directly to
>   a coherent DMA buffer
> - Replaces RXBNEI (RX buffer not empty interrupt) with DMADI (DMA
>   done interrupt)
> - Dynamically switches between DMA and PIO modes based on channel
>   availability
> 
> This significantly reduces CPU intervention under high RX load,
> especially beneficial for CAN FD at higher data rates.
> 
> Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
> Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

Please check the W=2 warnings:

  $ make W=12 drivers/net/can/loongson_canfd.o
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC      drivers/net/can/loongson_canfd.o
  drivers/net/can/loongson_canfd.c:1917:9: warning: missing initializer for field 'driver_data' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
   1917 |         { "LOON0015" },
        |         ^
  In file included from ./include/linux/acpi.h:16,
                   from drivers/net/can/loongson_canfd.c:8:
  ./include/linux/mod_devicetable.h:219:24: note: 'driver_data' declared here
    219 |         kernel_ulong_t driver_data;
        |                        ^~~~~~~~~~~
  drivers/net/can/loongson_canfd.c: In function 'loongson_canfd_start_xmit':
  drivers/net/can/loongson_canfd.c:1116:13: warning: 'buf_id' may be used uninitialized [-Wmaybe-uninitialized]
   1116 |         u32 buf_id, tx_stat, i = 0;
        |             ^~~~~~
  drivers/net/can/loongson_canfd.c:1116:13: note: 'buf_id' was declared here
   1116 |         u32 buf_id, tx_stat, i = 0;
        |             ^~~~~~
  In function 'loongson_canfd_insert_frame',
      inlined from 'loongson_canfd_start_xmit' at drivers/net/can/loongson_canfd.c:1144:7:
  drivers/net/can/loongson_canfd.c:1079:15: warning: 'meta1' may be used uninitialized [-Wmaybe-uninitialized]
   1079 |         meta1 |= FIELD_PREP(REG_FRAME_META1_DLC, can_fd_len2dlc(cf->len));
        |               ^~
  drivers/net/can/loongson_canfd.c: In function 'loongson_canfd_start_xmit':
  drivers/net/can/loongson_canfd.c:1052:20: note: 'meta1' was declared here
   1052 |         u32 meta0, meta1;
        |                    ^~~~~
  drivers/net/can/loongson_canfd.c: In function 'loongson_canfd_probe':
  drivers/net/can/loongson_canfd.c:1807:13: warning: 'ret' may be used uninitialized [-Wmaybe-uninitialized]
   1807 |         int ret, irq;
        |             ^~~
  drivers/net/can/loongson_canfd.c:1807:13: note: 'ret' was declared here
   1807 |         int ret, irq;
        |             ^~~
  drivers/net/can/loongson_canfd.c: At top level:
  drivers/net/can/loongson_canfd.c:47:9: warning: macro 'LOONGSON_CANFD_RX_FR_CNT' is not used [-Wunused-macros]
     47 | #define LOONGSON_CANFD_RX_FR_CNT        0x50    /* Receive Message Count Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:354:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_14' is not used [-Wunused-macros]
    354 | #define LOONGSON_CANFD_FRAME_DB_14      0x3c
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:307:9: warning: macro 'REG_RX_STAT_RXF' is not used [-Wunused-macros]
    307 | #define REG_RX_STAT_RXF                 BIT(1)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:255:9: warning: macro 'REG_FIL_A_VAL' is not used [-Wunused-macros]
    255 | #define REG_FIL_A_VAL                   GENMASK(28, 0)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:105:9: warning: macro 'REG_MODE_RTSOP' is not used [-Wunused-macros]
    105 | #define REG_MODE_RTSOP                  BIT(12)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:221:9: warning: macro 'REG_RX_FR_CNT_VAL' is not used [-Wunused-macros]
    221 | #define REG_RX_FR_CNT_VAL               GENMASK(31, 0)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:273:9: warning: macro 'REG_FIL_R_HI_VAL' is not used [-Wunused-macros]
    273 | #define REG_FIL_R_HI_VAL                GENMASK(28, 0)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:234:9: warning: macro 'REG_DEBUG_PC_CRCD' is not used [-Wunused-macros]
    234 | #define REG_DEBUG_PC_CRCD               BIT(11)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:249:9: warning: macro 'REG_FRC_FRC_NBT' is not used [-Wunused-macros]
    249 | #define REG_FRC_FRC_NBT                 GENMASK(7, 0)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:336:9: warning: macro 'REG_TX_SEL_BUF_CNT' is not used [-Wunused-macros]
    336 | #define REG_TX_SEL_BUF_CNT              GENMASK(7, 4)
        |         ^~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:218:9: warning: macro 'REG_SSP_CFG_SAT' is not used [-Wunused-macros]
    218 | #define REG_SSP_CFG_SAT                 BIT(10)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:91:9: warning: macro 'REG_ID_VER_MAJ' is not used [-Wunused-macros]
     91 | #define REG_ID_VER_MAJ                  GENMASK(31, 24)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:359:9: warning: macro 'REG_FRAME_META0_ID_EXT' is not used [-Wunused-macros]
    359 | #define REG_FRAME_META0_ID_EXT          GENMASK(17, 0)
        |         ^~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:245:9: warning: macro 'REG_TS_PSC' is not used [-Wunused-macros]
    245 | #define REG_TS_PSC                      GENMASK(24, 16)
        |         ^~~~~~~~~~
  drivers/net/can/loongson_canfd.c:231:9: warning: macro 'REG_DEBUG_PC_DAT' is not used [-Wunused-macros]
    231 | #define REG_DEBUG_PC_DAT                BIT(8)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:227:9: warning: macro 'REG_DEBUG_STF_CNT' is not used [-Wunused-macros]
    227 | #define REG_DEBUG_STF_CNT               GENMASK(2, 0)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:193:9: warning: macro 'REG_BRE_NORM' is not used [-Wunused-macros]
    193 | #define REG_BRE_NORM                    GENMASK(15, 0)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:238:9: warning: macro 'REG_DEBUG_PC_INT' is not used [-Wunused-macros]
    238 | #define REG_DEBUG_PC_INT                BIT(15)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:56:9: warning: macro 'LOONGSON_CANFD_FLT_B_VAL' is not used [-Wunused-macros]
     56 | #define LOONGSON_CANFD_FLT_B_VAL        0x74    /* Filter B value Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:136:9: warning: macro 'REG_CMD_CPEXS' is not used [-Wunused-macros]
    136 | #define REG_CMD_CPEXS                   BIT(7)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:126:9: warning: macro 'REG_STAT_PEXS' is not used [-Wunused-macros]
    126 | #define REG_STAT_PEXS                   BIT(8)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:78:9: warning: macro 'LOONGSON_CANFD_TX_DATA_10' is not used [-Wunused-macros]
     78 | #define LOONGSON_CANFD_TX_DATA_10       0xd4
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:79:9: warning: macro 'LOONGSON_CANFD_TX_DATA_11' is not used [-Wunused-macros]
     79 | #define LOONGSON_CANFD_TX_DATA_11       0xd8
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:81:9: warning: macro 'LOONGSON_CANFD_TX_DATA_13' is not used [-Wunused-macros]
     81 | #define LOONGSON_CANFD_TX_DATA_13       0xe0
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:83:9: warning: macro 'LOONGSON_CANFD_TX_DATA_15' is not used [-Wunused-macros]
     83 | #define LOONGSON_CANFD_TX_DATA_15       0xe8
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:84:9: warning: macro 'LOONGSON_CANFD_TX_DATA_16' is not used [-Wunused-macros]
     84 | #define LOONGSON_CANFD_TX_DATA_16       0xec
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:85:9: warning: macro 'LOONGSON_CANFD_TX_DATA_17' is not used [-Wunused-macros]
     85 | #define LOONGSON_CANFD_TX_DATA_17       0xf0
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:352:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_12' is not used [-Wunused-macros]
    352 | #define LOONGSON_CANFD_FRAME_DB_12      0x34
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:353:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_13' is not used [-Wunused-macros]
    353 | #define LOONGSON_CANFD_FRAME_DB_13      0x38
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:356:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_17' is not used [-Wunused-macros]
    356 | #define LOONGSON_CANFD_FRAME_DB_17      0x44
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:139:9: warning: macro 'REG_INT_STAT_RXI' is not used [-Wunused-macros]
    139 | #define REG_INT_STAT_RXI                BIT(0)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:267:9: warning: macro 'REG_FIL_C_VAL' is not used [-Wunused-macros]
    267 | #define REG_FIL_C_VAL                   GENMASK(28, 0)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:252:9: warning: macro 'REG_FIL_A_MASK' is not used [-Wunused-macros]
    252 | #define REG_FIL_A_MASK                  GENMASK(28, 0)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:292:9: warning: macro 'REG_FIL_CTRL_SFA' is not used [-Wunused-macros]
    292 | #define REG_FIL_CTRL_SFA                BIT(16)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:232:9: warning: macro 'REG_DEBUG_PC_STC' is not used [-Wunused-macros]
    232 | #define REG_DEBUG_PC_STC                BIT(9)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:59:9: warning: macro 'LOONGSON_CANFD_FLT_R_LOW' is not used [-Wunused-macros]
     59 | #define LOONGSON_CANFD_FLT_R_LOW        0x80    /* Range Filter Low Threshold Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:58:9: warning: macro 'LOONGSON_CANFD_FLT_C_VAL' is not used [-Wunused-macros]
     58 | #define LOONGSON_CANFD_FLT_C_VAL        0x7c    /* Filter C value Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:235:9: warning: macro 'REG_DEBUG_PC_ACK' is not used [-Wunused-macros]
    235 | #define REG_DEBUG_PC_ACK                BIT(12)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:140:9: warning: macro 'REG_INT_STAT_TXI' is not used [-Wunused-macros]
    140 | #define REG_INT_STAT_TXI                BIT(1)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:57:9: warning: macro 'LOONGSON_CANFD_FLT_C_MASK' is not used [-Wunused-macros]
     57 | #define LOONGSON_CANFD_FLT_C_MASK       0x78    /* Filter C Mask Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:317:9: warning: macro 'REG_TX_STAT_TXS' is not used [-Wunused-macros]
    317 | #define REG_TX_STAT_TXS                 GENMASK(10, 8)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:306:9: warning: macro 'REG_RX_STAT_RXE' is not used [-Wunused-macros]
    306 | #define REG_RX_STAT_RXE                 BIT(0)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:104:9: warning: macro 'REG_MODE_ITSM' is not used [-Wunused-macros]
    104 | #define REG_MODE_ITSM                   BIT(10)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:100:9: warning: macro 'REG_MODE_ROM' is not used [-Wunused-macros]
    100 | #define REG_MODE_ROM                    BIT(6)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:298:9: warning: macro 'REG_RX_MEM_INFO_BUFF_SIZE' is not used [-Wunused-macros]
    298 | #define REG_RX_MEM_INFO_BUFF_SIZE       GENMASK(12, 0)
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:248:9: warning: macro 'REG_FRC_FRC_DBT' is not used [-Wunused-macros]
    248 | #define REG_FRC_FRC_DBT                 GENMASK(15, 8)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:230:9: warning: macro 'REG_DEBUG_PC_CON' is not used [-Wunused-macros]
    230 | #define REG_DEBUG_PC_CON                BIT(7)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:233:9: warning: macro 'REG_DEBUG_PC_CRC' is not used [-Wunused-macros]
    233 | #define REG_DEBUG_PC_CRC                BIT(10)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:198:9: warning: macro 'REG_CTR_PRES_PTX' is not used [-Wunused-macros]
    198 | #define REG_CTR_PRES_PTX                BIT(9)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:124:9: warning: macro 'REG_STAT_EWL' is not used [-Wunused-macros]
    124 | #define REG_STAT_EWL                    BIT(6)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:114:9: warning: macro 'REG_CONF_PEX' is not used [-Wunused-macros]
    114 | #define REG_CONF_PEX                    BIT(8)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:96:9: warning: macro 'REG_MODE_STM' is not used [-Wunused-macros]
     96 | #define REG_MODE_STM                    BIT(2)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:150:9: warning: macro 'REG_INT_STAT_OFI' is not used [-Wunused-macros]
    150 | #define REG_INT_STAT_OFI                BIT(11)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:89:9: warning: macro 'REG_ID_MASK' is not used [-Wunused-macros]
     89 | #define REG_ID_MASK                     GENMASK(15, 0)
        |         ^~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:194:9: warning: macro 'REG_BRE_FD_DATA' is not used [-Wunused-macros]
    194 | #define REG_BRE_FD_DATA                 GENMASK(31, 16)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:270:9: warning: macro 'REG_FIL_R_LOW_VAL' is not used [-Wunused-macros]
    270 | #define REG_FIL_R_LOW_VAL               GENMASK(28, 0)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:261:9: warning: macro 'REG_FIL_B_VAL' is not used [-Wunused-macros]
    261 | #define REG_FIL_B_VAL                   GENMASK(28, 0)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:55:9: warning: macro 'LOONGSON_CANFD_FLT_B_MASK' is not used [-Wunused-macros]
     55 | #define LOONGSON_CANFD_FLT_B_MASK       0x70    /* Filter B Mask Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:43:9: warning: macro 'LOONGSON_CANFD_RETX_CNT' is not used [-Wunused-macros]
     43 | #define LOONGSON_CANFD_RETX_CNT         0x40    /* Retransmission Count Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:367:9: warning: macro 'REG_FRAME_META1_TIMESTAMP' is not used [-Wunused-macros]
    367 | #define REG_FRAME_META1_TIMESTAMP       GENMASK(15, 0)
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:229:9: warning: macro 'REG_DEBUG_PC_ARB' is not used [-Wunused-macros]
    229 | #define REG_DEBUG_PC_ARB                BIT(6)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:375:9: warning: macro 'REG_FRAME_TEST_FSTC' is not used [-Wunused-macros]
    375 | #define REG_FRAME_TEST_FSTC             BIT(0)
        |         ^~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:178:9: warning: macro 'REG_ERL_ERP' is not used [-Wunused-macros]
    178 | #define REG_ERL_ERP                     GENMASK(7, 0)
        |         ^~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:378:9: warning: macro 'REG_FRAME_TEST_TPRM' is not used [-Wunused-macros]
    378 | #define REG_FRAME_TEST_TPRM             GENMASK(12, 8)
        |         ^~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:264:9: warning: macro 'REG_FIL_C_MASK' is not used [-Wunused-macros]
    264 | #define REG_FIL_C_MASK                  GENMASK(28, 0)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:241:9: warning: macro 'REG_DEBUG_PC_SOF' is not used [-Wunused-macros]
    241 | #define REG_DEBUG_PC_SOF                BIT(18)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:290:9: warning: macro 'REG_FIL_CTRL_FRFB' is not used [-Wunused-macros]
    290 | #define REG_FIL_CTRL_FRFB               BIT(14)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:288:9: warning: macro 'REG_FIL_CTRL_FRNB' is not used [-Wunused-macros]
    288 | #define REG_FIL_CTRL_FRNB               BIT(12)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:244:9: warning: macro 'REG_TS_TIMESTAMP' is not used [-Wunused-macros]
    244 | #define REG_TS_TIMESTAMP                GENMASK(15, 0)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:118:9: warning: macro 'REG_STAT_RXNE' is not used [-Wunused-macros]
    118 | #define REG_STAT_RXNE                   BIT(0)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:157:9: warning: macro 'REG_INT_ENA_SET' is not used [-Wunused-macros]
    157 | #define REG_INT_ENA_SET                 GENMASK(12, 0)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:299:9: warning: macro 'REG_RX_MEM_INFO_MEM_FREE' is not used [-Wunused-macros]
    299 | #define REG_RX_MEM_INFO_MEM_FREE        GENMASK(28, 16)
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:161:9: warning: macro 'REG_INT_MASK_CLR' is not used [-Wunused-macros]
    161 | #define REG_INT_MASK_CLR                GENMASK(28, 16)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:281:9: warning: macro 'REG_FIL_CTRL_FBNE' is not used [-Wunused-macros]
    281 | #define REG_FIL_CTRL_FBNE               BIT(5)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:279:9: warning: macro 'REG_FIL_CTRL_FAFE' is not used [-Wunused-macros]
    279 | #define REG_FIL_CTRL_FAFE               BIT(3)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:123:9: warning: macro 'REG_STAT_TXS' is not used [-Wunused-macros]
    123 | #define REG_STAT_TXS                    BIT(5)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:80:9: warning: macro 'LOONGSON_CANFD_TX_DATA_12' is not used [-Wunused-macros]
     80 | #define LOONGSON_CANFD_TX_DATA_12       0xdc
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:82:9: warning: macro 'LOONGSON_CANFD_TX_DATA_14' is not used [-Wunused-macros]
     82 | #define LOONGSON_CANFD_TX_DATA_14       0xe4
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:70:9: warning: macro 'LOONGSON_CANFD_TX_DATA_2' is not used [-Wunused-macros]
     70 | #define LOONGSON_CANFD_TX_DATA_2        0xb4
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:74:9: warning: macro 'LOONGSON_CANFD_TX_DATA_6' is not used [-Wunused-macros]
     74 | #define LOONGSON_CANFD_TX_DATA_6        0xc4
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:75:9: warning: macro 'LOONGSON_CANFD_TX_DATA_7' is not used [-Wunused-macros]
     75 | #define LOONGSON_CANFD_TX_DATA_7        0xc8
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:77:9: warning: macro 'LOONGSON_CANFD_TX_DATA_9' is not used [-Wunused-macros]
     77 | #define LOONGSON_CANFD_TX_DATA_9        0xd0
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:291:9: warning: macro 'REG_FIL_CTRL_FRFE' is not used [-Wunused-macros]
    291 | #define REG_FIL_CTRL_FRFE               BIT(15)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:335:9: warning: macro 'REG_TX_SEL_BUF_SEL' is not used [-Wunused-macros]
    335 | #define REG_TX_SEL_BUF_SEL              GENMASK(3, 0)
        |         ^~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:134:9: warning: macro 'REG_CMD_RXFCRST' is not used [-Wunused-macros]
    134 | #define REG_CMD_RXFCRST                 BIT(5)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:147:9: warning: macro 'REG_INT_STAT_BSI' is not used [-Wunused-macros]
    147 | #define REG_INT_STAT_BSI                BIT(8)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:99:9: warning: macro 'REG_MODE_TTTM' is not used [-Wunused-macros]
     99 | #define REG_MODE_TTTM                   BIT(5)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:51:9: warning: macro 'LOONGSON_CANFD_TX_FRM_TST' is not used [-Wunused-macros]
     51 | #define LOONGSON_CANFD_TX_FRM_TST       0x60    /* Transmit Message Debug Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:206:9: warning: macro 'REG_RETX_CNT_VAL' is not used [-Wunused-macros]
    206 | #define REG_RETX_CNT_VAL                GENMASK(3, 0)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:228:9: warning: macro 'REG_DEBUG_DSTF_CNT' is not used [-Wunused-macros]
    228 | #define REG_DEBUG_DSTF_CNT              GENMASK(5, 3)
        |         ^~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:199:9: warning: macro 'REG_CTR_PRES_PRX' is not used [-Wunused-macros]
    199 | #define REG_CTR_PRES_PRX                BIT(10)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:142:9: warning: macro 'REG_INT_STAT_DOI' is not used [-Wunused-macros]
    142 | #define REG_INT_STAT_DOI                BIT(3)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:125:9: warning: macro 'REG_STAT_IDLE' is not used [-Wunused-macros]
    125 | #define REG_STAT_IDLE                   BIT(7)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:197:9: warning: macro 'REG_CTR_PRES_CTPV' is not used [-Wunused-macros]
    197 | #define REG_CTR_PRES_CTPV               GENMASK(8, 0)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:97:9: warning: macro 'REG_MODE_AFM' is not used [-Wunused-macros]
     97 | #define REG_MODE_AFM                    BIT(3)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:240:9: warning: macro 'REG_DEBUG_PC_OVR' is not used [-Wunused-macros]
    240 | #define REG_DEBUG_PC_OVR                BIT(17)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:310:9: warning: macro 'REG_RX_STAT_RTSOP' is not used [-Wunused-macros]
    310 | #define REG_RX_STAT_RTSOP               BIT(16)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:313:9: warning: macro 'REG_RX_DATA_VAL' is not used [-Wunused-macros]
    313 | #define REG_RX_DATA_VAL                 GENMASK(31, 0)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:63:9: warning: macro 'LOONGSON_CANFD_RX_PRT' is not used [-Wunused-macros]
     63 | #define LOONGSON_CANFD_RX_PRT           0x90    /* Receive Buffer Pointer Register */
        |         ^~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:258:9: warning: macro 'REG_FIL_B_MASK' is not used [-Wunused-macros]
    258 | #define REG_FIL_B_MASK                  GENMASK(28, 0)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:289:9: warning: macro 'REG_FIL_CTRL_FRNE' is not used [-Wunused-macros]
    289 | #define REG_FIL_CTRL_FRNE               BIT(13)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:377:9: warning: macro 'REG_FRAME_TEST_SDLC' is not used [-Wunused-macros]
    377 | #define REG_FRAME_TEST_SDLC             BIT(2)
        |         ^~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:293:9: warning: macro 'REG_FIL_CTRL_SFB' is not used [-Wunused-macros]
    293 | #define REG_FIL_CTRL_SFB                BIT(17)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:294:9: warning: macro 'REG_FIL_CTRL_SFC' is not used [-Wunused-macros]
    294 | #define REG_FIL_CTRL_SFC                BIT(18)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:295:9: warning: macro 'REG_FIL_CTRL_SFR' is not used [-Wunused-macros]
    295 | #define REG_FIL_CTRL_SFR                BIT(19)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:224:9: warning: macro 'REG_TX_FR_CNT_VAL' is not used [-Wunused-macros]
    224 | #define REG_TX_FR_CNT_VAL               GENMASK(31, 0)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:60:9: warning: macro 'LOONGSON_CANFD_FLT_R_HI' is not used [-Wunused-macros]
     60 | #define LOONGSON_CANFD_FLT_R_HI         0x84    /* Range Filter High Threshold Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:71:9: warning: macro 'LOONGSON_CANFD_TX_DATA_3' is not used [-Wunused-macros]
     71 | #define LOONGSON_CANFD_TX_DATA_3        0xb8
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:73:9: warning: macro 'LOONGSON_CANFD_TX_DATA_5' is not used [-Wunused-macros]
     73 | #define LOONGSON_CANFD_TX_DATA_5        0xc0
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:76:9: warning: macro 'LOONGSON_CANFD_TX_DATA_8' is not used [-Wunused-macros]
     76 | #define LOONGSON_CANFD_TX_DATA_8        0xcc
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:115:9: warning: macro 'REG_CONF_FDRF' is not used [-Wunused-macros]
    115 | #define REG_CONF_FDRF                   BIT(10)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:122:9: warning: macro 'REG_STAT_RXS' is not used [-Wunused-macros]
    122 | #define REG_STAT_RXS                    BIT(4)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:303:9: warning: macro 'REG_RX_PTR_RPP' is not used [-Wunused-macros]
    303 | #define REG_RX_PTR_RPP                  GENMASK(27, 16)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:286:9: warning: macro 'REG_FIL_CTRL_FCFB' is not used [-Wunused-macros]
    286 | #define REG_FIL_CTRL_FCFB               BIT(10)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:287:9: warning: macro 'REG_FIL_CTRL_FCFE' is not used [-Wunused-macros]
    287 | #define REG_FIL_CTRL_FCFE               BIT(11)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:121:9: warning: macro 'REG_STAT_EFT' is not used [-Wunused-macros]
    121 | #define REG_STAT_EFT                    BIT(3)
        |         ^~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:130:9: warning: macro 'REG_CMD_RXRPMV' is not used [-Wunused-macros]
    130 | #define REG_CMD_RXRPMV                  BIT(1)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:342:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_2' is not used [-Wunused-macros]
    342 | #define LOONGSON_CANFD_FRAME_DB_2       0xc
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:344:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_4' is not used [-Wunused-macros]
    344 | #define LOONGSON_CANFD_FRAME_DB_4       0x14
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:347:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_7' is not used [-Wunused-macros]
    347 | #define LOONGSON_CANFD_FRAME_DB_7       0x20
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:348:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_8' is not used [-Wunused-macros]
    348 | #define LOONGSON_CANFD_FRAME_DB_8       0x24
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:343:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_3' is not used [-Wunused-macros]
    343 | #define LOONGSON_CANFD_FRAME_DB_3       0x10
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:349:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_9' is not used [-Wunused-macros]
    349 | #define LOONGSON_CANFD_FRAME_DB_9       0x28
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:345:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_5' is not used [-Wunused-macros]
    345 | #define LOONGSON_CANFD_FRAME_DB_5       0x18
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:346:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_6' is not used [-Wunused-macros]
    346 | #define LOONGSON_CANFD_FRAME_DB_6       0x1c
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:52:9: warning: macro 'LOONGSON_CANFD_FRC_DIV' is not used [-Wunused-macros]
     52 | #define LOONGSON_CANFD_FRC_DIV          0x64    /* Fractional Divider Ratio Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:350:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_10' is not used [-Wunused-macros]
    350 | #define LOONGSON_CANFD_FRAME_DB_10      0x2c
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:351:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_11' is not used [-Wunused-macros]
    351 | #define LOONGSON_CANFD_FRAME_DB_11      0x30
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:355:9: warning: macro 'LOONGSON_CANFD_FRAME_DB_16' is not used [-Wunused-macros]
    355 | #define LOONGSON_CANFD_FRAME_DB_16      0x40
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:54:9: warning: macro 'LOONGSON_CANFD_FLT_A_VAL' is not used [-Wunused-macros]
     54 | #define LOONGSON_CANFD_FLT_A_VAL        0x6c    /* Filter A value Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:237:9: warning: macro 'REG_DEBUG_PC_EOF' is not used [-Wunused-macros]
    237 | #define REG_DEBUG_PC_EOF                BIT(14)
        |         ^~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:49:9: warning: macro 'LOONGSON_CANFD_DEBUG' is not used [-Wunused-macros]
     49 | #define LOONGSON_CANFD_DEBUG            0x58    /* Debug Register */
        |         ^~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:131:9: warning: macro 'REG_CMD_RRB' is not used [-Wunused-macros]
    131 | #define REG_CMD_RRB                     BIT(2)
        |         ^~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:302:9: warning: macro 'REG_RX_PTR_WPP' is not used [-Wunused-macros]
    302 | #define REG_RX_PTR_WPP                  GENMASK(11, 0)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:239:9: warning: macro 'REG_DEBUG_PC_SUSP' is not used [-Wunused-macros]
    239 | #define REG_DEBUG_PC_SUSP               BIT(16)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:376:9: warning: macro 'REG_FRAME_TEST_FCRC' is not used [-Wunused-macros]
    376 | #define REG_FRAME_TEST_FCRC             BIT(1)
        |         ^~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:278:9: warning: macro 'REG_FIL_CTRL_FAFB' is not used [-Wunused-macros]
    278 | #define REG_FIL_CTRL_FAFB               BIT(2)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:276:9: warning: macro 'REG_FIL_CTRL_FANB' is not used [-Wunused-macros]
    276 | #define REG_FIL_CTRL_FANB               BIT(0)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:277:9: warning: macro 'REG_FIL_CTRL_FANE' is not used [-Wunused-macros]
    277 | #define REG_FIL_CTRL_FANE               BIT(1)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:282:9: warning: macro 'REG_FIL_CTRL_FBFB' is not used [-Wunused-macros]
    282 | #define REG_FIL_CTRL_FBFB               BIT(6)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:283:9: warning: macro 'REG_FIL_CTRL_FBFE' is not used [-Wunused-macros]
    283 | #define REG_FIL_CTRL_FBFE               BIT(7)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:308:9: warning: macro 'REG_RX_STAT_RXMOF' is not used [-Wunused-macros]
    308 | #define REG_RX_STAT_RXMOF               BIT(2)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:280:9: warning: macro 'REG_FIL_CTRL_FBNB' is not used [-Wunused-macros]
    280 | #define REG_FIL_CTRL_FBNB               BIT(4)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:90:9: warning: macro 'REG_ID_VER_MIN' is not used [-Wunused-macros]
     90 | #define REG_ID_VER_MIN                  GENMASK(23, 16)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:62:9: warning: macro 'LOONGSON_CANFD_RX_MEM_INFO' is not used [-Wunused-macros]
     62 | #define LOONGSON_CANFD_RX_MEM_INFO      0x8c    /* Receive Buffer Information Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:127:9: warning: macro 'REG_STAT_STCNT' is not used [-Wunused-macros]
    127 | #define REG_STAT_STCNT                  BIT(16)
        |         ^~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:236:9: warning: macro 'REG_DEBUG_PC_ACKD' is not used [-Wunused-macros]
    236 | #define REG_DEBUG_PC_ACKD               BIT(13)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:146:9: warning: macro 'REG_INT_STAT_RXFI' is not used [-Wunused-macros]
    146 | #define REG_INT_STAT_RXFI               BIT(7)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:120:9: warning: macro 'REG_STAT_TXNF' is not used [-Wunused-macros]
    120 | #define REG_STAT_TXNF                   BIT(2)
        |         ^~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:135:9: warning: macro 'REG_CMD_TXFCRST' is not used [-Wunused-macros]
    135 | #define REG_CMD_TXFCRST                 BIT(6)
        |         ^~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:381:9: warning: macro 'LOONGSON_CANFD_ID' is not used [-Wunused-macros]
    381 | #define LOONGSON_CANFD_ID               0xBABE
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:72:9: warning: macro 'LOONGSON_CANFD_TX_DATA_4' is not used [-Wunused-macros]
     72 | #define LOONGSON_CANFD_TX_DATA_4        0xbc
        |         ^~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:284:9: warning: macro 'REG_FIL_CTRL_FCNB' is not used [-Wunused-macros]
    284 | #define REG_FIL_CTRL_FCNB               BIT(8)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:285:9: warning: macro 'REG_FIL_CTRL_FCNE' is not used [-Wunused-macros]
    285 | #define REG_FIL_CTRL_FCNE               BIT(9)
        |         ^~~~~~~~~~~~~~~~~
  drivers/net/can/loongson_canfd.c:53:9: warning: macro 'LOONGSON_CANFD_FLT_A_MASK' is not used [-Wunused-macros]
     53 | #define LOONGSON_CANFD_FLT_A_MASK       0x68    /* Filter A Mask Register */
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~

>  drivers/net/can/Kconfig          |   2 +-
>  drivers/net/can/loongson_canfd.c | 209 ++++++++++++++++++++++++++++---
>  2 files changed, 190 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 28014e264f30..16e07be6438c 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -191,7 +191,7 @@ config CAN_KVASER_PCIEFD
>  
>  config CAN_LOONGSON_CANFD
>  	tristate "Loongson CAN-FD controller"
> -	depends on HAS_IOMEM || COMPILE_TEST
> +	depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)

The logic is odd here. If your driver can be COMPILE_TESTed without
HAS_IOMEM, then patch 1 should be:

	depends on HAS_IOMEM || COMPILE_TEST

and patch 2 should be:

	depends on (HAS_IOMEM && LOONGSON2_APB_CMC_DMA) || COMPILE_TEST

If your driver need HAS_IOMEM even for a compile test, then patch 1
should be:

	depends on HAS_IOMEM

and patch 2 should be:

	depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)

Here, you are doing a weird mix.

>  	select REGMAP_MMIO
>  	help
>  	  This is a canfd driver switch for the Loongson platform,


Yours sincerely,
Vincent Mailhol

