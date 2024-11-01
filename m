Return-Path: <linux-can+bounces-1851-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0DB9B8878
	for <lists+linux-can@lfdr.de>; Fri,  1 Nov 2024 02:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6941B22250
	for <lists+linux-can@lfdr.de>; Fri,  1 Nov 2024 01:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AE12C475;
	Fri,  1 Nov 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge4G7QvN"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0D126BF9;
	Fri,  1 Nov 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424441; cv=none; b=e6gk7bYsY+2XV19kRg34dgEf/09xjhiOGLWIoHn6ZabYvZkdPMhRej1MyHnOe25x5/0Htwr3UbwIZWoY2moC8h0phIEgEd/JMM4rJRLx7pJkwRVQsr5aRQPb2gyZrhqjKRbKKbvZNMrVVCjbZvASwXws2H7mxCbyxOs1nd5um1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424441; c=relaxed/simple;
	bh=cYghth004Y+ziI1BLYjIHoNPT69vX2DPR9UgmOHO1Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lO8c5P2oDnQQONGdn+lhHwG1zZR8DOHPALi5aBBPDJp9F7G8/lX+RpShR92LDO6YpepznVY1QR3+3vgP0E0g7kMSlqaCaTqFAoI77jcJc5B97BmXQfhThXBXggmGZlqSgLVVPZCWCdnk8lxYznmB5zdRPqlgV+F5rltmzRL3e/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge4G7QvN; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e30d517c82fso1481134276.1;
        Thu, 31 Oct 2024 18:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730424434; x=1731029234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7lAHS3y97L28G0aqvaaMnejRHt9hiLKd7Y1LDM5wK9g=;
        b=Ge4G7QvNm/sKujScEJWsThrAZDPKwg+rW3eZHf0sB5mF7mNwRS8jKWbthMDc8HzpyN
         tif9QgCjsG3Ptrd6Bun7vGlTY5AqQYf6Q7Wq4BacIlY2CsLZuL/pbsOCIIQGMjhzF663
         xxxuvgB0M1G2uJJ+4nn3u7xI2Rgqf9KJnhXgvGW94QqoOYiu9duxZktZuDUYN8BGQtGg
         cg0gnfVQXzHHWRTsdm0JebbtZ2iiA3dts5LhQf0fI7rfk3oZQh7cvzPyyAl3MWqjDrLW
         oiRhPIJ7yogsEFyjTcfcTmX8riLkDia8KrCrp+haNJM6IO1HLlbE6KeJ8F6hsDn31iH5
         NVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730424434; x=1731029234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lAHS3y97L28G0aqvaaMnejRHt9hiLKd7Y1LDM5wK9g=;
        b=Ez9R4Xkju+av9gZPscvVgyiqR7AAd2BYQ5bxlvmiHVNm0nDsgCE2IXNFt73C8B61j4
         zWehc5xJpa5nL4vq+pTf5xjiWplsQh5dztFwDthC4pE2Zg2ys0QAFbxd7p1BMu9mRjQa
         shgFVLvhZdm4ZiCL77v+0jnR+Bs4/vOXKCE2WQ0jz0a4bGzqiMq6ftchhc0HNMpRMm+U
         zDdljsPAOEzVJ5EysOZiso55O8nEXs14b66moakSn7XeuLaMwKYddUyJTWcC8zfiCu0M
         /AFax6sFtoMSoFGB6yAurfGBgpIqpliuEEKZr48f/EhRyv99O0sZY/aZwfiowgBb+EoP
         J0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeVymQQ0YCkoOIU7klKuDvvTXqwXHSujyYANoQ86LkjVfjz7l+HMM5tvbiUIWLnpQUp9xSv/5bYGI=@vger.kernel.org, AJvYcCWmIbO0zNay229M8bEQxBZx7x6dfKoXMkyc6APtB7IhelnokAFtbjFmwmFijqGT5rBmc180+G5K@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXywOAo47WMV63VbzOqYJr3pgwxAcuJPV3G1qMGA1OxFK3nrC
	byz14Y+8ZeioOQf1VIwouu6DmkXC83rjAANvsZozMfGLXwQLd+6baHN8Fsqd8FdGrE8wiZz63uv
	Fr0onWMcdXObZyVEIlfYbV/jwwHg=
X-Google-Smtp-Source: AGHT+IGgOyf/FE7RVpDG/63tQRhq0RMkbFVHW5BJNl4qMsmU0kjBVtbc36vacNxnK1zCbPGbHplDYswMI2TPIHpFJ1c=
X-Received: by 2002:a05:690c:dc6:b0:6e2:1626:fc24 with SMTP id
 00721157ae682-6ea3b87e144mr123565037b3.7.1730424434204; Thu, 31 Oct 2024
 18:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024085922.133071-1-tmyu0@nuvoton.com> <20241024085922.133071-5-tmyu0@nuvoton.com>
 <20241024-fluffy-fearless-wapiti-d48c1a-mkl@pengutronix.de>
In-Reply-To: <20241024-fluffy-fearless-wapiti-d48c1a-mkl@pengutronix.de>
From: Ming Yu <a0282524688@gmail.com>
Date: Fri, 1 Nov 2024 09:27:03 +0800
Message-ID: <CAOoeyxURx_bPkeetymUJ6v1Ne0CjEnX0wMm76q670SD-HbMwYw@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] can: Add Nuvoton NCT6694 CAN support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: tmyu0@nuvoton.com, lee@kernel.org, mailhol.vincent@wanadoo.fr, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Marc,

Thank you for your comments,

> > +static struct platform_driver nct6694_canfd_driver = {
> > +     .driver = {
> > +             .name   = DRVNAME,
> > +     },
> > +     .probe          = nct6694_canfd_probe,
> > +     .remove         = nct6694_canfd_remove,
> > +};
> > +
> > +static int __init nct6694_init(void)
> > +{
> > +     int err;
> > +
> > +     err = platform_driver_register(&nct6694_canfd_driver);
> > +     if (!err) {
>             ^^^^
> > +             if (err)
>                     ^^^
>
> This look wrong.
>
> > +                     platform_driver_unregister(&nct6694_canfd_driver);
>
> Why do you want to unregister if registering fails?
>
> > +     }
> > +
> > +     return err;
> > +}
> > +subsys_initcall(nct6694_init);
> > +
> > +static void __exit nct6694_exit(void)
> > +{
> > +     platform_driver_unregister(&nct6694_canfd_driver);
> > +}
> > +module_exit(nct6694_exit);
>
> Can you use
>
> | module_platform_driver(nct6694_canfd_driver);
>

I will modify platform driver registration to use module_platform_driver()
in the next patch.

Best regards
Ming

