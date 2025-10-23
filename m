Return-Path: <linux-can+bounces-5270-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0724BC02710
	for <lists+linux-can@lfdr.de>; Thu, 23 Oct 2025 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAC41899856
	for <lists+linux-can@lfdr.de>; Thu, 23 Oct 2025 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF882D46A7;
	Thu, 23 Oct 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQEz05TZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4242D5920
	for <linux-can@vger.kernel.org>; Thu, 23 Oct 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236841; cv=none; b=qfNml0dhKie283GwRtYMI13SZ6goyuNOtbHbeJKSM4ycMXRVmJlmPjvfI+VmYTteTEif19FXAR4qu2qePwNoJoCf/pKJGU7tIBioil9/sk1rdq1wJMKpJojBvxFwEHJwUY53p1BLUsCGTNH1BZxa1qjTMJB1MhQT9kBGR3nBR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236841; c=relaxed/simple;
	bh=eIKrqlXU/8n9AqT0k1+v3qjg2Q9CMZzbVJvOLiJgpEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nm79U7t0cgxbAtrCHp1Sipx27PWm4Bhl8aFoMBW7gEG0bvKcDmSrrlldLOx3XCDV8eIqsV9qs7WtYdF8Coyy1QgjLsTjk4FFwrRusZfPMOmAN6kmUjovi1FRpJFKr+lDX2uICcNXS9aXPzCRAtolFdzSU2tWmVTgLJnQ9CmVRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQEz05TZ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87bb66dd224so8071826d6.3
        for <linux-can@vger.kernel.org>; Thu, 23 Oct 2025 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761236838; x=1761841638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2imvIwdo3P7V8AuAbuO7jvkCgPpqmVrl6exJRyM00DU=;
        b=KQEz05TZ80Z8FaTDYpyks3wM809T9FmSZ1mAadKM0nn8RCiyzsFyl4JwFTCxpuz1pe
         kheMGCswjGQEbyByrZL1bnUknNblylIJ5P2BrCjwu4dkcDgDdNkYga1jK9UrwhPHhZJJ
         QWwQaVEidby/f+FG4HkV+/UCH3naPtF1+z5VIe+Ai3u3o1guq2xok/dTJ0Jujc0N3FkQ
         5d2sPQxUWpJrcr2cqr57SGYHjkBv7Nz67SWNm9IDM0soVQrA+IqNE0WzQWArhjZLqUjl
         hb/n1WBFnAKdNZ+i5b3/eqTcm6Jqg6KZiBJexKlrSfYPsFj9Chr5vmdawaKuKancynmU
         71Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236838; x=1761841638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2imvIwdo3P7V8AuAbuO7jvkCgPpqmVrl6exJRyM00DU=;
        b=mj/FseMMY5/EpUFDdD3wx92TwRWooC4fsHbTPVsWQvqGyd/UE/LKvX5KofwGw4lYL0
         5tcH865UgJFurLPd6ghs3n3uqE3w9rszA+nB/6+A2Ax10wqvI7AIYzsYFNz6l3Y5PJ5r
         UXRsqYd4klyjZHAA0sPws1s23BfO2HgL7rHitg89gjd5fHqHgULSL+yhha262HkGcob7
         7kTLfP4R+N1X2VMErn/hzofvBGDzKEJ+PidJ7VAKtR2G6GdfQQipHzJ3j6pXDW2pE5PY
         f1PVNMYoMt0zjU6Cuop1c5wFaIBOjpuhtXHMmDFjRsjBKt1mBILeFT1sPtAXxUPprqzN
         siiA==
X-Forwarded-Encrypted: i=1; AJvYcCWGqqgh22T68PmHJhKIHne2BzXytbadlxQ9aEQqRffc6o+Juzp7MDJ1efS3g933W4elu9+xcJQF9Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItWGCS2g9LZcMgmJHUkRiY3opTkqRdjcJsfMQ9zvEyffRYKJz
	FV77Wv1PRXfXvDqc3kkRrMBEKziGBT7UNVdP+dT5ompbvBpQDn2pWfgk
X-Gm-Gg: ASbGncvbFm4Af1zJDVy+N2NgyHQMng6v6Mim8tBJ0sdFMCG0pd2ieFayu9Z1KofsAys
	JhlV6JZphEIWbIduGKdUHTtJbSyiwzyPW8rHBRiiIBUWeY0oXCHP9tx1dJbKFuHnrmpq9aQpbND
	OylyZvaaO0YbcL6QG+nK4SgAuZioMIWIqJaLvBY1XuDmCiKuQfs4TKDmsXvzcGUhtojjAuDfFeX
	vkHDfT4Su8pa/xs9eRlBFm/MyJTr1mjCzzl4jR91/4Bw4y+KTILAvlWeNnMGNrDeRIC/gj/47nx
	7qFJZpNi2kNPlKG0hPNnDazkIwVtpa/EniZfRWX72ibyp6K6iysJggZO2zMY4B5IplQNJICWBrw
	VB7opixsXFbkeeNTucWwRuuFJwsMD+UzmYlWKrNtuGxCCX3ZhkTufmV4rncWgDqMquDS/oRz8HL
	ZXC/oXe5K+/fgpv/82BEXIZsauh8LnT6wQvHRl4QWwA2utBSYPOlP6oSlUbOt7JjzV3xp7r6b+S
	wJ/fO1wQhFF/gZCAuPDDCNpZaASuRIfyVQgT+cjabc=
X-Google-Smtp-Source: AGHT+IG/t8sPFUNbEssBw0o8EJ7IDLcRUAqafB6jh5jOeBHVSLTybCLKZLOZDFW2qLfhUheRhw2XiQ==
X-Received: by 2002:a05:6214:260a:b0:87c:2919:7db3 with SMTP id 6a1803df08f44-87c291981c2mr239330876d6.51.1761236837786;
        Thu, 23 Oct 2025 09:27:17 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e7fc743sm18286456d6.52.2025.10.23.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:27:17 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jimmy Assarsson <extja@kvaser.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] can: kvaser_usb: leaf: Fix potential infinite loop in command parsers
Date: Thu, 23 Oct 2025 12:27:09 -0400
Message-ID: <20251023162709.348240-1-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAsoPpV7Kzap1Sn8QFtBbvwW-DJMTTcU_bBOUDYYC286Uaddtg@mail.gmail.com>
References: <CAAsoPpV7Kzap1Sn8QFtBbvwW-DJMTTcU_bBOUDYYC286Uaddtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The `kvaser_usb_leaf_wait_cmd()` and `kvaser_usb_leaf_read_bulk_callback`
functions contain logic to zero-length commands. These commands are used
to align data to the USB endpoint's wMaxPacketSize boundary.

The driver attempts to skip these placeholders by aligning the buffer
position `pos` to the next packet boundary using `round_up()` function.

However, if zero-length command is found exactly on a packet boundary
(i.e., `pos` is a multiple of wMaxPacketSize, including 0), `round_up`
function will return the unchanged value of `pos`. This prevents `pos`
to be increased, causing an infinite loop in the parsing logic.

This patch fixes this in the function by using `pos + 1` instead.
This ensures that even if `pos` is on a boundary, the calculation is
based on `pos + 1`, forcing `round_up()` to always return the next
aligned boundary.

Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Apply the same infinite loop fix to kvaser_usb_leaf_wait_cmd()
 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c29828a94ad0..1167d38344f1 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -685,7 +685,7 @@ static int kvaser_usb_leaf_wait_cmd(const struct kvaser_usb *dev, u8 id,
 			 * for further details.
 			 */
 			if (tmp->len == 0) {
-				pos = round_up(pos,
+				pos = round_up(pos + 1,
 					       le16_to_cpu
 						(dev->bulk_in->wMaxPacketSize));
 				continue;
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


