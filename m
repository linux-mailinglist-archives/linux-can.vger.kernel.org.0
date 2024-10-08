Return-Path: <linux-can+bounces-1610-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6FB993FE7
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 09:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76070288F21
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479761E32BB;
	Tue,  8 Oct 2024 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rl22V/jl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA171E285B
	for <linux-can@vger.kernel.org>; Tue,  8 Oct 2024 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370392; cv=none; b=D8dJm2OcE0ViB1mFevCdlLHiSO+Xu/30R1sKF1xsDyojuqep65WqtEHDm3kPe+6rf0HwNlBSJqA3pMjXrT1OVWCmNV6duY3+Mq4oiQtjkNZledNJCZwEoDkC9rBqjibxzval+1xz1HBkVQaVZgI4jtiGa467fIWEQMWZ5cSiuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370392; c=relaxed/simple;
	bh=5z0uU9Wb252iUAWSkOqEskjFtGZleh03WTSNFVgYn3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6pXUlziO8bJ7ouLazSB9M7VTz+jGPX0HzZEYtPDKj/3YkjbvU01ahuHxq2vT/lzUdJ5oR8P1QR1FCXBtZWfRzwjxcsvJNoZgR1jssw16va85mNxEE20McQf5KzfCVLQBQgYVvX4pQvij6r5H0BMr4TWFJXE4fllYTDWxvuhrG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rl22V/jl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e02249621so1313635b3a.1
        for <linux-can@vger.kernel.org>; Mon, 07 Oct 2024 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728370390; x=1728975190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItNX7whqq1wM4Y+YthTzkAiBd1NFUxLSbjrBOraYovo=;
        b=Rl22V/jlIhkmHsf3N6mAquGLJJI+mNG/iHrRlYOY2i/8v3rq8GCOOE8V+OwKekNjBs
         m8MIfJQ9G3n+hFZKqZvfCULN2FTJrP/LttmSSZRnP770fh8NcpydfdIfNmVnWHFVP760
         mXtHNVU+THRR9N6PfJuGNQFpvlTObBnVqc2gx4jg7t5tF3CYDSsNVfRe5aL6AQkU7XT8
         JuWOQ0+IcMNbdFeBJymZH0m7HCXO555pvXgQ1NvHKFH/T5jQnqUduFjEsG9C9EqSL2jg
         6xdPHwSZ4RfiQv431uzBbOLOPP8eHQQmdnEZuChMfjdsBh0xYvhMCdchyEYagip/sfZj
         aKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370390; x=1728975190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItNX7whqq1wM4Y+YthTzkAiBd1NFUxLSbjrBOraYovo=;
        b=WTzBb1BPhIZ7iPXzjvSgcxIdQH7v6+iHDvK4MCo65nbC8JSheTRUCqHGz1/+pMCQq5
         qWpB4fesk3AyBCZ2KwtBVzGkxsBqJZFmLWj9VHNFFOPHITyJq7UlrB7clxyl3WpHBw1I
         FNKgefzilJDYSDqsmsZwFHuBb9go06KVDLAjHs77pT744jV3awrXZM5RJoxp9qgL0eEX
         LrJ9MpojHE+no0JSDeKKWe7/nCCtZUa2n7jQ/jpbc3cuf/3NpbWv8AszSFh+Iminyv7X
         Qyjsg5a00s9ew850ZIfiRFMlthTYaxQt8IRpkDmigB6hif+Ax/DmDaSnk79z2MHRwZLA
         JJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Bmivty5rkkzLCNl3B3eu1X9s8YTebB9LM0tFAVFfpDXfaBAxpe7UPNOlGSnc2dxIatmRAeNkznI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7M2nxVH/zr5xd/67VhX74WWr08FOrIvbX5MMBN5HF7LHYI/j
	upw0IVwDzz938yxGv9LMbb+BK9wVDuzKTbD3Y2j+4G/WUQWGjm1ALPsakE38bUI1NX5Dt3SKsDJ
	aJ3K66my5bSsanUG+D8PcZIuoqBpnJNHp6ndTKA==
X-Google-Smtp-Source: AGHT+IH3lndbMLW+UzbwODISmlufYPAbfdGzSWh60QyF+kD1gwdCyC+vEIWH3wf+3KcyikitV3+JP7BLci2YhEzr/yw=
X-Received: by 2002:a05:6a00:3908:b0:718:ddd7:dc3b with SMTP id
 d2e1a72fcca58-71de2445318mr24458495b3a.21.1728370389915; Mon, 07 Oct 2024
 23:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007213502.28183-1-ignat@cloudflare.com> <20241007213502.28183-6-ignat@cloudflare.com>
 <CAMZ6RqJ8XBVd5RzKEtxKz8hp9sR7g6fzwLv_3aB1OUSuK_dBFA@mail.gmail.com>
In-Reply-To: <CAMZ6RqJ8XBVd5RzKEtxKz8hp9sR7g6fzwLv_3aB1OUSuK_dBFA@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 8 Oct 2024 07:52:58 +0100
Message-ID: <CALrw=nG4AmR4M6u1u1a5+cZxM5Vu69PCwbWUoyxaOLhRSypMYg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] net: af_can: do not leave a dangling sk pointer in can_create()
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-wpan@vger.kernel.org, 
	kernel-team@cloudflare.com, kuniyu@amazon.com, alibuda@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:38=E2=80=AFAM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
>
> Hi Ignat,
>
> Thanks for the patch.
>
> On Tue. 8 Oct. 2024 at 06:37, Ignat Korchagin <ignat@cloudflare.com> wrot=
e:
> > On error can_create() frees the allocated sk object, but sock_init_data=
()
> > has already attached it to the provided sock object. This will leave a
> > dangling sk pointer in the sock object and may cause use-after-free lat=
er.
>
> I was about to suggest that this should be backported to stable, but
> after reading the cover letter, I now understand that this patch is
> more an improvement to avoid false positives on kmemleak & Cie. Maybe
> the description could be a bit more nuanced? After patch 1/8 of this
> series, it seems that the use-after-free is not possible anymore.

If we go with Kuniyuki's suggestion in the cover email to replace the
explicit NULL with DEBUG_NET_WARN_ON_ONCE(sock->sk) in __sock_create()
then use-after-free would be possible again except we will easily
catch it. But I will review the description, when I respin the patches
to net-next as requested by Jakub.

> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> See above comment as notwithstanding. This said:
>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thank you.

>
> > ---
> >  net/can/af_can.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/can/af_can.c b/net/can/af_can.c
> > index 707576eeeb58..01f3fbb3b67d 100644
> > --- a/net/can/af_can.c
> > +++ b/net/can/af_can.c
> > @@ -171,6 +171,7 @@ static int can_create(struct net *net, struct socke=
t *sock, int protocol,
> >                 /* release sk on errors */
> >                 sock_orphan(sk);
> >                 sock_put(sk);
> > +               sock->sk =3D NULL;
> >         }
> >
> >   errout:
> > --
> > 2.39.5
> >
> >

