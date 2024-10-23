Return-Path: <linux-can+bounces-1723-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE5A9ABDBD
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 07:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1924B1F23FC2
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656216CDAF;
	Wed, 23 Oct 2024 05:20:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DAB1420DD
	for <linux-can@vger.kernel.org>; Wed, 23 Oct 2024 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660824; cv=none; b=P0sDJUBhfFhVzz1TBUBxQgqzNP4w6bakklFBfWkzthXgFunx2viZT9s/zO9fsEUTOd4EtVN0o1Dt6GMIpKqPAkF3Mc5scnYou9m+9G2G8Pq7W8SMsm1D30ycmqff2HVq9nPxkdCn1MlntIf4RUKAnpHh+wRzO+fGioqlPplrr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660824; c=relaxed/simple;
	bh=mZHO7McgDoot11siwLwihHIMi7zvIHn97FFlgFWybmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXT1Jv9U1g5K45MszGiwG0lPV75BUfLmQqG3Up9z8A0b6KyYzi1kNpI/0mh4QzksaKU4iaTB3x1P0k0aeASg4ozxC0JabaTsYqIftzmqq6wTd3tzEEvyLyzeMFoB9CifpcmLR3NuxUYbi6BZb5wWeVIbF2QXRFX0OYHntZDuPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a3da96a8aso82898566b.0
        for <linux-can@vger.kernel.org>; Tue, 22 Oct 2024 22:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729660818; x=1730265618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vttdv05ukNJXWfKoGW79dh8n0P/fXNH48irKipOJ8xk=;
        b=LII1MaNGdzyhu5QcPnwk08CSanN8qShDOm6JNxRMzZsjt+C1vEvxJYZeU/aQUZ5AIT
         Xr3Dx0ualMCPJnoH9IEJQ5eTtfLgEGlj4txJeb7Zhkdg2xu/hyTMzkBEAxbVBbvw16XP
         nEH1zMQNpqySujsJk4AKP0ZPf1a0OVgnvcd4V8vKEC3xxf0XHSWfO9JQy7pm2QhXATd7
         m642AURu0KIrrmwvt2oakC155dBMihRSXCknbNDbjr1rcPwV+kDY7WWMSI4Rb0Kj1dqG
         uwQQPZgMJEwPVWlsyHZ57jwTiVzdL8Mj3LmdQq3bUMlwtU6EL89tVPLsy6SZ8l0lSOHk
         nt3A==
X-Gm-Message-State: AOJu0YyTiqajJjTMWIn6gkH5XJodcGAYHxbVBNEapFEm45f5olkj7GGD
	E+ckiILUzJaA0jRpO7akGOFsMvg/l94Stiw4FY1FbkWESqo+My4HPm7tcmrlXcWKu+MA+HUB+pz
	U4rJSFD21HVb9o9aSBNaUKDDZwdI=
X-Google-Smtp-Source: AGHT+IEY8aKsPk+EnoEvrasr5+XbUxcX9nRdCWkYDlH1e7Dt5ijXWuZG6B0z+0D4WGf6qR1Dgwuvy0c5D0YRNG69VUY=
X-Received: by 2002:a17:907:7e8f:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-a9aaa53a5b6mr650458566b.17.1729660817895; Tue, 22 Oct 2024
 22:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022130439.70d016e9@endymion.delvare> <CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
 <20241022190430.46c9b311@endymion.delvare>
In-Reply-To: <20241022190430.46c9b311@endymion.delvare>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 23 Oct 2024 14:20:06 +0900
Message-ID: <CAMZ6Rq+oA_NC8jVB8UA_PyQfLpEo_uLAbAooYWXA-Xsy=RBqaQ@mail.gmail.com>
Subject: Re: [PATCH] can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Wed. 23 Oct. 2024, 02:04, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Vincent,
>
> On Tue, 22 Oct 2024 22:22:05 +0900, Vincent MAILHOL wrote:
> > On Tue. 22 Oct. 2024 at 20:06, Jean Delvare <jdelvare@suse.de> wrote:
> > > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), OF
> > > can be enabled on all architectures. Therefore depending on
> > > COMPILE_TEST as an alternative is no longer needed.
> >
> > I understand the motivation behind this patch, but for me, as a
> > maintainer, it becomes more work when I want to do a compile test.
> > Before I would have needed to only select COMPILE_TEST but now, I
> > would need to remember to also select OF for that driver to appear in
> > the menuconfig.
>
> Not sure what your typical process looks like, but if you need to
> test-build drivers on a regular basis, why don't you have
> CONFIG_COMPILE_TEST always enabled? Switching back and forth must be a
> hassle.

The point is that I do not need to test build all drivers on a regular
basis. The CAN subsystem is a small tree with not so many activities.
And this OF thing is a pitfall (in which I have fallen into it in the
past=E2=80=A6)

> About CONFIG_OF, well you probably want it enabled regardless. For one
> thing, there are at least 940 drivers in the kernel tree which depend on
> OF, so you are already missing a lot of test build coverage if you have
> it disabled.

The CAN subtree for which I care has only four drivers with OF, only
two of which are not automatically selected by COMPILE_TEST:

  $ git grep "depends.* OF" drivers/net/can/
  drivers/net/can/Kconfig: depends on OF || COLDFIRE || COMPILE_TEST
  drivers/net/can/Kconfig: depends on OF && HAS_DMA && HAS_IOMEM
  drivers/net/can/ctucanfd/Kconfig: depends on HAS_IOMEM && OF
  drivers/net/can/rockchip/Kconfig: depends on OF || COMPILE_TEST

> For another, if test-building a driver which would normally depend on
> OF, but with OF disabled (as you do for rockchip_canfd at the moment,
> as I understand it), then you may not be building the full driver. Part
> of the code could be stripped out at build time because the compiler
> notices that it is unreachable. Apparently this isn't the case of the
> rockchip_canfd driver though.
>
> > Well, I am not strongly against this simplification, but, wouldn't it
> > be good to make COMPILE_TEST automatically select OF then? Looking at
> > the description of COMPILE_TEST, I read:
> >
> >  If you are a developer and want to build everything available, say Y h=
ere.
>
> As a side note, I don't think this is a proper description of how to
> use this option. If you "want to build everything available" then what
> you want to do is "make allmodconfig", not manually enabling all
> drivers in "make menuconfig". The purpose of manually selecting
> COMPILE_TEST would presumably be to test-build a specific driver or set
> of drivers.

Ack. It would be helpful to rephrase that description.

> > So having COMPILE_TEST automatically select OF looks sane to me as it
> > goes in the direction of "building everything". If this makes sense, I
> > can send a patch for this. Thoughts?
>
> My initial reaction was that this would be an artificial dependency,
> which seems wrong.
>
> However, considering that the purpose of COMPILE_TEST is essentially to
> let the user build drivers from other architectures, and that enabling
> OF on an architecture which doesn't have it enabled by default
> essentially lets you select a whole lot of drivers from other
> architectures... I must admit that both options indeed share a
> purpose.
>
> But I still have a concern. Some drivers can be built with or without
> OF (they support both OF and non-OF devices). If someone wants to
> test-build such a driver on a different architecture (and therefore
> must enable COMPILE_TEST) and wants to ensure that it builds fine with
> and without OF, then if COMPILE_TEST selects OF as you suggested, they
> would no longer be able to test the CONFIG_OF=3Dn case.
>
> So I'm afraid we can't actually do that.

Ack, this concern seems valid.

Thanks for your time and your good explanations.
I guess it is now my duty to not forget anymore to also enable OF when
doing compile tests. With this said:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol

