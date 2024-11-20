Return-Path: <linux-can+bounces-2146-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E8B9D4225
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 19:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FA0B219E5
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9D27447;
	Wed, 20 Nov 2024 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSxXwT6w"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FE20B22
	for <linux-can@vger.kernel.org>; Wed, 20 Nov 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128164; cv=none; b=Q4xKlmJFNM809/vXq/Z+Q+3Cw6v2E+ERAudSrQmKRwa5fdj7BKGbEXvUXRSdlXOaYBmHM5hyTFa1EaHTo3amuDtaGI9pWO8brvDF8Tb/pbtGod+Cim1xnbWua6UPOdMw6o1aXDxsy7YMrQsNli19UqG8id/QCe5vV1FDsvzPJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128164; c=relaxed/simple;
	bh=9mBdGGyUK7YezTItW7z0XByVE1Dmmie1RskydeHTxCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2FgmfOA0hMpsshGFAlxiZLe3u4kSjY0E8ua+PQHl3wlFgs5x6smPNl2xBzUJbj3MzgOAJRJfELqzBAymBswLpGDemkQ5FXYoChrKZ2kRNdtOsrMhNtYgCSbiywhR81KQjMnb4W2H0wto/XPLAxNsNcSndKt0Rh661DY4S+9uH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSxXwT6w; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5111747cso983611fa.2
        for <linux-can@vger.kernel.org>; Wed, 20 Nov 2024 10:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732128161; x=1732732961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hAEQOpv3e/6njl4g9eVBdiJIB3uT53su0BHZMcI8lQ=;
        b=VSxXwT6wDlCiz7yH355eMcOzfbJOEs0cYmUELHCydXFNh0oa4IBjaAoyMO+DpoD04U
         9xnuKMeV0JuDD6/LToH1ANntlrUSMSMkQdTPGCmyluD/TfyoR7hM3YwNNPm6crIPSBca
         fPyNa3VaYumH8campft2A2KhzPKTlxSr31iSLnG4Fvr1T/puMS1dP97mS19nKkD7Nxog
         0cskXTZs0uyYKDO1Rmc5EDcatPXAvmRvz50n2cAyTFr1OuJQ7QGRKBKe6Rz05xqI1gsW
         oRbYAiGlBKUITgEIGXoSAZXOykSLeeC06pA3Ru2Jb+G+y1jx3uIwq9ynuve/aJVEa7Ik
         j3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128161; x=1732732961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hAEQOpv3e/6njl4g9eVBdiJIB3uT53su0BHZMcI8lQ=;
        b=eetEPCckz7PXIW4hIT1aJoyETTHgViItD2joMvZi779W9Fxil080rvG79zR3j0bCbS
         t5lXsTSaNDkEPxKmUH6D4r/BOuCq7vqB6q9SpG+vuEgRz73bU1/gBF9aiGXrxz6fW0gD
         KIuS44pOBPUYN4EQqYf7/mGnRUVmj8bf7zdi12l3NFQoU/I0QQczu5xLfs8WHfwukKhH
         Iww3b2tAubTr3DoOxhOfVdByKNdzLtjjycX/R5dbeOvUoWEzm6YkLS4PHBcVZjLP0chW
         ORCcsu1kleL0heqz3W8Uho0+p/OCX8Hga47XZ5eL6Z00OhQ05+4YvyXvKWro0RJMEbqP
         66Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW+rOYrhjKtLUoz7AbbgoM+hJxh8qqJ+byNAUkczLBt+NKGlfUmVXg14ktZUSdFQS3cSVuGzhTZ7YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiG7c2PuW17FDp3ieHSqStTpOT5TWXxi2eHOfxmNisj0O+SD2c
	hUqpm1XkpyAU0AsITDKqIEFaSvQKEqvzmfuR2NExnzP/NIHctRMjd/MjzVkFRP0jZNgZh9MHRiJ
	Y7Q/w6ckplw/1NeT2XOuiQt2hGGamyg==
X-Google-Smtp-Source: AGHT+IH2X5VB9h2nw+Jkh45tRBGbRsS9MWdWWWZz+fC+WzN6aKJtr4NXlo5S3vdL2/SbBK/c1If30/9tu1+PUurCivc=
X-Received: by 2002:a05:651c:154c:b0:2fb:6027:7c0a with SMTP id
 38308e7fff4ca-2ff8db66029mr29570051fa.8.1732128159060; Wed, 20 Nov 2024
 10:42:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5CvorhgM0r0WssdPxu2Q+=QuaLh2m26sekn5TadUip=RQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CvorhgM0r0WssdPxu2Q+=QuaLh2m26sekn5TadUip=RQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Nov 2024 15:42:27 -0300
Message-ID: <CAOMZO5D=CGJsf0JZz606Bpsvu7mhi4h4XsE173feRfT25mLfhw@mail.gmail.com>
Subject: Re: imx93-evk: Failure to run flexcan loopback
To: Bough Chen <haibo.chen@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Li Jun <jun.li@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Schrempf Frieder <frieder.schrempf@kontron.de>, 
	Mathieu Othacehe <m.othacehe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 9:23=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi,
>
> I am running kernel 6.12 on the imx93-11x11-evk board.
>
> I have backported the imx93-11x11-evk flexcan support:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?h=3Dnext-20241120&id=3Ded73790b6ba7e44b6ca7129dbe564c50a20d9f45
>
> I am trying to run a loopback test:
>
> ~# ip link set can0 up type can bitrate 125000 loopback on
> ~# candump can0 &
> ~# interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
> [   73.313897] can: controller area network core
> [   73.318472] NET: Registered PF_CAN protocol family
> [   73.338241] can: raw protocol
>
> ~# cansend can0 5A1#11.2233.44556677.88
> interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
> ~# <0x001> [1] 05
> <0x001> [1] 05
>
> but I do not see the eight bytes appearing in the loopback.

It was a canutils versus can-utils syntax problem.

It is working well now.

Sorry for the noise.

