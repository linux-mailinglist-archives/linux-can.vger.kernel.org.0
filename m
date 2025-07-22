Return-Path: <linux-can+bounces-4020-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6954BB0D0B9
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 05:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50A754263F
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 03:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1751E32C6;
	Tue, 22 Jul 2025 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck5adOJo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4E5223;
	Tue, 22 Jul 2025 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156783; cv=none; b=OaKdbhlTp8XljOCWh+Uc29EiUyxD/Ip9YEOlvswlpYKhMtq2U52QkCsp6UbmcLP8oWtbobfF0mMKjGuLAXTANYkReo6O7EOhEmdNOV13ugBfET8zj2KYomqNHo7CZhs/8ZjBJnm8M+h2fsiemtRvAyCrNhP8CRlYqqga4XcroDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156783; c=relaxed/simple;
	bh=LaB/nuZLwEU/xm/geWOeRfJvreE4OzrPBLTdF94i8kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/EO76J/3Qc7N10IcmxwDP2GWT4p4SSzzMg2tAhtUQxAJFSJVtSzMshqW4P24ra6kHZfpg2/lmLFamCd800K9NQJ9yY6dlW0oJculP7SmlhM6iYqekkjJVYJfI1Qr9PmRYj9eN6gZsuYNyaIz5nyljUJM8lo52EH7SiNx1OHHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck5adOJo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235ea292956so46314135ad.1;
        Mon, 21 Jul 2025 20:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753156781; x=1753761581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXXOavQ4WOy2gE8aAWn+LnkavWdDlut0iVqvj5kQmL0=;
        b=Ck5adOJo0q893BEjeiwIFCF+YUglLfEFHOZg6CoEKRfJk1dogTe7PIUNrY7GFDVAuH
         YAmciKUh8Q7ie2zkGxVMDhmFBrUyFxMtTjpIjM0XJB/i/BcB65vroL8yKqPBQLTBm6Lr
         X91dz3r+fqYE3HDvGz1O2BKbeZ9zaBu/2CGFhboJFn2KloIl/xZVyKhCcaStBuomgp/J
         yRO/aFsMPFYTWaZ1iKUF7o85raw67DxsSp7wNvySSghzhsUFltq/dlBsEJ6Zyi+trQHO
         fbQy2ebR8fHgFqVISeD8ryrEY6BzC362Ee8y1cQaww1Xv2laY9He5Bktw2jBM+TzzkVS
         8d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156781; x=1753761581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXXOavQ4WOy2gE8aAWn+LnkavWdDlut0iVqvj5kQmL0=;
        b=G7YiNyXywUb/GK08xK69seChD0sqfNO3qUCnx0AIUlIbQlHX5oVu7bqsJ6+ta97yrr
         G17GwgMztkJDQaAVLx9+tA2BgZKPxQh1y0dUG4OQmFhm6HPqgqidbuORNsslj2o2IqNO
         voNiDQQvyfuf86PmZDR3JrTsUqrTvTlHToGX1UlHJu2PZvolXfNfGhKX/IJX6IFvUodD
         a3a8+lfnnUQIkxpyZ05qrN62NfD/PR53/TfrAAxfXvm21J5Db2dOHzCb5WaMOQ94HJ6C
         B1Lf1lm1bOvjCNolgMcuADYzYkcKgd67UiwWnZlikyuaaeh/d4WSGy7ujymYVBnEWMR3
         sYrw==
X-Forwarded-Encrypted: i=1; AJvYcCUnmAwFN1FF4N+9apG38RaF3lhmH/Z1clXK/FVgeEu/wEaHnif71peEp2/nk+7HNLbhh4YMKiSE+D0=@vger.kernel.org, AJvYcCWW9QKae/xiT3nzEFzZL8s8fLecSoHYwKYckW/mHC2r5rNd8MIvtHG3GKVAGCg8xDD+050GmyZwn9de6b7A@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAWIJyYgbFqvqsvOLerEbOMtlNApivEbjQ3P6lMqIV7A7nZaJ
	DYiTY1mL+aZ5n9waF2Bt4n125lpAw6Jtm5HFhFTepNcn035VHOMCyy9RuZuLACC6B6BgiiURG7F
	M8oVkRy1MpWJJbKtxDTcrm+CEFPaOzNg=
X-Gm-Gg: ASbGncuiqDtOKNOeP0qBNZxd/OcFeRk0x9K3OmG+apoItA3Wt3zH/kFyBhidDBS7PDA
	wlCMrjznrXX60qvtis5lCu9ly8iXKtovjZ4CZTBgHlhdM4SWKAL6pQWVemut1zzwZ11fk1Ml6mc
	GlMppessupK1A2HVe7TWWYtRquZSCvgenJ5UjWhWY4Xz3j1BJYnBWLDE3avXThRaepJWVkYbqYv
	Jx/lqWlEQ==
X-Google-Smtp-Source: AGHT+IE89eLL47Hf4D1CEwGtR86mrukxEHw9vX/u6lpqJWi3y3SDJHMW63vPpjaWuKbwDGISOChwVGhNpGUIMHBPG8c=
X-Received: by 2002:a17:903:3bc5:b0:235:6e7:8df2 with SMTP id
 d9443c01a7336-23e2575a8d6mr314731345ad.41.1753156781485; Mon, 21 Jul 2025
 20:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720152401.70720-1-luis.hernandez093@gmail.com>
 <20250720152401.70720-2-luis.hernandez093@gmail.com> <c0cac011-cc07-42f8-bdac-620f3faeebf2@wanadoo.fr>
In-Reply-To: <c0cac011-cc07-42f8-bdac-620f3faeebf2@wanadoo.fr>
From: Felipe Hernandez <luis.hernandez093@gmail.com>
Date: Mon, 21 Jul 2025 23:59:05 -0400
X-Gm-Features: Ac12FXwAZjYe99Ed8fi0EHgmRE6NYfIksS7kFVNneQku7XTz2fKoUAQSeFSHNfQ
Message-ID: <CAGRSKZiZpHm1-EtMsdG5LMUKo6PRgamHpSsEcqDXvcc_PpR5Gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs: Fix kernel-doc indentation errors
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Randy Dunlap <rdunlap@infradead.org>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
	Ondrej Ille <ondrej.ille@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-i3c@lists.infradead.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:48=E2=80=AFAM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> On 21/07/2025 at 00:24, Luis Felipe Hernandez wrote:
> > Fix kernel-doc issues that reported Unexpected indentation errors
> > durring documentation build (make htmldocs) in CAN, I3C and GPU drivers=
.
>   ^^^^^^^
> during
>
> > Convert formatting to proper ReST list syntax to resolve warning.
> >
> > Changes since v1:
> > - Convert return value descriptions to proper ReST format
> > - Fix code block introduction with :: syntax
> > - Add GPU driver fixes
> > - Remove SCSI driver (already fixed)At
>
> The change log does not need to appear in the patch main body.
>
> Add a --- cutter after your signature and put the change log after that c=
utter.
> This way, the change log will automatically be discarded when the patch i=
s picked.
>
> > Link: https://lore.kernel.org/all/20250703023511.82768-1-luis.hernandez=
093@gmail.com/
> >
> > Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_gpuvm.c              | 16 ++++++++--------
> >  drivers/i3c/device.c                     | 13 ++++++++-----
> >  drivers/net/can/ctucanfd/ctucanfd_base.c | 12 +++++++-----
>
> Can you do one patch per sub-domains and send them separately? The mainta=
iners
> of drivers/i3c/ are not the same as the maintainers of drivers/net/can/. =
And
> there is no dependencies preventing you to split.
>
>
> Yours sincerely,
> Vincent Mailhol
>

Hi Vincent,

Thank you for taking time to review my v2 patch and for the feedback.
I have since applied the changes you suggested. I apologize about
mixing the sub-domains, at first I thought they would all be related
as being part of the documentation subsystem since they were reporting
a similar error but I now understand these weren't documentation
related per-se and should've gone to each of the sub-domains
separately as the changes were made in the sources.

Again, I appreciate the guidance!

Best,

Felipe

