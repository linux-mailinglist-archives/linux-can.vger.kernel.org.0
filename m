Return-Path: <linux-can+bounces-3290-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21AFA74EE0
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 18:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7963A8BDC
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5643C0C;
	Fri, 28 Mar 2025 17:11:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2F1D89EF;
	Fri, 28 Mar 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181887; cv=none; b=XPDVOwHKs6SwYaWuBAIw6ydvHjVEqAEKuR9igzgO2/tpbpUsTuNhr9kS6J/q9Ss8hcBVWXsaOjWmY2k2Gg+VAX540CTLw93UVQ3Bw3auxRrhgt7oUx/SLv8BlITRT8Lu1faxUjxSXUNanA2AYp6m+0EtaCxyfWCehSdrZr+DLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181887; c=relaxed/simple;
	bh=oP+p1Nf8UmLDbXiADHesq6ZjG6p1zyrjRT25JZzmuXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dROd6OOzWKbIEFn3Uz+dfe/dB52BsdRKm2/DZIenRkGASFrc8kNPCauuen21aOMCC2bKmUOrYFVXRpDQIytebQpmgTdyxWAtrxeJCC6dfSlLlOfS15lPL8WIKDXhf5ptqs5OchvfQicyaTik0PYfD6THHFgMtyWmg6zfSL8Jsic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5e2fe5f17so235544185a.3;
        Fri, 28 Mar 2025 10:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181883; x=1743786683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNVRJp0zbzgxK2DddrVshdOENabXa1b84oqu6iOTIsg=;
        b=Mf0DnbjJeNrv2XPA0WM66eKDC8weow+8zpfpY5hdtyro5kfFgpKhAJ5xqQJNNRkTrw
         klyQtXp1Rvk+wmdXGwML2wPVFTWBQVvlrQv/HKyIwnlkMJ8mkgk/QRknq5X2i/sAEoeq
         ul1/rA/4WK92DPgWdYkuwkDbtikSd7vJBH7JtAnwlX5x9hW+9pQyhoybdBv6v/gMnJtb
         aXvwVd530xpvceBtT1KduKW0Kj1jXryIq1TnJltMG6fHS1OLZpXtMaxlH2oWz1DxpLXy
         1LKSErCJTeZfDynLZlY2b107sdjynu4A0r0D+SBqLrq54Ycy022EDuR3OY7mbWuMrB9i
         xy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ln3Jop9uG5B0DxJ+dy0MfcHJrlC68m8XTXnQgQCiL2dvBeZdUd4EP4oFOJwWRyvHttA7pV6JrMvUMsni7WYCYV0=@vger.kernel.org, AJvYcCWTa1IQpZj7hQckSXf0rua4hLIdyNv5tb/ounvOVpOWeiRb0XvOrjA2YT6diSn7TDWPWv38rW+y5yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw323Q+BMsNwIgwC8gv3oEy1RS6OBgkzDZACd2qSEE2bHnVq7gw
	MvNgqGglwCdER9kyM23nALAMq+EBCts1TT6rsBPjPRgMF7W/F21mz/v1nStS
X-Gm-Gg: ASbGncsI1WD+9k0kIC8ptGgi3Zw9Hyezbq/3D8+HnDkC+0/xvwcSnOqKI0aLuij3Xa/
	EgehdOCPxcJD56d+B+pXM28ii52MWI9XQiA4FryJ/2Zy0YWyO6J3mWfNrZgU6Y5ARUuGCB3blC0
	RY6uyFSdeqjqMCobtOL6oraEFOChFWZSnutQFtlqNwdcVs9JZhlFWeEYIzN72Yxws9VWAUbv3Sz
	ZFKeUERD5QlHSOICRLsP7S9HLZgMiEbZjH+dTdwZA5Lp7Hip12EXjshrSn6tgO50tPHr6Vpkb2q
	3Ion1z6sbrhqlZaFscXwTcpS6NF3SyErzOxHSveLwIO+CagTyU008X2UzV+eMgYYt5Z8p23afVa
	U4po28/0AyphBcDeanw==
X-Google-Smtp-Source: AGHT+IHBUuTsV/dewSaKY8CZysT1d2N6x4Q9JiwJVoGDsWlGLRyIOqrHmGHBirkBi9rExF+o9T0bUg==
X-Received: by 2002:a05:620a:1924:b0:7c5:5e6b:4626 with SMTP id af79cd13be357-7c5eda0e57cmr1183690285a.32.1743181882780;
        Fri, 28 Mar 2025 10:11:22 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-871a33d072csm437095241.33.2025.03.28.10.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 10:11:22 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d42f08135so1013648241.0;
        Fri, 28 Mar 2025 10:11:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqKjUZwrFq6MjfZ3ZK/yDtSBQ6iKdg+Gn8EqdiZXXmBce1WgWfhGeJOhTPbYiYdGjtq0oHQ78h77ibohQ5u2KY7Bk=@vger.kernel.org, AJvYcCXUdIokcTbeI962txGnNkhRIjXEhA09Fca+mPmP2sf37s58cSW7fbM/QGRZjXhlzK3eJSvaQlNsfz0=@vger.kernel.org
X-Received: by 2002:a05:6102:6c7:b0:4c4:e409:5f9e with SMTP id
 ada2fe7eead31-4c6d3836004mr394071137.2.1743181881906; Fri, 28 Mar 2025
 10:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-8-biju.das.jz@bp.renesas.com> <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
 <TY3PR01MB113461BFAD846313BD0584A8A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdW7qTBVuHCxVfpOom-dEkROYfPG_neUiY7iUq=HAgAjFA@mail.gmail.com> <TY3PR01MB1134664605538933A2A59285186A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134664605538933A2A59285186A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2025 18:11:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVkVuxUQRMU8XQE+=+USuaMWbzfkS_69W=mse+-FdhpOw@mail.gmail.com>
X-Gm-Features: AQ5f1JrH7eOG_uwHRU9-7kNOGP6qVn2A8GJgN64-VPCNb0U4cU68OacFfbVzREE
Message-ID: <CAMuHMdVkVuxUQRMU8XQE+=+USuaMWbzfkS_69W=mse+-FdhpOw@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 28 Mar 2025 at 17:46, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Fri, 28 Mar 2025 at 16:39, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > By introducing setrnc(), this patch is no more needed as rnc_stride is
> > > local variable inside strnc(). So I would like to drop this patch in
> > > next version.
> > >
> > > [1]
> > > static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, u32 ch,
> > >                               int num_rules) {
> > >         u32 shift, rnc, offset, w, rnc_stride;
> > >
> > >         rnc_stride = 32 / gpriv->info->rnc_field_width;
> > >         shift = 32 - ((ch % rnc_stride + 1) * gpriv->info->rnc_field_width);
> > >         rnc = (num_rules & (gpriv->info->num_supported_rules - 1)) << shift;
> > >         w = ch / rnc_stride;
> > >         offset = RCANFD_GAFLCFG(w);
> > >         rcar_canfd_set_bit(gpriv->base, offset, rnc); }
> >
> > Nice!
> >
> > Please combine variable declaration and assignment.
> > While at it, perhaps "unsigned int ch" and "unsigned int num_rules"?
> > Actually about everything above should be unsigned int, except rnc.
> >
> > I know this existed before, but do we need
> >
> >     num_rules & (gpriv->info->num_supported_rules - 1)
> >
> > ? That "&" only works as long as num_supported_rules is a power of two, and I think num_rules can
> > never be larger than num_supported_rules anyway.
>
> But this will make sure it fits into field_width for num_rules.

Can it ever not fit?

> You mean drop "num_supported_rules" and use mum_rules directly ??
>
> rnc = num_rules << shift;

Exactly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

