Return-Path: <linux-can+bounces-4010-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D001B0B6AB
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C2C178ED2
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34001FF7D7;
	Sun, 20 Jul 2025 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTt3eZp0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378641F1317;
	Sun, 20 Jul 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025107; cv=none; b=kzT0ywcaRTVTrE5pFk11vC3camyvZ7ey1odD/IuVqKstcnTijipSR9HAPmS4imSFEoCXobfq4R/nrwtjfc9b9/5r4A0UVDYLQe33mi6R3yWOc+7nvh8DD69UmgCiUZ08BRfKmTu3afJqRNYtqg7LzitpQ8kU19LrKMI9UlW1Hpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025107; c=relaxed/simple;
	bh=DDG0zKPS7pQTNAPmxx2Fca7xNj6DB5VTns1/kKpKWpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZXO/5nLhX6CSUDAW8w2teCueAKPM9DlHSAXpHXftmqqxrK2AntshvPJsFpHDLqB86fCyobK7L4cR0jMu7IwWLAv0Zv7exl5dW5+yJC5KpdjJ5a1At17kCG38RCj9dy18Ol85mZE5lg2pW6T/BSzBjqsWag2ppgF9du0XltsCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTt3eZp0; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-884f22f9c90so1743320241.0;
        Sun, 20 Jul 2025 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753025105; x=1753629905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlwld6FdGzx+gNpdq9uPUdbnoNu6WgBQ31n27jU5G6E=;
        b=KTt3eZp0nCwMIIjYWxmIrbiINoKZX+OgUw2hJEIH99KilkyHDzjlSGUlfpQAb5kq4m
         d4MBJPI5y8BbrV/C44HUCcFq6IMAFd3/0Ze5l9cCoXAJmrz1HA3SY6ZH2k6lrxfLcGDE
         oMY5/vkwJb59LPQO9mpSb1YAGmYpz6GCFXKkEvnXRbBXbh6naOXuDXzTM5hU5gj5fIqF
         uCu1eBpBgP+cYSMY9Ut7trCHcIQR7KyfmcDmlo9NETW3VXtqNS42eY7CBLRorbev4idr
         hKX0+KyLHpOfRnZw1Y84PhxuthS0aI60Jw2MW5JUuutFpyMIUg5hXRMBzOH1vz7p9Nso
         VQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753025105; x=1753629905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlwld6FdGzx+gNpdq9uPUdbnoNu6WgBQ31n27jU5G6E=;
        b=Qrn/RAweLv34U1EyEweegzYkoVMXfnXqxTudMR6OLe32nF/jQ1BllBaNo8vlgiDB5u
         TNgXSjgh8DY4ofDIRoj4/CPZK/8gfhF6Lle4keoq3iAZ7zV75F/HciJtA7sEEuEW+fW1
         oLIgT+D1N5rMU14NtySs2hb53T4HpOHR9wpdfUvtiZz36HmQei4AUOCUZUx8LRJtZYod
         EXicyoZ6X1GS7pKmhEQNipxXijMepKmSIj3puqkp4NUoXJk+FAmmntuydeEAXxtx9qPS
         Azq39HmHcUMJwK7dRAPJntp76nLe3b/L5wovmtORMqCigTzyL8QdSvwBDVFZTTaCqMdU
         aRmw==
X-Forwarded-Encrypted: i=1; AJvYcCVFBHrAHnRPpG+zHIwRtKXW0+MJJZC9F0cpcU9gBEvPI6/PPGNJ2g3AgqTfI65k6QNShwK1Xy2UV4M=@vger.kernel.org, AJvYcCXw/s7wpgHpwKGpENl9wVSIGKcvv1Zji3VRuflmK2AgIMc+Iqng86O8zBYWsmqWoUNS5rJ60SmGaCBpraDH@vger.kernel.org
X-Gm-Message-State: AOJu0YzOSOvD/qWhvezzvAFBWZxlex2mxkeHdkkVKis2Urvg+OB21fhK
	y/I0XSoFDy/lY0/+mhCw8OLJL2GTPqAI5+Xu7w/8qzwq+3cHbjFsobY5
X-Gm-Gg: ASbGncunCHu5FOkqhYIJiisjtH+qukPjKo7t8DEEZWM+SLuXL3ba01vaQ9e++3fK7en
	wHEhg2Y/s9x9y1FZPQJiobzfTGdMhvHzOqqJmla+RGiU1626sUHF4wYxX/w573jW/EvS+YzSQnD
	LdBZigDh1FAFi6qCSoqKPJMzQPAk5ZJpI6BXp0QBZjmdIBZ414JIC3QKtV6ytKaSh976ykq+8DH
	3+dVq/pIp/af6lubwHfPXawqJ6+ihAS0BEZ3dbxsyC0yh6fbqkxdkREYnd6vky0Vfl86er7qxJs
	ppOOxMJcearGVozXymaltI2opvjQq0M9e5UPKoRdU1nNueP5/mZ4ElSrBXXndjYWTE4tmiZNPWF
	xGMkwoTUNStGbAUh9BgsOF/wdqAlN88+kcJGJKD6dST1R1Uxdn/z4k3NDFePFUOncq1/lFaXYXw
	s/IyxeuQ==
X-Google-Smtp-Source: AGHT+IG92NRkx8ltYfrcXZ5eevHEHXa70/Jp/PIid1of657KfjI7EX1GOTtiKanjN1S6eknrX4Nt5w==
X-Received: by 2002:a05:6122:1acc:b0:530:7ab8:49ab with SMTP id 71dfb90a1353d-5373fa6909amr7613401e0c.0.1753025104945;
        Sun, 20 Jul 2025 08:25:04 -0700 (PDT)
Received: from 9950X.localdomain (syn-142-197-132-170.res.spectrum.com. [142.197.132.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53764eedd3bsm2157582e0c.5.2025.07.20.08.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:25:03 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-i3c@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Subject: [PATCH v2 1/1] docs: Fix kernel-doc indentation errors
Date: Sun, 20 Jul 2025 11:24:01 -0400
Message-ID: <20250720152401.70720-2-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250720152401.70720-1-luis.hernandez093@gmail.com>
References: <20250720152401.70720-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc issues that reported Unexpected indentation errors
durring documentation build (make htmldocs) in CAN, I3C and GPU drivers.

Convert formatting to proper ReST list syntax to resolve warning.

Changes since v1:
- Convert return value descriptions to proper ReST format
- Fix code block introduction with :: syntax  
- Add GPU driver fixes
- Remove SCSI driver (already fixed)

Link: https://lore.kernel.org/all/20250703023511.82768-1-luis.hernandez093@gmail.com/

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c              | 16 ++++++++--------
 drivers/i3c/device.c                     | 13 ++++++++-----
 drivers/net/can/ctucanfd/ctucanfd_base.c | 12 +++++++-----
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index bbc7fecb6f4a..982a3476a988 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2430,7 +2430,7 @@ static const struct drm_gpuvm_ops lock_ops = {
  * remapped, and locks+prepares (drm_exec_prepare_object()) objects that
  * will be newly mapped.
  *
- * The expected usage is:
+ * The expected usage is::
  *
  *    vm_bind {
  *        struct drm_exec exec;
@@ -2464,14 +2464,14 @@ static const struct drm_gpuvm_ops lock_ops = {
  * op, because the later altered step will involve the same GEM object(s)
  * already seen in the earlier locking step.  For example:
  *
- * 1) An earlier driver DRIVER_OP_UNMAP op removes the need for a
- *    DRM_GPUVA_OP_REMAP/UNMAP step.  This is safe because we've already
- *    locked the GEM object in the earlier DRIVER_OP_UNMAP op.
+ * * An earlier driver DRIVER_OP_UNMAP op removes the need for a
+ *   DRM_GPUVA_OP_REMAP/UNMAP step.  This is safe because we've already
+ *   locked the GEM object in the earlier DRIVER_OP_UNMAP op.
  *
- * 2) An earlier DRIVER_OP_MAP op overlaps with a later DRIVER_OP_MAP/UNMAP
- *    op, introducing a DRM_GPUVA_OP_REMAP/UNMAP that wouldn't have been
- *    required without the earlier DRIVER_OP_MAP.  This is safe because we've
- *    already locked the GEM object in the earlier DRIVER_OP_MAP step.
+ * * An earlier DRIVER_OP_MAP op overlaps with a later DRIVER_OP_MAP/UNMAP
+ *   op, introducing a DRM_GPUVA_OP_REMAP/UNMAP that wouldn't have been
+ *   required without the earlier DRIVER_OP_MAP.  This is safe because we've
+ *   already locked the GEM object in the earlier DRIVER_OP_MAP step.
  *
  * Returns: 0 on success or a negative error codec
  */
diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index e80e48756914..48b49757a90b 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -26,11 +26,14 @@
  *
  * This function can sleep and thus cannot be called in atomic context.
  *
- * Return: 0 in case of success, a negative error core otherwise.
- *	   -EAGAIN: controller lost address arbitration. Target
- *		    (IBI, HJ or controller role request) win the bus. Client
- *		    driver needs to resend the 'xfers' some time later.
- *		    See I3C spec ver 1.1.1 09-Jun-2021. Section: 5.1.2.2.3.
+ * Return:
+ * * 0 in case of success
+ * * a negative error core otherwise.
+ * * -EAGAIN: controller lost address arbitration. Target
+ *   (IBI, HJ or controller role request) win the bus. Client
+ *   driver needs to resend the 'xfers' some time later.
+ *   See I3C spec ver 1.1.1 09-Jun-2021. Section: 5.1.2.2.3.
+ *
  */
 int i3c_device_do_priv_xfers(struct i3c_device *dev,
 			     struct i3c_priv_xfer *xfers,
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index bf6398772960..f910422188c3 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -506,11 +506,13 @@ static bool ctucan_is_txt_buf_writable(struct ctucan_priv *priv, u8 buf)
  * @buf:	TXT Buffer index to which frame is inserted (0-based)
  * @isfdf:	True - CAN FD Frame, False - CAN 2.0 Frame
  *
- * Return: True - Frame inserted successfully
- *	   False - Frame was not inserted due to one of:
- *			1. TXT Buffer is not writable (it is in wrong state)
- *			2. Invalid TXT buffer index
- *			3. Invalid frame length
+ * Return:
+ * * True - Frame inserted successfully
+ * * False - Frame was not inserted due to one of:
+ *
+ *   * TXT Buffer is not writable (it is in wrong state)
+ *   * Invalid TXT buffer index
+ *   * Invalid frame length
  */
 static bool ctucan_insert_frame(struct ctucan_priv *priv, const struct canfd_frame *cf, u8 buf,
 				bool isfdf)
-- 
2.43.0


