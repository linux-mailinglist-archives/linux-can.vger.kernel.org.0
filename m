Return-Path: <linux-can+bounces-5666-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39AC881C2
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 05:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D06A4E1CD7
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 04:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED850274B48;
	Wed, 26 Nov 2025 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="OD/NR8EE"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A18283FDF
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764133170; cv=none; b=JtegAEhyXKoj9V6F2/DiT357gxwHKa+laF9UbsDW/AMTUSSve93Lq1B3/6BfxiEwpLsKMClSqxZWmUlOEUiZ5QODairRWsEpPi9lxOxwJmXJc3JdGDFL11SsqnYsSDAMkx0vTB1hiw62WDBbdpZ16naThIQsxLkGvKvaYOs9S2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764133170; c=relaxed/simple;
	bh=3S4lfFMj7q+YBgrmDA2SP6irVZkPQyrV0keK3iUjdKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ek0CLC0yA0HNQwq5rqMx8JBBjHWgg5Mb3zN+OtISrF8xs+pJxSLbch/QD11kPRGeDW2JHxr7GJIIdJhqk7Mqv0b5h/FbVvd8RaEM2z0ib1dChIKNyKi2nNfkFGgOEpgtTmXAh39BDiWYFLER7/kr6iKyDbt3oHG2lGIWUtROVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=OD/NR8EE; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78a835353e4so61627687b3.2
        for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 20:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764133162; x=1764737962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SstjdCULfreZEVFZNj/IhPpujFlsaGB4XKF9NC1FxsM=;
        b=OD/NR8EEoef6l2Yj0RX3+v+RnCHHfu8OZ8zrKSvX9ZRlc9R/wAcxeEFXybdWWPtpN3
         IxhkczpmuWncdwJQPu41cr1/AASOBiWiaiWkpFEPYjzd+vkev+KnVL2DuYvtWgG4krGi
         KZRE7jsmnVTg+J7tteipYbqqXrleBXG5YsUwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764133162; x=1764737962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SstjdCULfreZEVFZNj/IhPpujFlsaGB4XKF9NC1FxsM=;
        b=NW8fvqjQ/3EFQ3IDnz3u+JCoTBuTXsDIaeKCX8N3LoOuIac8rvbsguKBYyw9/7Amsv
         ksIj+N7Io1Vj7tXicpbec1d7XA1vqn/Lclquj4Fs1sFqFJrzAScQ0RXGd47K1Jivw2bZ
         DDT+3qudnzKd25aPQtL4Y5A4xoWiuGgqj/zTsYB5zsyM9QhzA9ED8NNEYEjzBRRCjsZJ
         X2k44197CTPZ4jlevIees2zL/+FoRvh6Al4wOiS5koGez0E4QbldnxbywZ3Mgsx5zdVb
         PnRNobSx5dVn0r91OdbTSjO3NLjlgCvkJduRZk4PotEDqKLD4CG3rDDLRJZn/9xO8IoD
         R5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNZZWaIJaGW0j8Cm3hvVGd3SUnRBprrS1W8kD4yrL38Xqdof2LLdEPlCy383WmiyTGt6bUpT17qnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPi44MY4RwYPodqieFoDJc6f7ehtNdCyMMydveIesj7rdX6Ee
	9oCUvZWkOd6LzCIQkSYupxi3kzWgQ4innTkHCe+D3jrUQINfF+7xr2Pzb5urhmwbQrrL470CtEc
	Zt8dYJY+HjDAgtDRmQyI8896Wg1dIJJUEXcpU3mUm3Q==
X-Gm-Gg: ASbGncutN8q7qUqw9J7ejvh0pnsDlUBXaRO121XgmwtwLfxedhU3bb15KsF/UNfxcNy
	fbVuMpC3KpLAa2OgZpXx+9yZ67L0X9Lwv9226cL18tRuW9fuqgs6XC8n+KD9uf75kC0LDGOhvb9
	TBnU9g8vHOCy7SDl0fc4IHo/YenL2wENwBszKN4nWxk7zQ7t8PSe+2Wzh5KCiy6I4MwSbRDkwHQ
	THQFpxSitss+7m08adxypGYuv6DeNGYsisnjfEGuuHC5m/DxXMlpzl5AxdTZpVh1VQAzSUU1j25
	cb8cWZ8uBdXltQq6l93naXB35w==
X-Google-Smtp-Source: AGHT+IHYV24PR1HmviDhOvHoIdpU4OrMzkDvxo9kIkiDVSrc03caPIiSxNEOTLnfxjOyc6l8KWVp3xgTJHsj5IfiBRI=
X-Received: by 2002:a05:690c:a8e:b0:78a:7ea3:2051 with SMTP id
 00721157ae682-78a8b493c91mr166553187b3.26.1764133162219; Tue, 25 Nov 2025
 20:59:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126034601.236922-1-ssranevjti@gmail.com> <CANn89iLiCh85_1Ah6O_rTOCGwLet97f7DyfyZMDgfTV==iUVUw@mail.gmail.com>
In-Reply-To: <CANn89iLiCh85_1Ah6O_rTOCGwLet97f7DyfyZMDgfTV==iUVUw@mail.gmail.com>
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Wed, 26 Nov 2025 10:29:10 +0530
X-Gm-Features: AWmQ_blSv9rz5XKF93QAC7OCn16_tZDGSLCqlVOse-qgbGV4NCIMipFmQ3Y0fNg
Message-ID: <CANNWa05qyDYoCe=PQT4nx99CxFtwLoNtJoNKicLUG0A_XT-Emg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: em_canid: add length check before reading
 CAN ID
To: Eric Dumazet <edumazet@google.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right, checking skb->len alone doesn=E2=80=99t guarantee that the
required bytes are present in the linear data area, especially for
fragmented skbs. I=E2=80=99ll switch this to a proper pskb_may_pull(skb,
sizeof(canid_t)) check to ensure the CAN ID is safely accessible.
I=E2=80=99ll send a v2 patch with the corrected validation.
Thanks,
Shaurya

On Wed, Nov 26, 2025 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Nov 25, 2025 at 7:46=E2=80=AFPM <ssrane_b23@ee.vjti.ac.in> wrote:
> >
> > From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> >
> > Add a check to verify that the skb has at least sizeof(canid_t) bytes
> > before reading the CAN ID from skb->data. This prevents reading
> > uninitialized memory when processing malformed packets that don't
> > contain a valid CAN frame.
> >
> > Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D5d8269a1e099279152bc
> > Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames ac=
cording to their identifiers")
> > Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > ---
> >  net/sched/em_canid.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> > index 5337bc462755..a9b6cab70ff1 100644
> > --- a/net/sched/em_canid.c
> > +++ b/net/sched/em_canid.c
> > @@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct=
 tcf_ematch *m,
> >         int i;
> >         const struct can_filter *lp;
> >
> > +       if (skb->len < sizeof(canid_t))
> > +               return 0;
> > +
>
> Please keep in mind that this test is not enough, even if it may
> prevent a particular syzbot repro from triggering a bug.
>
> Take a look at pskb_may_pull() for details.

