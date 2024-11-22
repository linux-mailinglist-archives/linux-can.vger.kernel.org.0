Return-Path: <linux-can+bounces-2177-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB4E9D6090
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 15:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255971F222D5
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F57E0E8;
	Fri, 22 Nov 2024 14:37:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AC13A3E4
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286227; cv=none; b=XVgfl0bquc202/r+HfW9TpWpWtAk+M9rey3Jb5cjMdz8EtXEmZV2Q+vKWGzVgC/UyT7O8qqDrOhf76kIvaXh+tpsNXfZCu76xGFDdzZZ+eA4S+XagMz2x8umQSYnhzT3Yz/fcH2K+KOlr/BpOvaKPH/q1TP3q9J7GDVmoKN5JMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286227; c=relaxed/simple;
	bh=tpxFAZkyZspcgy8QnHv0cv67C1qduITx3cyu/nUuL3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWgpqTnHwdZmSAyKttoA5edSXyuX+A1MMsns/x5abtC02AbVwsnWfLVT+2BP2T8PmQmbP6etE+7VrUTrQppl05XfAeLRjFPAVSUIgtwNjonRVnQEgHWChvBz+zFDBNSDTWsqu+XgM9ptRhMt3j1eMpTcJE+UeL/eGcoiU5vqcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e377e4aea3so17242917b3.3
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 06:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286223; x=1732891023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZklfME25XvyzUVchjCMWUKA5GZeWxdi5x6GGSsPFFow=;
        b=MQO1fW4O9NiSRYurVlcNfSnyhFQuvCSh2Ovau6jdeCYmWu/v+8dKTWBijgEXkxL9Ai
         TFwd4+gG0isYMAimGG69FqTMqp48FmCyIWr4Z6CTSxge9qlOVlzN36DHyxetJP9K8O1C
         p7xqodi/Yd4esQ98hwPkjP1DTGxIkd5asYXZD856NsKrqfUNgjW6K0DQUEwiKQ3HFaTk
         fhhizLKxodyvouqZzkFPRP3LVianqfPbE8o359wIYEHEKZigZuJZzmhwROu/ipkYV672
         YM/mRmp29o70E8OLGsoze8GOcexsWAOohK87fvjusXj0rQQUJbSc8P8l2x2SZFIwK5C3
         7vsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrqXZVjjWAC8G14Wvlp7Gx6qWsP7Kj8mfa1OTCRASWUurDWOskTC56SPLJuRyJUadk6h4aAocO0hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPl+iv9LjMuU8iqyGDqv1S7JaMuT92bP3w+6Jo/XIp9dV1TfgV
	6ZPorbkNYSMZYxCUti/O0JcXwDMo75WE+tSXrrWjduayvzqPL2ON1WTX1PND
X-Gm-Gg: ASbGncv/gqkj3uqo8eyLzY4RfgwXK4G0w/nIvOP5T3vx0+DWQVnAzlY0Jb2ymzcXA7X
	5kbYMz+KXa/8GFHGefYIZBYN+bklLUho7Lnl7y8siKjwBz0DaGUQbPMVcYTGd7hZXl50N00OsTM
	MbgDLCqv/xXcy5+BS6JRMXVo5IUbiYhmPCxJk/YdNpRWS59dJQUVtRlGAgQECpKEmEHRmfBc8gP
	ZyV+1XZ5sTZppD6ChP/3I3ceOoJ/4s2Y/JAcKimMZhqIZl72UEZ+YwCVjQxEy6BVnNSp62Ua3o3
	lOAgcP99CD9Ckop9
X-Google-Smtp-Source: AGHT+IGfsI51G7ALadYulhhVtFzXIflVlPInUKckTAwpETwx3VTaKW+LLge8ZaDcIVZkT19fAkMVYw==
X-Received: by 2002:a05:690c:6c01:b0:6c3:7d68:b400 with SMTP id 00721157ae682-6eee089f2fcmr40115407b3.10.1732286222515;
        Fri, 22 Nov 2024 06:37:02 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee00823desm4712257b3.79.2024.11.22.06.37.02
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 06:37:02 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eebb54fc48so21333797b3.1
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 06:37:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWi2ec9MVxKaZrjAurn7ryZQszDzs8ZegjMrCA4OyUYpWEjXjVlxiUvF6cOzqr1rk9wS7RZ4Ir5818=@vger.kernel.org
X-Received: by 2002:a05:690c:4a0e:b0:6e3:453f:fbd5 with SMTP id
 00721157ae682-6eee0a4cd2fmr32735817b3.36.1732286221999; Fri, 22 Nov 2024
 06:37:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022130439.70d016e9@endymion.delvare> <CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
 <dcced72-7be1-b44-432a-dac2ad7f4cc6@linux-m68k.org> <20241121145017.33ca43f7@endymion.delvare>
 <CAMuHMdXU8tMPbHMDZmU=0xd-X6OqxO_3j=iLDR2XQ4q3URw2RQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXU8tMPbHMDZmU=0xd-X6OqxO_3j=iLDR2XQ4q3URw2RQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Nov 2024 15:36:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGFaa4Fj1ixNJiEtbsneweveb6oq80X2Xe9i0ZN4FVKA@mail.gmail.com>
Message-ID: <CAMuHMdUGFaa4Fj1ixNJiEtbsneweveb6oq80X2Xe9i0ZN4FVKA@mail.gmail.com>
Subject: Re: [PATCH] can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST
To: Jean Delvare <jdelvare@suse.de>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 3:33=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Thu, Nov 21, 2024 at 2:50=E2=80=AFPM Jean Delvare <jdelvare@suse.de> w=
rote:
> > On Tue, 12 Nov 2024 12:15:06 +0100 (CET), Geert Uytterhoeven wrote:
> > > On Tue, 22 Oct 2024, Vincent MAILHOL wrote:
> > > > On Tue. 22 Oct. 2024 at 20:06, Jean Delvare <jdelvare@suse.de> wrot=
e:
> > > >> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), =
OF
> > > >> can be enabled on all architectures. Therefore depending on
> > > >> COMPILE_TEST as an alternative is no longer needed.
> > > >
> > > > I understand the motivation behind this patch, but for me, as a
> > > > maintainer, it becomes more work when I want to do a compile test.
> > > > Before I would have needed to only select COMPILE_TEST but now, I
> > > > would need to remember to also select OF for that driver to appear =
in
> > > > the menuconfig.
> > >
> > > IMHO these are two different things: to get a working driver, you nee=
d
> > > to enable OF;
> >
> > True.
> >
> > >(...) to do (may be limited, i.e. may not give a working driver)
> > > compile-testing, you need to enable COMPILE_TEST.
> >
> > No, you don't *need* it. Enabling COMPILE_TEST is (or was) one way to
> > do compile-testing, but it was not the only way. Which is the reason
> > why it was dropped.
>
> You could still do it the other way, by enabling CONFIG_OF.

And you still need to enable COMPILE_TEST, to get around the
ARCH_ROCKCHIP dependency...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

