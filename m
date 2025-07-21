Return-Path: <linux-can+bounces-4014-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8CCB0B9A9
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 02:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483FA1897A9A
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 00:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE140146A66;
	Mon, 21 Jul 2025 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqgEVe8r"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C62F32;
	Mon, 21 Jul 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753059335; cv=none; b=XBLcCZ2I9ThZFhGYrEKnF4OKwjJe7icHdgoaV5S4iVRyHi4WnTF9QyU+0WRT72mh0u3YAhUKsPkEjeugXfmEBsdt2LR2H1jWhHyUTVtQEfBFfh3YkmXGyCRBwk1hQumu5fL/W4E+Hgu2Vng39SnEflULoz52zkyFaLDD6A7fmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753059335; c=relaxed/simple;
	bh=pOOzJK2vpqsz8zpTRImgKW77ZewJz9CBN/tc0e94nSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMVXBt4akUQQCwBf8dhr5UQ2Efc1NW4L0cMMFg/b1/C+GGI1eRin/O8PnMB18RAWnsiLQ/AYhyvyRDUKzQGniqI6cEwGsFmwRssVYaFQd9wK35kMmNYIa3uh5DzUEp/7bRlwrAirznuktPBKqqaFTTKfs4rJcSd5uLyEN+XAtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqgEVe8r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235ea292956so34375575ad.1;
        Sun, 20 Jul 2025 17:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753059333; x=1753664133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su3U52+sp+PSAMNUwV41V2iuvGngzlC1kSqRffejv28=;
        b=HqgEVe8rFCvJoUjlZzZn1PCIUKXQrCJduzhWyUBcGJUyyDt4tcGC23pk9HiVhynihA
         a/WZKdL8uyrQrLUrMGEdIBsttM3Ik5tDjN8ZRps/K9zQYTxYc7P2OPk23wCk2D2rzRLi
         A5njZIa3tLk8Cve1+1kfoq5Ka2sFUIgu8njz7/BUW+VPBHvoEO19uQ0InLq5GFuRhW4D
         LBkhTTq+6njVKdhtpZAvq94kLSwjCGQP7NdLUm5O3SdQW6cDcbetBAQHptt9MZ3n9FCo
         OJDnnK/6po6crBKb+0ddqgdVdOQcXH36iPmgoYdSf5u5dtfh6j9+DAQXTzm7UjteA+9m
         mGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753059333; x=1753664133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su3U52+sp+PSAMNUwV41V2iuvGngzlC1kSqRffejv28=;
        b=o2Nd3j7N+zCjte9rOMQ9L5jq6iaRgzH3ZVjlVZIdV9YaEFfvp9erGNdpI+tm5fCpQZ
         fePMcX84637uhXBTZVZMkin4DJnkASzeP+DBDzlscc9kNxib59BzdUVcUjHv9Tnhjhdi
         Xktiayt0yBgBzzG8BGhjekRt6p/Fi7thnYMkr6mLIkZw8rDAWxgdyqydVFAJjx/Q/OPI
         lRQ+uxT6GKRP46b+cACxd7BThnNL43883x9fMVTYmt76CxtZLoXoZJ5ytifRPAAdcIBu
         sybe0z3yle6gZafN3w/6Pjbjso3V/IQ0EZis3XOxZoB3GzesbAOzyL6hTRernDWYuPYS
         CaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyM6VTE72YuzNBQHQxLxlureGN7hMf61VNgBxr8sdrDZWaAB+jf4ddmhEMWme1l/1bJVKbNupoDeMCIWWI@vger.kernel.org, AJvYcCW9NkH9vCC+xPocKpPANhTCw6fdGQMp+BqlYS2unYXsZPA3/bAPH+7zWvOzwJ6QPXq2AlMt5x/z1tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5A+N3Y3RiA0heqcyQGFfAA1lCJEYgUEN2yCOJumSep5kbmKlz
	GCOnbqJJaqbhvVQXPnhaeWpr84KbsAmAbP3m3yw+7HBrAmfZmSJg2yTlCu3UwNwyzQkz+oYGjsE
	nq2TlY8g7cHjFd8ffRDDVtkWdABD3A3c=
X-Gm-Gg: ASbGncsWb4fegXvkbZWtHgNX3XztaArSn1w75TiCZcZb5xFrqbFl6j/ikoQqetUtN4i
	ODy3tk2JS8qMvVYj4EvLBOw/8EhX+kqOHVfyBR1T86VuHltvF+z3CjMHCbyY21U0gl17S1+N+zN
	A08QdiOyMERaTdp8tf2EQl+OMW5RD2BiUNNRQx7eS0tE4PTnVm+53V0CK4SsK6ORRHjgZJ7kGuD
	mZJYwF8FQ==
X-Google-Smtp-Source: AGHT+IEE4N6Umc2ltH0YODkkoDHlFEVnhWKExhhBa/MRkZda2Ky+fkbswM6oupyOFN1r4hYW1mpTt1aIle7MXrVo1yM=
X-Received: by 2002:a17:903:22ce:b0:23d:dd04:28d4 with SMTP id
 d9443c01a7336-23e25770595mr233472765ad.43.1753059333434; Sun, 20 Jul 2025
 17:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720152401.70720-1-luis.hernandez093@gmail.com>
 <20250720152401.70720-2-luis.hernandez093@gmail.com> <1b00e570-f51e-4768-a882-d03252d84534@infradead.org>
In-Reply-To: <1b00e570-f51e-4768-a882-d03252d84534@infradead.org>
From: Felipe Hernandez <luis.hernandez093@gmail.com>
Date: Sun, 20 Jul 2025 20:54:57 -0400
X-Gm-Features: Ac12FXxtTP0SrYJjWusZlgSAcBLOj0fssYgo6ZebCpxEa_mtI094lXf21XdNDRk
Message-ID: <CAGRSKZixNThTx_cUJhiXef4N4=K+eLNemqv6+9nZ=o=0d45NWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs: Fix kernel-doc indentation errors
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Frank Li <Frank.Li@nxp.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-i3c@lists.infradead.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 3:03=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> + Bagas
>
> On 7/20/25 8:24 AM, Luis Felipe Hernandez wrote:
> > Fix kernel-doc issues that reported Unexpected indentation errors
> > durring documentation build (make htmldocs) in CAN, I3C and GPU drivers=
.
> >
> > Convert formatting to proper ReST list syntax to resolve warning.
> >
> > Changes since v1:
> > - Convert return value descriptions to proper ReST format
> > - Fix code block introduction with :: syntax
> > - Add GPU driver fixes
> > - Remove SCSI driver (already fixed)
> >
> > Link: https://lore.kernel.org/all/20250703023511.82768-1-luis.hernandez=
093@gmail.com/
> >
> > Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_gpuvm.c              | 16 ++++++++--------
>
> drm_gpuvm.c fixed by Bagas:
>
>   https://lore.kernel.org/linux-doc/20250709024501.9105-1-bagasdotme@gmai=
l.com/
>
> Otherwise LGTM.
>
> >  drivers/i3c/device.c                     | 13 ++++++++-----
>
> i3c is also fixed by Bagas:
>   https://lore.kernel.org/linux-i3c/20250702040424.18577-1-bagasdotme@gma=
il.com/
>
> Otherwise LGTM.
>
> >  drivers/net/can/ctucanfd/ctucanfd_base.c | 12 +++++++-----
> >  3 files changed, 23 insertions(+), 18 deletions(-)
> >
>
> > diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can=
/ctucanfd/ctucanfd_base.c
> > index bf6398772960..f910422188c3 100644
> > --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> > +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> > @@ -506,11 +506,13 @@ static bool ctucan_is_txt_buf_writable(struct ctu=
can_priv *priv, u8 buf)
> >   * @buf:     TXT Buffer index to which frame is inserted (0-based)
> >   * @isfdf:   True - CAN FD Frame, False - CAN 2.0 Frame
> >   *
> > - * Return: True - Frame inserted successfully
> > - *      False - Frame was not inserted due to one of:
> > - *                   1. TXT Buffer is not writable (it is in wrong sta=
te)
> > - *                   2. Invalid TXT buffer index
> > - *                   3. Invalid frame length
> > + * Return:
> > + * * True - Frame inserted successfully
> > + * * False - Frame was not inserted due to one of:
> > + *
> > + *   * TXT Buffer is not writable (it is in wrong state)
> > + *   * Invalid TXT buffer index
> > + *   * Invalid frame length
> >   */
> >  static bool ctucan_insert_frame(struct ctucan_priv *priv, const struct=
 canfd_frame *cf, u8 buf,
> >                               bool isfdf)
>
> The numbered list is not a problem AFAIK. Did you see an issue with it?
> And having the blank line just before the "False" list causing undesirabl=
e
> html output:
>
> Return
>
>  * True - Frame inserted successfully
>
>  * False - Frame was not inserted due to one of:
>
> Description
>
>  * TXT Buffer is not writable (it is in wrong state)
>
>  * Invalid TXT buffer index
>
>  * Invalid frame length
>
> The "Description" line should not be there.
>
> IMO all we want to do is convert the True and False lines into
> a bulleted list and then the html output will look like this:
>
> Return
>
>  * True - Frame inserted successfully
>
>  * False - Frame was not inserted due to one of:
>         1. TXT Buffer is not writable (it is in wrong state)
>         2. Invalid TXT buffer index
>         3. Invalid frame length
>
>
> --
> ~Randy

Hi Randy,

Thank you for the feedback, I apologize about the issues with this
latest patch version:

1. I now see that Bagas has already fixed the GPU and I3C drivers... I
apologize for the duplicate effort.

2. For the CAN driver, I understand your point about the blank line
causing unwanted issues with the HTML. I'll correct this.

3. Re the numbered list> I was being overly broad in my conversion to
bullet format. I will back this out.

I'll send a v3 that focuses only on the CAN driver fix with the
correct formatting you described (convert True/False to bullets while
keeping the numbered sub list intact).

Thank you for the guidance

Best,

Felipe

