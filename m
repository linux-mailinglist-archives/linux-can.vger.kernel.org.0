Return-Path: <linux-can+bounces-1838-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F249B4896
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 12:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE0B283BC9
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA7E206948;
	Tue, 29 Oct 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S10ms+dy"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD120605A
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202400; cv=none; b=OqCg16QR2xGlPmfoloJEib9heEB7XOG3UGy7hsbJEkdqB0NcNqIFk0Xu3VnETMqXnVNLafkF4Uv/BBEDiMH7gsnUz5GEExvts3qhGVTLKQI9TVoSC9Om3K+Lox5yjuGEQQ75Vgu6YcVZMw5HFZXu7Z6HE2Tm5kZLK8zaJXMlUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202400; c=relaxed/simple;
	bh=0/yE3dp//A3vvjwYzpCckP/0syues54g/5VxcsiMRZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jErZ3WTg26uzuLA/Z0LE5nk/d+sW3l28zpNO2Q8yRqHSRnDbJ9kCnZ3/s/KN3CXIOnoSXbiMWRpRC56pbcuBLhXCIufzO99bDKdDt6zORkeJFQfEVlFbpuDIdMSDZCMCZFPqdSx5ANJitLitY6RJXmnhaQCZpYop4OW6tugZQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=S10ms+dy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso6264881a12.3
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202396; x=1730807196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TS+cafYkOpOnfMipNar/zvOqT/SxcL5voxlp49ONDY=;
        b=S10ms+dybXzQjDLbQzaSTHjffxynuYrJ1SVOBo4acZY7YD9VdBzpr6M7Hrr9tXbdZ9
         5rDbcKR+JiUYGaQ5M4Ho8V03OgCTB9dFCnVyNpZavrDc49dZ3U5o+3zQ0ycbpvzsNGL1
         WwV1U6cG3mCD8i3Ro9gMJxTOzkNzWAKLFBpRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202396; x=1730807196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TS+cafYkOpOnfMipNar/zvOqT/SxcL5voxlp49ONDY=;
        b=ot0FhHCBhxtvToYpXZFeUyydlMcnB0fgGePNu+ynaaoJ5fNrPbDlEe+lAI6ghai1ZF
         O1xuyCDNuOfSZNc3gawCyVD3WdP+UuGodv9mqBNF0X/5Inn3HrLN+4UQh7dfoQ3fbLkj
         g8s8Zas8AZkBYbmRByvgraP9MO3ibSaYLS7XmoD/Y9tPGgUmkObKZEazpnhLHSz4AYo4
         olrQfNtmJZk2dduVg2ynLGTXhGlKIheRoVVFFSuwcnAsMBtCxpMcRdk8vmYpKLWpeVgS
         GR9Qq3PJbJGFat7xHfJ+XWqzWuDZGjULm+o2rfy4Kb4YwqcantMBldQCK6wTp0vQYW8Q
         6wNA==
X-Forwarded-Encrypted: i=1; AJvYcCW7l9uo22gkgDtn/KkON3M6iDejo0idbZ8J9ZLmUoMiBjrWwdl9D00leMHOMCWCV74hp2dCx2fbfFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdZx0P9yayeXeD1kzJ2Oj/6hR4X4Lf++w0GuhNdkH07s8Sd7+
	m83Mwpx9nigzZ+sWUypDFgGfBtfPh179NEe8BVnMmeUT8ad6cuIzu30ARq42o2o=
X-Google-Smtp-Source: AGHT+IGbgYFdBMldwJvh1QAYxgQq9RkNF80spFGp6jjZj5BcQ03m7jmdDQTRfwoDsuQjcF+Mv6prMw==
X-Received: by 2002:a17:906:4fcc:b0:a9a:3dc0:8911 with SMTP id a640c23a62f3a-a9de5ce1801mr1152393966b.16.1730202396546;
        Tue, 29 Oct 2024 04:46:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:35 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH v3 5/6] can: netlink: extend stats to the error types (ack, CRC, form, ...)
Date: Tue, 29 Oct 2024 12:45:29 +0100
Message-ID: <20241029114622.2989827-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
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


