Return-Path: <linux-can+bounces-331-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8685B969
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD841C212C6
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E71F62160;
	Tue, 20 Feb 2024 10:44:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FD36AF9
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425875; cv=none; b=sD8XpDxwRAZ4vW4n/Cf7dY+V73s9Oqd8ZEIiVqnDHdq/kHj1hxW2xZaxOWfjn4VRfXjxXZ9Tbx3HplhlV/mS8oWTJgvXnbFaJpgsSilamT/GBLlcuvWhgjTvz0DUuEMfJFRS6c9zaf5DQklzWtNzQwVYf7Z0FJ+AnZVw5GPNkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425875; c=relaxed/simple;
	bh=dwFkmnhy9WMh6rJ3/pAbghheCsYI4eM/IeWjw5jtVic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+54MNOCkbhDZpGarweo6AAq/fe0IfxHnktc/NIMWPN0vPnR1uzOFybNNpoaNEUVGGZnh0vZMnr4Vepvf9Tivr4k1sYjPC9CvfOtPuPgLuPxPu8nXNlN2Ip4Jcz8ssLtuYWtHvIXufjmZTNXF9AVwPzSRc7KMOIcNhHftKiHrGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-299540b4d18so1584282a91.1
        for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 02:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708425874; x=1709030674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X345QMf0Ug71RHCHQ6tQgHufaT6oYWAs5+IUi2clcEM=;
        b=m+7CvTMbLJ6TfTb/MnQMzUH5vFaz75uC1ufzWQbtfmGalDCpmkLyqtgB5uczpwKC4l
         sQllUkQk2I3Qtfd/POrmJgL7JaaYMGCwefKWa2MJHA9pj7HUhqL05UXBtbe8brpPsGuF
         aPvoscdqnVmy/Dp7zBH+Ensaj2d+ADsEckgiEnl7buYYZLdQ3ZbYfVp0cFZzI+CL7IX+
         qjRzBmSIv2jpj9OsZvdL7QGEKvht9WIAxwbI7wHtoZ/s+UfrJmgyT7BuPNVqAwxKGMM4
         /IeJhqKlSSriian0t3NBPBr2kslv6VJ9Q0dhlEmWbYdEKLhrh8+VogEpopGotw4z8vhP
         Gpcg==
X-Forwarded-Encrypted: i=1; AJvYcCUNE9qMBbqbnlfhlqFWC/ghUUCRaEyfk+Pbh9jKOSGmbJKKfSpL8gen1F+03Rb+hxGorJwW1Lya+FjCynMEQcVrLgCjMWp6qims
X-Gm-Message-State: AOJu0YzDcOqlH4FEyxTGgJ83N9r3JEi2a+TTWGdxhZwjGLCSJxdWTgFI
	mWvnKKYGNQQ/3XuPcMDSsRTvIbdqpzuqLpQeECbApglwJLeYZ/B9NJLlDfGHiypWpU8u5oIKQvC
	gw0AdnQo6WhVN1s2B+l2XHjb1d50=
X-Google-Smtp-Source: AGHT+IFrMXed0ooUM5eekvLA5oUkg8s2DsDaLntLyeZUMZVpNxAoe1zl+keRd8J9CXYw5PiLxJFYbUXcKLNJaHw1B48=
X-Received: by 2002:a17:90a:1c17:b0:299:595a:e64b with SMTP id
 s23-20020a17090a1c1700b00299595ae64bmr5088537pjs.44.1708425873661; Tue, 20
 Feb 2024 02:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
 <AEC70E89-BC6E-429A-B756-385ADC2B3E85@vanille.de> <20240219-contend-catfight-cd49fff06252-mkl@pengutronix.de>
 <8609D943-B86B-4584-88A1-984BD39E25D3@vanille.de> <20240220-cottage-neatly-832a106bc879-mkl@pengutronix.de>
 <CAMZ6Rq+fE7J=ndRAVRuBvpUNXS-5rDx1r5mZeEPTuKrtbjKYOA@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+fE7J=ndRAVRuBvpUNXS-5rDx1r5mZeEPTuKrtbjKYOA@mail.gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 20 Feb 2024 19:44:21 +0900
Message-ID: <CAMZ6RqJorVA8bgT11J4AMMHJs6Kj759QkMTyYMvUQq+uyGJUcw@mail.gmail.com>
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue. 20 Feb. 2024 at 17:35, Vincent Mailhol
<vincent.mailhol@gmail.com> wrote:
> On Tue. 20 Feb. 2024 at 17:10, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> >
> > On 20.02.2024 08:49:26, Dr. Michael 'Mickey' Lauer wrote:
> > > Hi Marc,
> > >
> > > >>
> > > >> Sounds pretty cool. Our design is based on an ESP32-S3 though, so =
I
> > > >> have to duplicate that effort. Is there some kind of USB protocol
> > > >> definition for what gs-usb expects or do I need to learn that from=
 the
> > > >> implementation?
> > > >
> > > > I've put together a very rough summary of the driver's side of view=
:
> > > >
> > > > https://gist.github.com/marckleinebudde/99f72d9db67accf08cc6efa367c=
fe54b
> > > >
> > > > Feel free to update.
> > >
> > > Wow, that=E2=80=99s very kind of you!
> >
> > :)
> >
> > > Later this year I=E2=80=99ll take this blueprint to implement the nec=
essary
> > > changes in our firmware. I=E2=80=99ll enhance / update your summary
> > > as I=E2=80=99ll go.
> >
> > If you discover any odd points or areas for improvement in the USB
> > protocol, please let us know.
> >
> > Currently, TX-complete sends the _entire_ structure back to the host,
> > which is quite an overhead, especially for CAN FD frames. We're working
> > on a "short-tx-complete" feature.
>
> The es581.4 may be doing what you are looking for:
>
>   - When sending a frame, the driver attaches a 32 bit index:
> https://elixir.bootlin.com/linux/v6.7/source/drivers/net/can/usb/etas_es5=
8x/es581_4.h#L78
>   - When receiving the TX completion message, the device just send
> back that index and a timestamp:
> https://elixir.bootlin.com/linux/v6.7/source/drivers/net/can/usb/etas_es5=
8x/es581_4.h#L97
>
> The device is agnostic of what this index represents. The driver uses
> the index from the can_put_echo_skb() / can_get_echo_skb().
>
> (in addition the driver can handle bulk send and receive but that's
> another story).

I forgot to mention: it is also perfectly fine not to use the index as
long as you can guarantee that the TX completion messages are received
in order (which is not hard to achieve). In which case, the TX
completion message can be as simple as just a timestamp.

Yours sincerely,
Vincent Mailhol

