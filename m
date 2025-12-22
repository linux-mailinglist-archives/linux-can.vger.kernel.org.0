Return-Path: <linux-can+bounces-5900-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 569DBCD6990
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 16:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF13330365A6
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEA3191D9;
	Mon, 22 Dec 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctNIdn9Q"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D470320CCE
	for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766418147; cv=none; b=SeNjaCevj5ociBWSivcZVXVgcyY1fj59tFIaVZ3kGNlPulFZft13Q53pGMzpFKGDSePN6WNGAwRrmgYZ52w8/Okm2MfBQSpAWl1OuV4Qat6RMZUuxc32qOmgLJmiBd+VlMxDQrOS1Wc4AkKAtRozZdqeMoknVFbqeL4B2yDtIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766418147; c=relaxed/simple;
	bh=PK54Vy1SNWF2cozJivqVKZzpFOSBZDESHiOGhjh4Uiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzVBnWs6TLQh7f9CDwitMG5fkAGfq5clK7j2GMiCrubGnux4FU2HhLhscnV0mUR44nMwjLIzgT2SMvIJh6iNPGkQCBSNZO/+8hHNwiGiY/uagCu2YbAsawY6L7/41GUQ/AH714o4uHlrnWD28ADmKWVBgaXEd9uhpGY16Fe3wHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctNIdn9Q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b72b495aa81so675662366b.2
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 07:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766418144; x=1767022944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mblUD38NHDbav+TAFmjVgjtSnMMRCCdvFD/wMYmq7jU=;
        b=ctNIdn9Qir2RMzR4Ggh0T6zv5NgFuPF4UyUqN386jMixsVrrQVE+u2a5Jk6p2fCMMN
         Z9KKb6YzcMOv7ALZ8G6Uy5yvreAAzCAcUV+9EWAVQJSfH3f/90Kvcr1we//k7p2uhAFy
         UOqgLOf07RNUI7bW7WegWPU+YSIK9xKYIOvERqtQ0kSMpv2G1JWctuqnUEf/yvhorDHb
         TGJDi4qJ1CfI3H1WjjFUDsHp2LLTE5pWR4J392m5SSvB1q89biWVthpKiH0VCXLKLvvh
         uFwrK+MCC4rSaFQke67xR9FExZyM4b7gRozfZurdWAo7I57PsIRtS59HRVc9kxW032N7
         4Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766418144; x=1767022944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mblUD38NHDbav+TAFmjVgjtSnMMRCCdvFD/wMYmq7jU=;
        b=KndI8HmkI50kM4zIqRLdQUunVmz23MXa6+STHXS9FxPHFV4ptR7LvcwhxwanOmSRuR
         qhHRdXpEfKAOOclYH9uRSVzhQs2GFiRHnQsStJJGvKnQV+nX+FdjxS1Wh95vIdMDPnUN
         gVOsJMxFGQ5s3+4dvRNdJ86Pwcy8e3FqZbKBMr8b2O4WbtvErgGeelIDSmnEKTVfgPsw
         xpGvtk92eCNIVYcxyb22rLjc69S7e5ngXV7hMaGF3lDIp0mnh/GvlLLbTgvCZYFxeMDW
         zKURi+04ixDc5DptiLdNjnAXBwBPccOTh7B0RQBomYaesvXge5jr8KFqP6mAeULp3zhh
         FmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVrE8sXvKHIMDOpHLA0LVOwOd/efWSLPjFqfvnhCHyerHyx/p56Q72T6sKyaGyE4M+f8uCNAVHr48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvykNo+LE6ASCpCiKI7ZdP8zYdeJy7ROx50SSP8qTy4AvY+eo
	Yg78IN82oi4KWmoQRhzpMz616el545i8FcXIDm8agvHZ2zLfQebvmHrU
X-Gm-Gg: AY/fxX4k82+sdeGLF+c0bgq9pXwwXOYZMgr2IzgzwnkB8rDgWbCswF5SQI6nYZA3yVG
	3bFsnBNoOIUm+0Ag2KNpHmOlX9zX4OlTSgaNsqux+JG7LXaghnqYhG4KX3FiF772S9/ljBSiowK
	oKLNV8cQ0oJRBtyvNAEi3RGlEUYgcQnQZJf+5CPteVUSqa1TUZ+99B2SYaq74GTmOnf7Jrcxg9A
	zvtb//dtfB71K25tu1irRE94r8Hu7Ew8XVFiw18w0h2SrAEtElp0YAE/fHUZmxc7Bzd/T7A2E5/
	8mVa2Q6qnq1eeKltPmyFGaokml9ntBaqpLUzpcbVWCiqxOb+tFBJY3ihVMwK1oOnYp6jm433FIM
	02VxgXoLpBUEC55js/TlOnLHVQAAEwNgkVM/b/NK1K/NY5sAEmfd4muK6VKcQ3hvdzcsdv4alJa
	o=
X-Google-Smtp-Source: AGHT+IEALuj4P0gRBV3lHJw2QhDugmQDk4nADpDVCK6cv9famhN2Yt9iUEpm+4rfnaEzABbUcDiSAA==
X-Received: by 2002:a17:907:1c17:b0:b76:31e6:2ee1 with SMTP id a640c23a62f3a-b8036f65331mr1101190866b.18.1766418143545;
        Mon, 22 Dec 2025 07:42:23 -0800 (PST)
Received: from prometheus ([85.11.110.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b7bcsm1156790966b.49.2025.12.22.07.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:42:23 -0800 (PST)
From: Szymon Wilczek <swilczek.lx@gmail.com>
To: mailhol@kernel.org,
	mkl@pengutronix.de
Cc: arunachalam.santhanam@in.bosch.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Szymon Wilczek <swilczek.lx@gmail.com>,
	syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
Subject: [PATCH] can: etas_es58x: fix memory leak in es58x_open()
Date: Mon, 22 Dec 2025 16:42:08 +0100
Message-ID: <20251222154208.22117-1-swilczek.lx@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When es58x_alloc_rx_urbs() fails partway through allocating RX URBs
(e.g., if usb_submit_urb() fails at iteration i), the function returns
an error but leaves any previously allocated and anchored URBs leaked.

The issue is that es58x_open() returns directly on es58x_alloc_rx_urbs()
failure instead of jumping to the free_urbs label, which would call
es58x_free_urbs() to clean up any anchored URBs.

Fix this by changing 'return ret' to 'goto free_urbs' to ensure proper
cleanup of all allocated URBs on failure.

Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
Reported-by: syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e8cb6691a7cf68256cb8
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index f799233c2b72..d92c37f277d5 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1784,7 +1784,7 @@ static int es58x_open(struct net_device *netdev)
 	if (!es58x_dev->opened_channel_cnt) {
 		ret = es58x_alloc_rx_urbs(es58x_dev);
 		if (ret)
-			return ret;
+			goto free_urbs;
 
 		ret = es58x_set_realtime_diff_ns(es58x_dev);
 		if (ret)
-- 
2.52.0


