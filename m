Return-Path: <linux-can+bounces-3573-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C7AB6782
	for <lists+linux-can@lfdr.de>; Wed, 14 May 2025 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AC17A537E
	for <lists+linux-can@lfdr.de>; Wed, 14 May 2025 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4661FA14E;
	Wed, 14 May 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b="Gywlb/QM"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A234226CE1
	for <linux-can@vger.kernel.org>; Wed, 14 May 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215005; cv=none; b=hrEsrJ0JzIJDtxwL2e/0egrPycSa5GfvDx7r4CpDgLueuRHchGGo4Z/4PR+P70IIj3aBgEDCLryMhxump4cQM9R/6hX1YtWpboPBH/ijuR2x8iGjvn3tO8HO99Ot0MMPchGre8Qm8l7JdpoDJxnIL4FQI2iNGKhNbsl1JVtdfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215005; c=relaxed/simple;
	bh=c3b0pwEfm40EZzyPp8RHYuIe28p2JQNejYTAaYY2a94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUUqMEuF+hGgPj28OZCnthGWllMPGL0V7gO4ipJrbSPvXIFOeGmWzXPeKexu/gpjYc5Nfz7M1geRAjLiOQkCd5zQKdzeoBpA1XXI1XUbnnOm3zfqiFD7m0dHAxUMcxY8mJIwrAIv6Q7nVFvY5ywF6Z/f2NwVh3hzpaobqTuAZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com; spf=pass smtp.mailfrom=geotab.com; dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b=Gywlb/QM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geotab.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so18456955e9.3
        for <linux-can@vger.kernel.org>; Wed, 14 May 2025 02:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geotab.com; s=google; t=1747215001; x=1747819801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=miq3MggeBb+1NlMhNzyUbsh/U9kizBT72AjQsuG2tb0=;
        b=Gywlb/QMBx1s82fACuZyS3gs9gC5DntlWdIRlIkTUygO5WMoGRZNkH17c4+q3LoP4U
         9K/ZKDUQ8/LgNO4DaCzSbLEtqVGd8uCW+tALCc4BlDqvFdsWf9f1wAmgEIJWbgnrY6CI
         L4mnXPsvodpa5d1lJvrdzopPTO6rGdQdglN/oYB/xUwYxgl5FU5baGpPfj286tIkQ6pC
         KhLfURr1rrB2r4i+6/NjYOmf5Rtl4nOsG2GEbXleCKLCyWErDiok0jU6EoOkxfip0tIl
         XK2jHrrBIlKaAMVKOTjvqhdO7I0FdXXzAFWbG1AR1bLoYnVx8xKDQbDyCHMH2gbGiCxE
         VBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747215001; x=1747819801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miq3MggeBb+1NlMhNzyUbsh/U9kizBT72AjQsuG2tb0=;
        b=DeJgbh86fVPawrAuF/6MFyjWizOwbD7zRoffpGvTNG516yr0KaNacWLK8ktK/3xLxt
         XpNGteqOO+9Glk2+Y3w/2px/bqnQqP+HXv3iZWCBY4wjuyhbBJVTT24kHKpjzqvyUJXR
         D1KAyrHL/QnBaBIM0DmMI+ltTmLnbj0//KAUVxgw6uJzHqgAUS6mGT2rDud/D3e+D7Lt
         71hMFk59qGL4HrKgjeDLh776L5L2kbBjVShTzflpnu5KspzsdkFd6uXYqZkDxUefiq2T
         HYiIiGCjC6T7+oI5mUdmza7LLNB3Vls7mmAIr3ne5j0C3jXeXcWo5lSNgB/5SU43n5AV
         O3ng==
X-Forwarded-Encrypted: i=1; AJvYcCUTSSrsI+Gq+oKzGrfSHVvsNqfLnZKoU9dBH05zvQojHTC8PJ3pIFS90pyrfIe4/NYI06vvziurAeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOcm1QYRrJsFCHH8ijGJ7aNtfGRdqcKRXkAlIYce6YHc6IkOWl
	xV1txLj6iZusqPJRw361OjNFv07g2bgQjlrpTMD2ZHsBQVikdmDPl7irVQYCvNg=
X-Gm-Gg: ASbGncuhN2VjBlsQDOZeSHVID/hYCfqJX8tRysVHh2M676MNnPlgYgHteA3mIIMKPyC
	dw2fmKnHhzSokEpZ3ffkZHhpaNj04mSWOPjJozfpg6+Wi2lCvDlsBredgPf6OTkNZXFVjpEQD/f
	jEgWNhMr8TF+Fc7+stUWznF6Tq3NtEtCkrWGBtjg2XmG4ltdK0Tl1nJIi2veyPGu1u4Yzs0a+1R
	LtIbU4kiB24CvdCrqIvRgOjAPet/Itw6dQosWrcHLO0Owzx+1cPBuXz85iTCo7kvEsaDUtQ0ziF
	p4se7KBhypfnPOUlyJHC7dRZP/fHiCLOygTyUKRkM6tEXIz7IhWM86uF6djkOvkt29/y90KXzGv
	bm3uYwzXax02gIwqBUpFg7vPg4Udf4P6gJg==
X-Google-Smtp-Source: AGHT+IEekbAK+FW6OyrRAHHVB7L8BSMYsxsHMwKpCXDUp20v3e5s/4PpHP2VOV32m50fFKBdCJSwyw==
X-Received: by 2002:a05:600d:4:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-442f286456emr19115205e9.5.1747215000621;
        Wed, 14 May 2025 02:30:00 -0700 (PDT)
Received: from localhost.localdomain (11.red-83-33-67.dynamicip.rima-tde.net. [83.33.67.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39792c3sm21824365e9.35.2025.05.14.02.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 02:30:00 -0700 (PDT)
From: Carlos Sanchez <carlossanchez@geotab.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-can@vger.kernel.org,
	Carlos Sanchez <carlossanchez@geotab.com>
Subject: [PATCH v2] can: slcan: allow reception of short error messages
Date: Wed, 14 May 2025 11:29:57 +0200
Message-ID: <20250514092957.1068570-1-carlossanchez@geotab.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows slcan to receive short messages (typically errors) from the serial
interface.

When error support was added to slcan protocol in
b32ff4668544e1333b694fcc7812b2d7397b4d6a ("can: slcan: extend the protocol
with error info") the minimum valid message size changed from 5 (minimum
standard can frame tIII0) to 3 ("e1a" is a valid protocol message, it is
one of the examples given in the comments for slcan_bump_err() ), but the
check for minimum message length prodicating all decoding was not adjusted.
This makes short error messages discarded and error frames not being
generated.

This patch changes the minimum length to the new minimum (3 characters,
excluding terminator, is now a valid message).

Signed-off-by: Carlos Sanchez <carlossanchez@geotab.com>
Fixes: b32ff4668544 ("can: slcan: extend the protocol with error info")

---

 drivers/net/can/slcan/slcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 24c6622d36bd..d889f6a43e29 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -457,7 +457,7 @@ static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
 		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    sl->rcount > 4)
+		    sl->rcount >= 3)
 			slcan_bump(sl);
 
 		sl->rcount = 0;
-- 
2.49.0


