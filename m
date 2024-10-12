Return-Path: <linux-can+bounces-1639-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0099B705
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 22:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF152829B2
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4013D893;
	Sat, 12 Oct 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne+6MLbD"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2C8003F
	for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765754; cv=none; b=CpdfB6OoXTklunG8JIfDtLgPoCWKrrOp6SrpqpCV7UE/hbaSun6KeAq4n6R4D/+/xjfiVOYUAU189LGhW4iPgR5covOHtkqtHaNVx2aTD0OMmnIBXBbQM1DBidlejv2d6kySwTZHB0HYGkA4e2b8gA7zjjyz75R0vW/ULr76OLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765754; c=relaxed/simple;
	bh=gk5uRpCX+OJ4ViO1QUVcOtGxV3Nuv+2inaRjK0wc/Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lvq6LJhQY870pmXUSjSkShj4XU1+gd/vn0EkLz7T4yaR+O0NJdHKDaoqR88MZsFfokhHYKMZ8w2afnpx1mGPLdDtdnLPVA768MK8eOkHYpZUon+RFoQz1XMifV9byQGBMz2e/bRSn4BST1NVVntEyUNeDpyhHH/I2AR0nqnKIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne+6MLbD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99c0c203f0so247449466b.2
        for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728765751; x=1729370551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YHVyca9JcEqzFQrhvbsqP278Twf4oXcu0N/+z464KY=;
        b=ne+6MLbDYwfkn6k6NtCMXZlMnwncGvD9fMWIryfVsuZYGPd8+3yY7N+WIt4+yeHmbR
         JmCxY/TsmgCo17E7pWF4lBdqFYM9QMCA2zmdmu48xrDtO6BTTgywi0OkSzB9agS3te4b
         Qra8jlyhlq58rg6YU05QEyzXuB+L8vJKQ8CAgzoTxGUkzv7ZK0tpePD3XJHt3Pl+USnR
         YqrR93n5RIAvkl6op4ew9W4mP7KWA3g1vpqD/Y9A8P/8lvM6laKrvXk51bKpdfv60bBA
         shPVV27zj+qR/N9DmK6KBqGIm7W/NqbpwxpemWcSlOsbR1VTKD0sVv8X5sytsyjL+X88
         XxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728765751; x=1729370551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YHVyca9JcEqzFQrhvbsqP278Twf4oXcu0N/+z464KY=;
        b=eUnfSb9UKztW/90r1yoPv7JPkkdR+4mwk9FalVlofkJ58V5Rqpi+JiPHspSx9xorCZ
         Ed1763nY7VrkYTPJsfeARrRROkeLo4dBEFeI2aHU0dWzQ+lEZP8I5Kd2M1Qh2RHRb7N1
         lPYA6cPH5+Mntyd2O9Oaor4hh9xIrxa6rgVCYpGn93/nOjuFV7l1ZeujbLZeylV+wB+y
         d8A4Ysg1tlE/29ZsIekrAljLTrDbIBfc/QLu52A5ut3LhHncd2aFmsQoOtX4KFR2O1Dx
         rSo8gNyPExQLvi0soi4rpE706mpddBMXr9pPNkYAcgN+g7jUIF8eXdd9AeNxHeKGSWKR
         YiSg==
X-Forwarded-Encrypted: i=1; AJvYcCWXUe5qoYJMqeeYN3ZM4nCWlppEAGKba/uPrnj6woQmZEzQyza038IiVxlrBjC9UdalZ7j7/n2yvdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9f7QB5v0jDPY+oAxZNMQDW4DZW1SbllDNWDAMEGrJxvmnYwYP
	eIb/XxT+B9+8xAjHG9V7B8Cp5PFy+H2hIzEUwryv9YgfpBdaxF9A
X-Google-Smtp-Source: AGHT+IHAz5GFdNg6kicOJ7YnAG10UzLQr4/sf5SeYxyrC+pXsYK5CifHqMp2mlFg7R0Syu5nN5dxqA==
X-Received: by 2002:a17:907:e6cc:b0:a86:94e2:2a47 with SMTP id a640c23a62f3a-a99e3b5a86dmr318285166b.15.1728765750404;
        Sat, 12 Oct 2024 13:42:30 -0700 (PDT)
Received: from localhost.localdomain (ip-037-201-007-048.um10.pools.vodafone-ip.de. [37.201.7.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99fff5457asm13167866b.190.2024.10.12.13.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:42:30 -0700 (PDT)
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
To: mailhol.vincent@wanadoo.fr
Cc: ak.alexander.kozhinov@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	max@schneidersoft.net,
	mkl@pengutronix.de,
	pabeni@redhat.com
Subject: Subject: Bytes order nitpick
Date: Sat, 12 Oct 2024 22:41:35 +0200
Message-ID: <20241012204135.6977-1-ak.alexander.kozhinov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMZ6Rq+rAdyYKOpna1T7dhEV69cuTNFK+gHy4oCfSf0+AmGtyg@mail.gmail.com>
References: <CAMZ6Rq+rAdyYKOpna1T7dhEV69cuTNFK+gHy4oCfSf0+AmGtyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Nitpick: by putting some integers after a u8, you are creating a hole
> for 3 bytes between gs_usb->active_channels and gs_usb->pipe_in, as
> shown by the pahole tool:
>
>   $ pahole --class_name=gs_usb drivers/net/can/usb/gs_usb.o
>   struct gs_usb {
>       struct gs_can *            canch[3];             /*     0    24 */
>       struct usb_anchor          rx_submitted;         /*    24    56 */
>
>       /* XXX last struct has 4 bytes of padding, 31 bits of padding */
>
>       /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
>       struct usb_device *        udev;                 /*    80     8 */
>       struct cyclecounter        cc;                   /*    88    24 */
>       struct timecounter         tc;                   /*   112    40 */
>       /* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
>       spinlock_t                 tc_lock;              /*   152     4 */
>
>       /* XXX 4 bytes hole, try to pack */
>
>       struct delayed_work        timestamp;            /*   160    88 */
>
>       /* XXX last struct has 4 bytes of padding */
>
>       /* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
>       unsigned int               hf_size_rx;           /*   248     4 */
>       u8                         active_channels;      /*   252     1 */
>
>       /* XXX 3 bytes hole, try to pack */
>
>       /* --- cacheline 4 boundary (256 bytes) --- */
>       unsigned int               pipe_in;              /*   256     4 */
>       unsigned int               pipe_out;             /*   260     4 */
>
>       /* size: 264, cachelines: 5, members: 11 */
>       /* sum members: 257, holes: 2, sum holes: 7 */
>       /* member types with bit paddings: 1, total: 31 bits */
>       /* paddings: 2, sum paddings: 8 */
>       /* last cacheline: 8 bytes */
>   };
>
> This 3 bytes hole will always exist even if you group the integers
> together (because the padding also occurs at the end of the structure)
> *but*, it is easier to maintain if the hole is at the end.
>
> So, in summary, do it like this:
>
>         unsigned int hf_size_rx;
> +       unsigned int pipe_in;
> +       unsigned int pipe_out;
>         u8 active_channels;
>  };
>
> Note that there is also 2 other 4 bytes holes, so a packing
> optimization could be done here, but this is out of scope of your
> patch. If you want to address that, it must go in a different patch
> because, this time, it is another "logical change".

Thank you Vincent for this optional nitpick. For sake of simplicity
I would prefer to skip this change, but I've got your point about additional "logical change".

