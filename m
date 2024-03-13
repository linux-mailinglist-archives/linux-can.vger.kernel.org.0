Return-Path: <linux-can+bounces-373-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA087A5A9
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 11:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3738A28324F
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51B38DFC;
	Wed, 13 Mar 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2iiMFmB"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99B38DE4
	for <linux-can@vger.kernel.org>; Wed, 13 Mar 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325116; cv=none; b=Twpq7CaKrXBZp3zSUDvFcr+VcjFNrinDIeyFiykm24qxyInzujKUyYqHzQAUzSJjskunXtqu23ejW7ItnGlGUGxdlirjv4w6a1v8rDiwcrbBMlUlZGyT3X6bSweC+30kgINe4Iovf6afHzQ4OZFRymG8Xa6EZYJdzGotie0OMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325116; c=relaxed/simple;
	bh=Qyl4j8P/tDntqCs0XgdK6YL19GAwUcjXl2O0gs4B2+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cin77zEZSqBiRoaxRxTHTdhOiJhmbbgfeuZLn2ezXeQCtaUPTVqW+mVxVvIZe1fsCfEA1livKdLiYCk5DziD7hgnLNesa3NsAD8pSUv/tM8SBceSVrexijgLhsjq2TFEYEDzsYwl6dpiWmy1Wp0ZEdQ4vbY67CXREq2NnQN5XQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2iiMFmB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5687ebddd8eso14674a12.0
        for <linux-can@vger.kernel.org>; Wed, 13 Mar 2024 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710325113; x=1710929913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/1jpTLtdDidJX4Wr/95qpLr/EL3WQRiA7nPpeNQ1M4=;
        b=P2iiMFmBbkEuNC8wsruc0uJQ+a0MncprL+sSlTdIkBszuHhqJj0/UHLhyY3dNLFWLK
         yPIEdhcGYQHa8lvwwEiVxzFw9qHRqLTfdcUqbPH3F5PuEMdP7nzqDvx0uNU11fXs15mG
         4zNhI8TUpcXDanqJFlSRwmpcDDe1vmR7COhmI5eo75RPFQY5mwyKiylYUlYd6BWW7RE5
         7vR5150GAAMeD2fxxMhjm8WcDSkNo8irEtlHCPMlxAYV+8DWpeZ6hCU3HD5aHcyJ6AAS
         td045CBKGpYEcI04RefBOHKpnHcfaXpzUJc+cjA4WSH4ankqDm8BdnnhSlucMHwdL8Ui
         jFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325113; x=1710929913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/1jpTLtdDidJX4Wr/95qpLr/EL3WQRiA7nPpeNQ1M4=;
        b=B63vrOOI98aOjCy83QblH4L2Vb3cg5m30GdVQV17KvSYxwbfC9iTSYG+F/rO8pm3a3
         xxckirI0Efftw70vgRdQqUFRwc7iqCxcXntAxhjSsEPxW+wRiKcrevPpYHlybL0H2snr
         s2p2agpWHm6YSXU/K5Ii1BEqwecM9r8YF964fcVJLOMzm39HdXZzRCc+KnKa2dWuoU93
         4bDGVHi7OYHtIOIHCee+bqMduAdkiRzqf6OKTNzQ8ZdtbLIM9F8Mu9d3jjCN4kFOEask
         tjA+IpV/uhqcMsdDPMqlTh6UMB9/s93k19w3hfbeTaR1EZocf4oMV+RyhvCwpOPFPHlj
         nS0g==
X-Forwarded-Encrypted: i=1; AJvYcCXYMKq07Div669Gt5dk3TIqr3+Dl5askv6Xq2+RIrm14lDg9rn9Ui8xoCwhaeqkOjMR2FrHSHlT6q5r2yc1RINrvhLK8xpzmN6O
X-Gm-Message-State: AOJu0Yyp05Qse4KnGe3qgJiAjxgWzgmlEkubbCpHu+ErggrB5fGBih9Y
	GzWFiKQZuFGICj6qUfR5AW3l1WoiuzsUjQ2ZchiCGUakBy1G0a5FQjwPQeZjKQ0aP9yKg3TENHg
	JMFDkFF3n+CN8OdoUSFizyI2IskCTcYBFrepbuWG5UN9xF590dg==
X-Google-Smtp-Source: AGHT+IF6v2VCIxdT+D1s7StXU+Fuvw9x7dw5sx/poqbH9j7lCgMeAIKdeRkFmHihz8/oZexhPkGBrY72OMYCA4tsYoE=
X-Received: by 2002:aa7:cccd:0:b0:568:271a:8c0f with SMTP id
 y13-20020aa7cccd000000b00568271a8c0fmr117697edt.7.1710325112885; Wed, 13 Mar
 2024 03:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313094207.70334-1-dmantipov@yandex.ru>
In-Reply-To: <20240313094207.70334-1-dmantipov@yandex.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Mar 2024 11:18:19 +0100
Message-ID: <CANn89iLCK10J_6=1xSDquYpToZ-YNG3TzjS60L-g5Cyng92gFw@mail.gmail.com>
Subject: Re: [PATCH] can: gw: prefer kfree_rcu() over call_rcu() with cgw_job_free_rcu()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:43=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> Drop trivial free-only 'cgw_job_free_rcu()' RCU callback and
> switch to 'kfree_rcu()' in 'cgw_notifier()', 'cgw_remove_job()'
> and 'cgw_remove_all_jobs()'. Compile tested only.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/can/gw.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 37528826935e..ffb9870e2d01 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -577,13 +577,6 @@ static inline void cgw_unregister_filter(struct net =
*net, struct cgw_job *gwj)
>                           gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj)=
;
>  }
>
> -static void cgw_job_free_rcu(struct rcu_head *rcu_head)
> -{
> -       struct cgw_job *gwj =3D container_of(rcu_head, struct cgw_job, rc=
u);
> -
> -       kmem_cache_free(cgw_cache, gwj);

kmem_cache_free() is not the same than kfree()

Unless I have missed something in mm territory , your patch is not
going to work.

> -}
> -
>  static int cgw_notifier(struct notifier_block *nb,
>                         unsigned long msg, void *ptr)
>  {
> @@ -603,7 +596,7 @@ static int cgw_notifier(struct notifier_block *nb,
>                         if (gwj->src.dev =3D=3D dev || gwj->dst.dev =3D=
=3D dev) {
>                                 hlist_del(&gwj->list);
>                                 cgw_unregister_filter(net, gwj);
> -                               call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +                               kfree_rcu(gwj, rcu);
>                         }
>                 }
>         }
> @@ -1168,7 +1161,7 @@ static void cgw_remove_all_jobs(struct net *net)
>         hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
>                 hlist_del(&gwj->list);
>                 cgw_unregister_filter(net, gwj);
> -               call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +               kfree_rcu(gwj, rcu);
>         }
>  }
>
> @@ -1236,7 +1229,7 @@ static int cgw_remove_job(struct sk_buff *skb, stru=
ct nlmsghdr *nlh,
>
>                 hlist_del(&gwj->list);
>                 cgw_unregister_filter(net, gwj);
> -               call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +               kfree_rcu(gwj, rcu);
>                 err =3D 0;
>                 break;
>         }
> --
> 2.44.0
>

