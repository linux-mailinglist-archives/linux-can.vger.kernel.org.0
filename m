Return-Path: <linux-can+bounces-2423-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298399F44B6
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 08:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD76F188E5A2
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315418453E;
	Tue, 17 Dec 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJKYjgbo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A2175D53
	for <linux-can@vger.kernel.org>; Tue, 17 Dec 2024 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418633; cv=none; b=ieFT2dV63y4JRFVqUdEZzFsbJ6DZU5Su28H6nERfG/pZfrVl0MsRFkq2fw3dnoPwtDsYKiKuLlaMsesblBk+vjwbvCst0e3F1bW+9ZBsp4KZ2acuWCSybiCz2DqKmvjCWFzdIsZGR/00ixQqoLpN/r4rwBUOJiGgtZqFsCRMCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418633; c=relaxed/simple;
	bh=RX53xHF222nphqhCgIoF+v01DqL/srRcdMbnXtTl6h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hDQ4bFqwrYEbt8LPf35bkUCYJnAuFfpGduQG0MdK+fxZ4Tfs2vz7BhY6vddhU/DOD5XSN6A24ABYiOHHUXRLvLvG83H62nWVMPitKTBa3gezwS8rdbgWMqHvYAon/oRiiCD0qIScQ+6fBteXx0SqEXB2djEbOPUhvzMjxyRWqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJKYjgbo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728eedfca37so5074816b3a.2
        for <linux-can@vger.kernel.org>; Mon, 16 Dec 2024 22:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734418631; x=1735023431; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJJXsew4Uj1ZR6sYg8UkXddKUYUSWF9Vm8vq9XTKnRg=;
        b=DJKYjgbosl6aBevw+TyVM6DCQaP5mbD/EYLjI8coMaAibQjI2sHUfDY2XqmKCQxSPW
         3RxTsSxQJPGL7qxRAdF7cHRaf9jKo9loEDVfDNGH1U8GQeGcFpv1ismIukoQKfYtuUtt
         G55PBWWygqcdHbXYrdy8nJNfJmwu0KMtvPavRh3bGZWL6SsLyF9+olHeKoZe3VOPHBex
         ZzGo02sdsxVRVpnewJsdGsJCD+s4nJtn20xKjV3+102XujQiqTC1XXLDeymm9pQeE//E
         1p+Y359pplv8oIxfXx2Axxj23CiqYRtyeEzTRXCFMWB7XtD/w66wJcgI+5qHX/bSiHG7
         wpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734418631; x=1735023431;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJJXsew4Uj1ZR6sYg8UkXddKUYUSWF9Vm8vq9XTKnRg=;
        b=mZbf/E6Y+eTjbPRFDnF6FHOKu6/Bq9IweZJBITUNR0nqTmMHhv1xebrW6YyV6lGQxf
         DaL5cXFxMD32JUShyV+sVl6z5an4TJ5BnYzEaSxJdIC7VsSeAM5xv4EocCIP6ACci00h
         Z94j10gQX41hunfQLxraPlgcwvnJBU3OEhFjkV1GtaO2ayvUDIsok+Wf7YFbHApbWp78
         SCQbKJqNubthvx42uo0zm06sqkgcedtBpxdkvH46PzRvvixeEkfd2RNrFWN8ZWSbFUr+
         A8DOt8bfXaDkEuIwhLqE6e8fc21BoQoU0r7k+wjMivoCi3luDFhRyzxPr3SFSMB1Zurx
         NdkA==
X-Gm-Message-State: AOJu0YwEXfZcj0l3aG8JiCgAVf6bN3OQkuESUaGRPbAK1J4EgOQTovVS
	VssvexCRhYdBJsYKlITUzX5ZcpkdknSUWaYfGs8pvqwqZacvxw7p
X-Gm-Gg: ASbGnctUDaj7aAM69a3yjvn5CzIc/0vnfA+g9ad4Q0Xq5o+JQAYhsHoQwduD0cQIDOg
	9VSCsTTfJYfvQ+Ietw6MsQUMvChCfBlwvqA0Us7OOamg546lIXm360MsziYVG2A7PnRy9xAXloB
	T0TfesInASUbJScZTB2vsCLPW7iQKUH1HL2qTUHvDmXKJcPp+wKhNpNO88NqhzaLkt4249hIMIq
	RnLwI2F24qi+UB33frzvBgNa65EaeNqrrPbr09EyVgmXVETkJ9SyM/1rLrWkA==
X-Google-Smtp-Source: AGHT+IHRlmpghXcNUgl3SZrBD8gEUDYtRppxs7xY0rC4/sMWC9EksCE4S+8aJz/aTbZvF2FhsvEgZQ==
X-Received: by 2002:a05:6a00:2ea8:b0:725:df1a:27c with SMTP id d2e1a72fcca58-7290c197dc1mr22070396b3a.14.1734418630730;
        Mon, 16 Dec 2024 22:57:10 -0800 (PST)
Received: from [192.168.122.73] ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad567csm5893339b3a.71.2024.12.16.22.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:57:10 -0800 (PST)
From: Renjaya Raga Zenta <ragazenta@gmail.com>
Date: Tue, 17 Dec 2024 13:56:56 +0700
Subject: [PATCH] can: m_can: m_can_dev_setup(): set CCCR_INIT bit earlier
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-m_can_fix-v1-1-c043927f6374@gmail.com>
X-B4-Tracking: v=1; b=H4sIALcgYWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Nz3dz45MS8+LTMCt3ENDMDA1PTFPNkSzMloPqColSgMNis6NjaWgD
 PNQ14WwAAAA==
X-Change-ID: 20241217-m_can_fix-af60055d7c96
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 =?utf-8?q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: linux-can@vger.kernel.org, Renjaya Raga Zenta <ragazenta@gmail.com>
X-Mailer: b4 0.14.2

When OS reboot, device is still in normal mode. Probing
will fail with this error message:

  refusing to configure device when in normal mode
  (unnamed net_device) (uninitialized): failed to enable configuration mode
  Failed registering m_can device -EBUSY

The log can be traced, it's from:
  m_can_dev_setup
    -> m_can_niso_supported
      -> m_can_config_enable
        -> m_can_cccr_update_bits

In commit cd5a46ce6fa6 ("can: m_can: don't enable transceiver when
probing"), m_can_niso_supported() was reworked to call
m_can_config_enable(). However, in m_can_config_enable(), it's noted
that CCCR_INIT must be set in order to set CCCR_CCE. The CCCR_INIT
bit is set later in m_can_dev_setup().

To fix the problem, move forcing standby mode (set CCCR_INIT) lines
before m_can_niso_supported() line in m_can_dev_setup().

Fixes: cd5a46ce6fa6 ("can: m_can: don't enable transceiver when probing")
Signed-off-by: Renjaya Raga Zenta <ragazenta@gmail.com>
---
Link: https://lore.kernel.org/linux-can/20241106123700.119074-1-renjaya.zenta@formulatrix.com
---
 drivers/net/can/m_can/m_can.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 533bcb77c9f934e5840b076ded948f8256ad2ad0..9345b181c5e31e1507a4dadc31e5f15545e1dc98 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1685,7 +1685,7 @@ static int m_can_niso_supported(struct m_can_classdev *cdev)
 static int m_can_dev_setup(struct m_can_classdev *cdev)
 {
 	struct net_device *dev = cdev->net;
-	int m_can_version, err, niso;
+	int m_can_version, err, ret, niso;
 
 	m_can_version = m_can_check_core_release(cdev);
 	/* return if unsupported version */
@@ -1710,6 +1710,12 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		CAN_CTRLMODE_FD |
 		CAN_CTRLMODE_ONE_SHOT;
 
+	/* Forcing standby mode should be redundant, as the chip should be in
+	 * standby after a reset. Write the INIT bit anyways, should the chip
+	 * be configured by previous stage.
+	 */
+	ret = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
+
 	/* Set properties depending on M_CAN version */
 	switch (cdev->version) {
 	case 30:
@@ -1746,11 +1752,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
-	/* Forcing standby mode should be redundant, as the chip should be in
-	 * standby after a reset. Write the INIT bit anyways, should the chip
-	 * be configured by previous stage.
-	 */
-	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
+	return ret;
 }
 
 static void m_can_stop(struct net_device *dev)

---
base-commit: c7d876495ffad298d7f5fa252000c80fd4fd1b74
change-id: 20241217-m_can_fix-af60055d7c96

Best regards,
-- 
Renjaya Raga Zenta <ragazenta@gmail.com>


