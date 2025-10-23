Return-Path: <linux-can+bounces-5267-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020BBFEC15
	for <lists+linux-can@lfdr.de>; Thu, 23 Oct 2025 02:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CDF18C4A40
	for <lists+linux-can@lfdr.de>; Thu, 23 Oct 2025 00:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E618CC13;
	Thu, 23 Oct 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqDmdwHd"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987E1A073F
	for <linux-can@vger.kernel.org>; Thu, 23 Oct 2025 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761180066; cv=none; b=HvlKUWUEW8RZ/foZxskSHuV0M+5DT7EuW8xGSz2V9D5oZtWvEzdXbspybPH7uhwFR0uah9RPpHA03GpBd+aCnjhUXhQMUWJ1YGhPJ6FjzGIAT0xls0J7i4ipmw1je88EhDgggtRgQo4aJP99bA8p3Y1PlvDrGHCc6d38Z5o1lFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761180066; c=relaxed/simple;
	bh=7DgO2ExysMIKV0mplHDEQtusRwR+3gXIIcUSPZ9a3qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMvEHnvAqj4WPl7QjuvOApaQuZHoxP0+1rDK0au0I61TO+IfFrEYGzvPmdFqdSmHfRhnL7purjC8+arvJAGG4feYjGBOy56AgI11K229oxE6wLtKVAQcbFc5XwwnSeHSdKsH5L/UjnG5dnrnHsDvGrruEuQXKxLMnYG/FHmwyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqDmdwHd; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87dfba1b278so2643306d6.1
        for <linux-can@vger.kernel.org>; Wed, 22 Oct 2025 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761180064; x=1761784864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71zx8jf+73P/W+rkuTFme2ni0Pfhc1L1pq1AvB/zgt4=;
        b=BqDmdwHd7gFJWo2QKoOh7yaVribh00aKVf/VUBa7z1OWQgp3JHJrRQliS7mHwjxnmJ
         oMLGdpj66SF9EIbwwIMQ8nUR8/4nVrzP6Bxxj461cb/PtVDHsxIHiGErTvvc44f6yH+f
         DOHBL8olqsLk3LnhRHBrd7s7YRx/Y2VkS2OHZ4t66Yvavu5Wkeo9L9AMhJal8DFHAHnh
         iqP7O7/fjBpi5/G/zpHwH41e5aqpD3c8krbqQQOi5VIX4EFAkguIXihx9P9odc6Ppbgt
         3AwOdiIadaF2JfpsC/mOBA6VnGcE4jWY1vAXVyPfQG7n6G2zG6LPqTTqFeBMOy4Yp5f4
         ho7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761180064; x=1761784864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71zx8jf+73P/W+rkuTFme2ni0Pfhc1L1pq1AvB/zgt4=;
        b=JAL8q8rViuaL+QhJ9yTejGrLCAD4g4XYZegOwapRF6xXd5Go+dg/08CH4ylJ3R/TgN
         9hSbWHYVdyW89Sj5J61hMDWTGBr/5Fv19rloDdXC7/wJxOHmMjpQ0ohdw2cZVzZhQuH2
         J+E9RwVj2HhJ1FrLa0HDhWtkW0zLRzgalpTzOQ/OgxMhnbvzkSsS+/iOcliTgztetdRG
         efvTi1/MYtizMTQfCo10qtGap5XRolO+wyblv/RqBRsWRLTMFXE7xYj6BsPgl5vb835D
         Is8b7WTtuUZbtX+YQlhO7/bjKEm+zxy+kO72L5zA3joe/UWT3FOGqQN/yYN/tdELBL7g
         C69A==
X-Forwarded-Encrypted: i=1; AJvYcCWxDDDKNTbAUdI29h8Uw0eV7yYkfH3Rqz4bQ60P3Z+PMjZHUPw15GPgwt7b6NmjT2OID3qKOtxuGBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc89DejW4OIsvU1y4KVe+zsTxW+qlh5d7IrKgvdf0aOVikKHl6
	H0qpzpszZSE14P2kbRzaAzoOYqsr56PsgnMdsfZXdTe4t9R9pKVdTbdpzTLbFOmKSNc=
X-Gm-Gg: ASbGncv/JbGWMniV+MJkZagHvleTeMqjQviQDO218YRz7oIMEEr44PxTwXnBOS0TNqP
	FheRQFfY7OmzZW9Xeoa4fHa/UIBzbxpwg1siY0z2d7yKAeGGq344HGPSqDLJ87WSjaonYciGfpg
	+PS9QQjM14Dh/kaieYDZhpTcvmD6qANwYe1zDp7APEUmZlLG8Qu+qU86g9rERzu4mIhJsFTSseC
	RlO5aOnJ7YhBqYu3DsoY33tMPR/+N2qoek4q7K7bsfE/Iqg4pjo5ZrRowTehZpnaNjXWrRy3Nk/
	8zMgB4HgbdJo1hmRnQTSwSAU+T4/iMafSWLbBewAQpX4TjFpBjtilP3WchvUs8JiHNfnGIRCZPR
	XjxIbb5btcdjD3POYGNQRDjsrzu9I1ooyd9f76+olhIJTr3aykbo5ErEBiBgmSTzeW5yP0Q8iFz
	xx0NaCKVsj7oTy1b4Io+GHkl/5zBjTzQDA7PtMMvf07ysYLd5kCINZpGHeleG7Q5XQm1Xc2k8qD
	9x7ep/Y3sSA5sKOhmRyz8zCO900FP7yRJoJ4IzmWw0=
X-Google-Smtp-Source: AGHT+IGd8qBUBkaazKZiy+1ZSStUtxhkxZdsF9kAwOsi+CRvWAqsTZFDBarOPynXY9b02PeUXMHAzA==
X-Received: by 2002:ad4:5741:0:b0:87e:d590:89b7 with SMTP id 6a1803df08f44-87f9eda1e5emr11114336d6.19.1761180064043;
        Wed, 22 Oct 2025 17:41:04 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9f8ede50sm3442506d6.49.2025.10.22.17.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:41:03 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jimmy Assarsson <extja@kvaser.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: kvaser_usb: leaf: Fix infinite loop on zero-length cmd
Date: Wed, 22 Oct 2025 20:39:09 -0400
Message-ID: <20251023003908.130468-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The `kvaser_usb_leaf_read_bulk_callback()` function parse received
command buffers from the device. The firmware may insert zero-length
placeholder commands to handle alignment with the USB endpoint's
wMaxPacketSize.

The driver attempts to skip these placeholders by aligning the buffer
position `pos` to the next packet boundary using `round_up()` function.

However, if zero-length command is found exactly on a packet boundary
(i.e., `pos` is a multiple of wMaxPacketSize, including 0), `round_up`
function will return the unchanged value of `pos`. This prevents `pos`
to be increased, causing an infinite loop in the parsing logic.

I fixed this in the function by using `pos + 1` instead. This ensures
that even if `pos` is on a boundary, the calculation is based on
`pos + 1`, forcing `round_up()` to always return the next aligned
boundary.

Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c29828a94ad0..4da6d4ba4e1e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1732,7 +1732,7 @@ static void kvaser_usb_leaf_read_bulk_callback(struct kvaser_usb *dev,
 		 * number of events in case of a heavy rx load on the bus.
 		 */
 		if (cmd->len == 0) {
-			pos = round_up(pos, le16_to_cpu
+			pos = round_up(pos + 1, le16_to_cpu
 						(dev->bulk_in->wMaxPacketSize));
 			continue;
 		}
-- 
2.43.0

