Return-Path: <linux-can+bounces-3726-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECE4AC72EF
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 23:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E24167726
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 21:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456407260B;
	Wed, 28 May 2025 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2d7KO5Qq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762B1DFFC
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468945; cv=none; b=RuwYo0BkFFkqtKNwag8z3cpHdFSNu350f/dfTAWWiSDbjt0HMZKG17VXR6Qvb/iKQK6v5c9LCNsitnD60YormQr9iXxMcoJA4EsOkKKBUdcxhcdbbJJqeoK5NieR4eaYVTEuusNcOKmTfv1bK3el20yUY5uClHrbB1IyoVAYYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468945; c=relaxed/simple;
	bh=WzIhrK4lePTloAUriVs7Iu+tMm2q6ubVTo2I4j3tBDk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kSqoUA0ZeS0jWN5rKKoH0DlXZstXCuGdKeE0dKJElNfOncwgCxAElxq3I1D5BElIStduILtwNwnkOC0F++NydymTVyI82YzwWpHaCOrPFBoAXqJjXZpdEq1TeUpnSEZCqavDDx3c54EOXdobcy/l/i0IeQ8VCxESo/t2SA6NJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2d7KO5Qq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60462000956so501058a12.0
        for <linux-can@vger.kernel.org>; Wed, 28 May 2025 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748468941; x=1749073741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sduuEGeJc+q/d1A9cPfnfncUqOh7lV8CDfEwN7ssMQo=;
        b=2d7KO5QqkMg6M6uGqj+BS5KfWgJnhjIBdUc/QMnIm2Q0mtIW/Vk7aDIWy7z9JDUYjW
         ajHcMG72PBJJ0C/CHKl4eTv1GvN48W7LHTM2aNbZB0GE2ZfEKNfphNyActtWl60QdEc+
         2r+d9LFQrvxGsRHJvriyABdp7r15nS4kTr/DUsiAWyBtzXsLpsjC/XU/2+qv1x42yRJf
         8mIhYD6wTHQ6Y2ExeaKP+FMX+mGAzRMMO1H+XHozjyiP1OoNcJ5GrF8DotppvVR6vXZ9
         11ElR5UcKpyr5k2tBlyKje6kgKlMHaazr0r1JjJUXs2NoaA8ijStUdHz2wkWwSP8kAZb
         pOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748468941; x=1749073741;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sduuEGeJc+q/d1A9cPfnfncUqOh7lV8CDfEwN7ssMQo=;
        b=lKyRqap4DaZedoLZZOEN2wV4WFH095wNOKNNf0zTTrDjAqhbgB124wEz4I5Bmfa3vn
         9/XNF2/CdPF05dDEFxh76A/hDk8Lr95h1IpTLTfAyZXK7hTVSb9rtRpcB/suK3pUEkAn
         Zly7fDt+Iaz8E+fb7BoZRQTMn2aitp2GlSJK50Lz49jWMCYksNucn173vllZqWWVPlVq
         O+7bYxDjkhm054jBzza9mPDIKvJGT2B2k7j+HvJ5d53VoAXEIOH4N8tUI0+duQ0b25cA
         1KFvWaQVq9ey7b9nDnMhtEQgxDgaH+RxyiBT0sGY7PMwEQsjkCdFLJiDfzy/tmJtOi8Z
         P67g==
X-Gm-Message-State: AOJu0YxwkxqEGKSegZlHNHqvA2WHpAy6Nxp6n7vWPYPRDSAHbDeQDtHg
	Q+IHnax3lBGa3Ilf+U9IU3o6AHZ3OOOLGx1LYVun/ARfUPhImnG5efEYwek7fiTVK58=
X-Gm-Gg: ASbGncsiv0esHKJ+ajV/AqNagrFDVgXTs4IARYkcmtJGPBO1b7tEAWFYGwH1h20Lzcg
	kXONLxceMIN1FMZKHlQGfxrhOu6OsfRVYpXaQk+NADWBwd5JB6MLWjZjElHUr3L2UMJcdzXG3rg
	qafHwJUAOt8Q4u2fsT+7t6rA2anLpy6RSLplGxQTSUu/vz1Vi+QZivfdizvqCjEX1eVog5iHNMW
	bBi6aFkyn60AiZ2/4m6eFqodNH5zluCUpzA5g36FIOtQWa6rfcXBN+3lu+Y3riILo3WZ8ooTsWs
	YUxbrdQUdKtGtOmME770vWkhA8Y2bVojQATipDgRB8zKuSmwYJCPgCxBl1coDtvvJvizrfgD/W2
	Y57kZi/kXwEK9wYlH1tI0IUFyupMv
X-Google-Smtp-Source: AGHT+IHhV4rMXex/WULF6KFjb4wKQpPKmeAIukAhIPQAeDaGBpuddL+KDOuzpOtIeH4mwv8B4An1ZA==
X-Received: by 2002:a17:906:dc8a:b0:ad2:2a5d:b1a2 with SMTP id a640c23a62f3a-ad85b329a87mr1867571966b.57.1748468941442;
        Wed, 28 May 2025 14:49:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6aba8sm6347466b.167.2025.05.28.14.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 14:49:01 -0700 (PDT)
Date: Wed, 28 May 2025 14:48:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: socketcan@hartkopp.net, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org
Subject: Fw: [Bug 220170] New: flexcan-core.c overflow when writing TDCOFF
Message-ID: <20250528144856.25236d0a@hermes.local>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Wed, 28 May 2025 15:30:12 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220170] New: flexcan-core.c overflow when writing TDCOFF


https://bugzilla.kernel.org/show_bug.cgi?id=220170

            Bug ID: 220170
           Summary: flexcan-core.c overflow when writing TDCOFF
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: robbinvandamme@gmail.com
        Regression: No

When we run:

ip link set can0 up type can tq 100 prop-seg 41 phase-seg1 2 phase-seg2 6 sjw 2
dtq 50 dprop-seg 7 dphase-seg1 8 dphase-seg2 4 dsjw 2 restart-ms 1000
berr-reporting on fd on 
--> FLEXCAN_FDCTRL_TCOFF = 32 but gets cut off in the bitfield to 0 because the  
bitfield is only 5 bits wide.

FLEXCAN_FDCTRL_TDCOFF is 5bits.
#define FLEXCAN_FDCTRL_TDCOFF           GENMASK(12, 8)


logs:
[   96.263214] flexcan 425b0000.can can0: writing ctrl=0x034d0050
[   96.263235] flexcan 425b0000.can can0: writing cbt=0x8061a025
[   96.263241] flexcan 425b0000.can can0: Data brp=2 and brp=4 don't match,
this may result in a phase error. Consider using different bitrate and/or data
bitrate.
[   96.263248] flexcan 425b0000.can can0: writing fdcbt=0x00111ce3
[   96.263253] flexcan 425b0000.can can0: writing ctrl2=0x00631000
[   96.263257] flexcan 425b0000.can can0: writing fdctrl=0x801b8000

(0x801b8000 1000000000011011100 00000 00000000)

[   96.263263] flexcan 425b0000.can can0: flexcan_set_bittiming_cbt:
mcr=0x5980000f ctrl=0x034d0050 ctrl2=0x00631000 fdctrl=0x801b8000
cbt=0x8061a025 fdcbt=0x00111ce3
[   96.263271] flexcan 425b0000.can can0: flexcan_chip_start: writing
mcr=0x59a30a0d
[   96.263276] flexcan 425b0000.can can0: flexcan_chip_start: writing
ctrl=0x034d0050
[   96.263281] flexcan 425b0000.can can0: flexcan_chip_start: writing
fdctrl=0x801b8000
[   96.263302] flexcan 425b0000.can can0: flexcan_chip_start: reading
mcr=0x40a30a0d ctrl=0x034d0050


Since its 5bits, we are indeed less flexibel regarding setting the parameters.
But i think there should be some checks on the input values instead of
accepting these resulting in a 
FLEXCAN_FDCTRL_TDCOFF of 0.

Kind regards,

Robbin

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

