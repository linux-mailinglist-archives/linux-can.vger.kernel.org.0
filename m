Return-Path: <linux-can+bounces-1727-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF6C9ACF4A
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 17:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70F3285B6F
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CF6194136;
	Wed, 23 Oct 2024 15:46:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B111459F6;
	Wed, 23 Oct 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698414; cv=none; b=o/We7BLOGyiEVK8cOHdD1VT9mEYqnzuCbHchhEib830/myD5DcrxpFkIUhy3SPil0fW3+SjgmqtA/sxQ7LMB/rwRNjN8pi8shiT0BrYZzEPe7fF+Jajvp4pfkap67ctnJAzgIx3Hq/9/sJ0sgdIZNb+P18EFuxtKzuMtjXtqUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698414; c=relaxed/simple;
	bh=24+A/iKYNwWBfvwaamQmtWQqnxBbYPkU5zjNtih52Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqAoXtg3EwmVncj1jhV1a/ECfOxKb12ehVeb84uiqs1Tb7ptn7jxRK8LVIujL2xn0mtq/c1fg/vqnMhGKyTlD9/mnnrP2I5zrPMgtS6tziY84JCp+jjfxD7lIJZingYR/oRDmM8I5v3kS4Xmb4brGzRk0LeC7XSJEadVRcDNW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a998a5ca499so863894366b.0;
        Wed, 23 Oct 2024 08:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698411; x=1730303211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0upAi2q6hqqNZ1hnfV6xocUBNjrm/BnItwCJeqD0so=;
        b=rhIHGLLvAuz/rDKZQXE5Q7pgUYmHvNmYfwjUsYTJSP8qyd/J8IkltOYFUjHT+cJHY/
         quNJt6ZkbHzUCNgSemGkY3vc0eKnr26qyXK064Cw3h0JgMR7BLgHPrTn0unMxtJsQNek
         dIaMke3AKzU6KSGFg9tOl9+HRKqcR7gN1sqoFj6Hjyl7evTcCNHZ6P25MBgjOYGHYfuc
         QfYPvm0toFC2s7PUQ9UTuqZtfx2qUk5fa3p12Lpa12GQ0D353SY/UwtpJeU3uY6uQk4r
         uXJGLu5LSBrIcTnPjCMC+SOoUylPIWHT3dMzEzcFLVI8sKCJKRXof92P8cvDGS7yPqaY
         aF+A==
X-Forwarded-Encrypted: i=1; AJvYcCUCH6d9xip0OlMR4oSfiIG1+2oYxd3RjqtwimNkF/jGRVRI58I5Fre8FF7Els0TXgKh/TBzYXFpowU=@vger.kernel.org, AJvYcCUJxrjSaiCKk2r1UGPNT176K8tPYso9nM/oFJsWc9BWwlqgWVrA49UhTa/JQw4xvpwm/ppT/oRr/BORftt/@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkFpvlnACCPU9/NgHYppVZtuNauEYuXNU7xdAkSpjdhoFk4Uj
	gOAETV9jOsyTFeNt7ccZdJIJc5S/N5m32o+Fgb/qCHaOqgjmY0LQcmldZvZPYn9hoeC8kEqzz+n
	eWPXRnVvGXbO8e3s9+KWws0AKaeM=
X-Google-Smtp-Source: AGHT+IEvY9jOTsuo31i+dj1TksHSx2w+8IHJce+Az/8F9dC/uINzkvHecGhxI+66KmoweabfqZuj7vKPzhnL4joiQvw=
X-Received: by 2002:a17:907:3208:b0:a99:4ca4:4ff4 with SMTP id
 a640c23a62f3a-a9abf87fc14mr223600966b.23.1729698410413; Wed, 23 Oct 2024
 08:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023145257.82709-1-alexander.hoelzl@gmx.net> <306d6221-3cfa-4268-89f4-9331d69287e7@redhat.com>
In-Reply-To: <306d6221-3cfa-4268-89f4-9331d69287e7@redhat.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Oct 2024 00:46:39 +0900
Message-ID: <CAMZ6Rq+VxBCyOiyWMFLHr+Dt945ceg8r0sW9wP_ZEJuMve8RTQ@mail.gmail.com>
Subject: Re: [PATCH] Fix error in J1939 documentation.
To: Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?Q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>, 
	robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, corbet@lwn.net, 
	kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu. 24 Oct. 2024 at 00:29, Paolo Abeni <pabeni@redhat.com> wrote:
> On 10/23/24 16:52, Alexander H=C3=B6lzl wrote:
> > The description of PDU1 format usage mistakenly referred to PDU2 format=
.
> >
> > Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> > ---
> >  Documentation/networking/j1939.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/networking/j1939.rst b/Documentation/network=
ing/j1939.rst
> > index e4bd7aa1f5aa..544bad175aae 100644
> > --- a/Documentation/networking/j1939.rst
> > +++ b/Documentation/networking/j1939.rst
> > @@ -121,7 +121,7 @@ format, the Group Extension is set in the PS-field.
> >
> >  On the other hand, when using PDU1 format, the PS-field contains a so-=
called
> >  Destination Address, which is _not_ part of the PGN. When communicatin=
g a PGN
> > -from user space to kernel (or vice versa) and PDU2 format is used, the=
 PS-field
> > +from user space to kernel (or vice versa) and PDU1 format is used, the=
 PS-field
> >  of the PGN shall be set to zero. The Destination Address shall be set
> >  elsewhere.
>
> You need to CC netdev or this patch will be lost,

linux-can is a sub tree of netdev. This patch has the linux-can
mailing and all the linux-can maintainers in CC, so it will not be
lost. It is true that according to the process, netdev should also be
put in CC, but for a patch like this which is really specific to the
CAN protocol, I think it is acceptable to omit netdev.

Regardless, thanks for your comment!


Yours sincerely,
Vincent Mailhol

