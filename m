Return-Path: <linux-can+bounces-314-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DC85B50D
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 09:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1041C20DF8
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DF25CDF4;
	Tue, 20 Feb 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZKFUr2X"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08E5CDE7
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417575; cv=none; b=LW9XXed5gn/GcXisPJoXnXq5JTXiFlj3zI3C9sDF7SH6MyEid36RhoHEBEqAAo9dJrkVOial8kCm1mlSk3u/SYzN7nOQQnbx3/y7jR3gehHvWNZYCY+kg3S7/q2X52QFm05rMLtw78udegxkYN9sM4/f0Ao9lEAdXLPNdLA+umY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417575; c=relaxed/simple;
	bh=Ex6AkL7ydVf+v/naVjMzpHY7zzHxDwlxfUGhfPcd4fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5oGOOnrrNXgm7n1S3eBl2zP+UptEfm7Ff2C9VnhAgOnt/RpkJskAMAgqsTbzfAQpkyEe3NDEAvN+UHOCzuxcslrc5wUovHzwl+PSC+RMLlhJH8IsAa4IZRnWnz83oDiULvdzmngmMCSMiWJ2k4NNk5LnRqqisP6s/mKEsF4xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZKFUr2X; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5645f0b887fso16615a12.1
        for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 00:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708417571; x=1709022371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Znfz2j7Jl5QlXM/u6ArZ3v+AV0Im3HF+b18HECOGN5w=;
        b=tZKFUr2X+/LsYmprfawXDvIL1st0QIAQBw13RZ9BIwVWrY4kh0DoHn+1FVUnuctmov
         N2+FGerGSZ9lXop5djnL5fHT66fyR0ZJ/bQdAECPp5QpCVGf14NtLNxozkCeL4NBwcyI
         ma4KmSdC6d0hPYayzbNyCP6WK8w15Uzjc34fbwmpmAW4xxbl7/80Nd7zP03kSbJEoORs
         /j96TI2EaSzlQIxa/74tKQIPK66Uy4Tq3PCds3IFB9cZmK82ylVrsDPyY/+B2uio6Oau
         6BcCpFfoFEkgcWfS0SPkyPBlB2tdOPSlcr8texNLJJgTav+TCt3vSU2DnOgkZs9QW4sH
         quVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417571; x=1709022371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Znfz2j7Jl5QlXM/u6ArZ3v+AV0Im3HF+b18HECOGN5w=;
        b=dKmECP7lGBsBGOlY6bXtY66DdjXOav5zRs/u4ch1NnNNnGxIZ4lC5Nfnt8DcsS9P6d
         66Ukjn/C/vnitEGXpcqdI0cwanPEJk7G2ZfSn+J2j6DeBH2xXil+cnSpYsXczyScc7w0
         jvMzDVcWfljy0NwiLEaD9XcchuPIp0kVCGDM5MEqCXV5q8zbCcwgxrCxaRgM8+/bIJut
         813HSf3L2jNJXB3VajXnQFbbBpbOWmsRQzifRyOcPnY5WpPSNZbU3OKm5t28G5YW5Jqj
         o40nqDVbUfymlA4rmY/P/MVXlTcKd8WoDJiwpxbcyijEjN2FuYCjFelBxE2QP8/88Bs5
         6zJg==
X-Forwarded-Encrypted: i=1; AJvYcCU9T3/42LRGhhOdkGey/r3c5brtDjhrG+I0nORnVZGKmLbXOYDfuzARtF8+UFZGEjP3JsUG0Gc4XiNayfQEr5CLenm3feDhm7Zy
X-Gm-Message-State: AOJu0Yyg3Ejc+lydiSrUWP0c4cPoyBMOCufD3LJjo9BNeykNX10Gxctw
	B8368H5Irqjmc7dFdI0s2PLYmw/GSw/3CNgqmeRtcul/DaJATEvM5N5NPHm2wkyKqdYhO+N10zt
	j0dN6l2R8Kp1nuCM/xFKIhBLEK2gG/5d8d3OL
X-Google-Smtp-Source: AGHT+IHl7r9cRvlxf0s+oxwblHmVyd5wPz7vWVijyeCqDHc9rx3NEWMtglzPls2Shl01qDLXwosj8L2rTOFjdZtGKkQ=
X-Received: by 2002:a05:6402:1649:b0:564:55e5:6ee1 with SMTP id
 s9-20020a056402164900b0056455e56ee1mr243174edx.2.1708417571321; Tue, 20 Feb
 2024 00:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
In-Reply-To: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 09:25:58 +0100
Message-ID: <CANn89iL7N-1zvBBLoz0qhCApVJRF1LKu=jSyC0yz-wHa3JLGNg@mail.gmail.com>
Subject: Re: [PATCH] can: raw: raw_getsockopt(): reduce scope of err
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:16=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> Reduce the scope of the variable "err" to the individual cases. This
> is to avoid the mistake of setting "err" in the mistaken belief that
> it will be evaluated later.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  net/can/raw.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 897ffc17d850..2bb3eab98af0 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -756,7 +756,6 @@ static int raw_getsockopt(struct socket *sock, int le=
vel, int optname,
>         struct raw_sock *ro =3D raw_sk(sk);
>         int len;
>         void *val;
> -       int err =3D 0;
>
>         if (level !=3D SOL_CAN_RAW)
>                 return -EINVAL;
> @@ -766,7 +765,9 @@ static int raw_getsockopt(struct socket *sock, int le=
vel, int optname,
>                 return -EINVAL;
>
>         switch (optname) {
> -       case CAN_RAW_FILTER:
> +       case CAN_RAW_FILTER: {
> +               int err =3D 0;
> +
>                 lock_sock(sk);
>                 if (ro->count > 0) {
>                         int fsize =3D ro->count * sizeof(struct can_filte=
r);
> @@ -791,7 +792,7 @@ static int raw_getsockopt(struct socket *sock, int le=
vel, int optname,
>                 if (!err)
>                         err =3D put_user(len, optlen);
>                 return err;
> -
> +       }
>         case CAN_RAW_ERR_FILTER:
>                 if (len > sizeof(can_err_mask_t))
>                         len =3D sizeof(can_err_mask_t);
> @@ -822,7 +823,9 @@ static int raw_getsockopt(struct socket *sock, int le=
vel, int optname,
>                 val =3D &ro->xl_frames;
>                 break;
>
> -       case CAN_RAW_XL_VCID_OPTS:
> +       case CAN_RAW_XL_VCID_OPTS: {
> +               int err =3D 0;
> +
>                 /* user space buffer to small for VCID opts? */
>                 if (len < sizeof(ro->raw_vcid_opts)) {
>                         /* return -ERANGE and needed space in optlen */
> @@ -839,6 +842,7 @@ static int raw_getsockopt(struct socket *sock, int le=
vel, int optname,
>                         err =3D put_user(len, optlen);
>                 return err;
>
> +       }
>         case CAN_RAW_JOIN_FILTERS:
>                 if (len > sizeof(int))
>                         len =3D sizeof(int);
>
> ---
> base-commit: c8fba5d6df5e476aa791db4f1f014dad2bb5e904
> change-id: 20240220-raw-setsockopt-f6e173cdbbbb

What is the target tree ?

In net-next tree, syzbot complained about a bug added in

commit c83c22ec1493c0b7cc77327bedbd387e295872b6
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Date:   Mon Feb 12 22:35:50 2024 +0100

    can: canxl: add virtual CAN network identifier support

Patch to fix the issue has not been sent yet ?

diff --git a/net/can/raw.c b/net/can/raw.c
index cb8e6f788af84ac65830399baac6d1cf3d093e08..897ffc17d850670003e5cf34024=
77e8fc201f61e
100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -835,7 +835,9 @@ static int raw_getsockopt(struct socket *sock, int
level, int optname,
                        if (copy_to_user(optval, &ro->raw_vcid_opts, len))
                                err =3D -EFAULT;
                }
-               break;
+               if (!err)
+                       err =3D put_user(len, optlen);
+               return err;

        case CAN_RAW_JOIN_FILTERS:
                if (len > sizeof(int))

