Return-Path: <linux-can+bounces-1659-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC95A99D285
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198BF1C22FD9
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29EF1C8FC6;
	Mon, 14 Oct 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pD3Q5pjF"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2981C7610
	for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919492; cv=none; b=nKpOJvf7ctUkjkGz+kR88gJI6dX7iFB+TKiWq3izH3XFqx/nbwiOTSUfOXJgSZxL6WtlpC093uTpnwnDpXmREGQMevqrHVj2ueDSDy1Ls3UcnvwVSC5Wfp9QBcVmoakxQbx62L/53wLUsYrFISe3hl6SgE4CvAI24Fg9Tj40U4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919492; c=relaxed/simple;
	bh=1scCBJ/VM0pca31nuWrlLm4/5Gj3CR8thHP51DHu8A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIYn8veZLfSfpSlDVflLE/nLQBI2xCvDT3fwq7GBW5CSTO8Lz4UjwwjKs68yAkrzPdzDrLsKH6+H/kRj2dUrKuNIQeXWbQGPSnDW8CtUxvGCkQ89OJqIIQ0sZcr3PflneBltzQc8hAQa3KJmHrKd4wzrUrXFZLVAlKKUmbKkbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=pD3Q5pjF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4311c575172so32630785e9.2
        for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728919489; x=1729524289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pO1UlU+Kdbb/WHWYgWNeRFcofykWy+kMnflMuEIHEjY=;
        b=pD3Q5pjFO9bnrRkYpnuCRfhBqiI6wcwJz1497/3Hs09/Y/K+gxFv7XcQ8O0kk1wxiD
         eSDT8BRGeKhUzAFRWM3L1x2FR/UEjqF1jJ1HjeV8QOaE90PVWP0Nb6YAoIDll/b5nNdd
         ChRFXKwrGURxxkCLHjR8cQLCcR9IhMIWA5Sd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919489; x=1729524289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pO1UlU+Kdbb/WHWYgWNeRFcofykWy+kMnflMuEIHEjY=;
        b=GeqJbh/WsLIyd3YoedBdll994ZcTOYM8Y6YDuZTXYNoPRfjPAz3xye0m5D3qagBLom
         BxYdr8PMVlQu04PPhVrvyUV+uDRej+BQY8MAaJKZQoSQN9XBnLLta9Zaxji2WYlkC+W2
         dnUqVXhpfHScIjA/2XUqnTky0YyNpChoEVdeY8HR3/4Rj5Dsl2tDyk8jwSGjha7yyVP/
         8WqQ8jQLE/gaanFKKN9uutGJYgueRW1hN5hpyhrqG2c+vAgmV87I2JTGPHj1bauDHI8Y
         ZtpkvBWl0tI3a+XjP7Ixef3y92WRLmhZqs28ZPI4++GqR6YYUFtWwdwF7RWBEH3yMEy+
         fymQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6KCSru4hB+mgxPXV9pCySJw7D7CDEn+TOjNruXOPtgcyKJ60Ba2Fsr+wjmttfgqdsfXmoRFpues=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg93f87KKUoQOxWuhuSifD86HK5Bts3pNT8BHivUbJ3GAHLt/R
	MZCEixdoYrNh/pcA2wuGXQp09gIoeoLeK5gPtop7fABUvjpmeQfVBOQHeWM8xQ7FJidUAhdN1Lx
	d0sk=
X-Google-Smtp-Source: AGHT+IGS6aL9XD5X1p3cF17cXzZlqYIV9SimkvM6/DY29FPG7JvJGWB6ILxKTV26dH71FIhNPXlijA==
X-Received: by 2002:a05:600c:3b0d:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-4311df56e7bmr106900825e9.25.1728919488976;
        Mon, 14 Oct 2024 08:24:48 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm11629911f8f.37.2024.10.14.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:48 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH 5/6] can: netlink: extend stats to the error types (ack, CRC, form, ...)
Date: Mon, 14 Oct 2024 17:24:20 +0200
Message-ID: <20241014152431.2045377-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CAN bus protocol specifies 5 CAN error types:

- Bit Error [Transmitter]
- Bit Stuffing Error [Receiver]
- Form Error [Receiver]
- ACK Error (Acknowledgment) [Transmitter]
- CRC Error (Cyclic Redundancy Check) [Receiver]

The patch also adds the corresponding counters to the statistics. Since
each device/driver can determine which of these errors has occurred, why
not export this information along with the more general counters?

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 include/uapi/linux/can/netlink.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 02ec32d69474..8b33549e7e19 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -114,6 +114,12 @@ struct can_device_stats {
 	__u32 bus_off;		/* Changes to bus off state */
 	__u32 arbitration_lost; /* Arbitration lost errors */
 	__u32 restarts;		/* CAN controller re-starts */
+	__u32 bit_error;        /* Bit error */
+	__u32 stuff_error;      /* Bit stuffing error */
+	__u32 form_error;       /* form error */
+	__u32 ack_error;        /* ack error */
+	__u32 crc_error;        /* CRC error */
+	__u32 pad;
 };
 
 /*
-- 
2.43.0


