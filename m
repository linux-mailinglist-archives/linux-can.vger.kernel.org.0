Return-Path: <linux-can+bounces-1829-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB939B44CF
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 09:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D63B22785
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF2203712;
	Tue, 29 Oct 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UDgIeVLR"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5E204016
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191665; cv=none; b=GVaUAG4NRmjt5IYvOiPu34maH9iGTZ6VJwufzjlf44ou8GzI3pdZpYdyTYYsgMtbJu7eN9fkCjt+0yhpNx7SjYG1sbxePCD7FkRrz3IWwPZ9aCQ+7MTjrY8RPX/B3qZ4m8vhYvjrtqlIvIkrC5hA95Kn2PflBkafnX2jgiWhEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191665; c=relaxed/simple;
	bh=0/yE3dp//A3vvjwYzpCckP/0syues54g/5VxcsiMRZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzT5ztU72273Qtqx3CAGvzqMAUv5rbBcUsc3SNVPj13ci+Pe/Phze2+t4k6VVVSd+5pr+Mm+xFF+5sJiwiJWAg9hvC7iYtTl9ACJGkHMqdRf0huVCGLRxGsUaanRhNupolUCd/GDOpRtSZw70iJflCsJqeIHu0ulNaRFqeyMMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=UDgIeVLR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso626678566b.3
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191661; x=1730796461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TS+cafYkOpOnfMipNar/zvOqT/SxcL5voxlp49ONDY=;
        b=UDgIeVLRbOC+lB3ia62UHNUyrq/bbpmZNHBmzjjeKtbauf7MGHZP8D6Woooedw4M1F
         7R2r/neF02KDZeRCOkfZOUw307yc9R4H05563Pjhv0LgwIUQ5/l/7TPLu+v5veBYKc2D
         xQkHjEFooMeVXoDfF96nm/uzKIWi/GeprXQuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191661; x=1730796461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TS+cafYkOpOnfMipNar/zvOqT/SxcL5voxlp49ONDY=;
        b=vG9bgT9cOMIQwm82MrANwshDhtaDY+G7p2Nh/9gAzl1NHAY2mLTxKQ2GAiApco3Eta
         lxgtQtd2AS/joJownpAWwlqx6yMQ11TlFnPqMcZ0LnHyjksDh+gOLWuPZ4G+mdlNBBXW
         /0Mg6k2IHOvyAuc0JRNqn3tM5z8D8gvhHheZGVy/j46xdIhYf+6sVgTHc58ewLcoHHmm
         fmcJseWAJlFI3OH5E79tMvziEod7ZTsBKaGN6fc2Vzc4sahSfgBcIQ1ghLZsokeBfYXA
         WfvNWCyxfMXxFR+uL+Tdsaqoj5EctbuESkePkESkRAgSqdXCQmB2vHsNB18POuFSflWn
         1xgA==
X-Forwarded-Encrypted: i=1; AJvYcCVyOYkUNHdi1XCEUd4VRYkHpCeEV8NYvkSVeMSfsW7LFoAPcqDnrtk1HyTA4ua5qFslO8dDugbqdoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiddyz2GmTl+188ZIwtmvRcDuT7/w755VtrQHvmKrcldlvIm7N
	FWuXrLa1N60tx2fUYHmzdbciCKYOaq9VbiG3XKHeLAjTOn1N4xKNl7nfBzf+7b8=
X-Google-Smtp-Source: AGHT+IFlFy6cV23OcJR59XR+k/d+6Xp/zuWcoV0vl/JZJVcGxqcHVKHCvKp8HW/M72Amgo2/fFieFw==
X-Received: by 2002:a17:907:9604:b0:a99:f4be:7a6a with SMTP id a640c23a62f3a-a9de61ce626mr916455666b.47.1730191661380;
        Tue, 29 Oct 2024 01:47:41 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:47:41 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH v2 5/6] can: netlink: extend stats to the error types (ack, CRC, form, ...)
Date: Tue, 29 Oct 2024 09:44:49 +0100
Message-ID: <20241029084525.2858224-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
References: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

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


