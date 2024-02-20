Return-Path: <linux-can+bounces-316-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8194985B554
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 09:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDA42804D9
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365615C5FD;
	Tue, 20 Feb 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSX8GcFQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01715B1F1
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418147; cv=none; b=oySxExcknnCtCbF7f8imOcQsm8CAq7GKFPu7qk182vn55CmsbpxWI2bbVAe/+TqnklrcNPlAsSWkwLQIeHPJWfnwDx0qnpUHBYR4YPpnxroxSB9snHPqnnXBeTgwj5ZjXoU4N0CYs3c/PYDWjwlAsmGlzQGF4oNO2sNI+qyvAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418147; c=relaxed/simple;
	bh=6xYlLhQGBr9fcbX6DMGFqm1p9L+RPB5oxdWqbHFq030=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP7OdWuwTHwbjWIsRRXA1n+j5mQxAfs6zfjNgR8GYBqNYQJw6qlVYiHpF/iBFkYtzom7AKJ2PSHUYxwO3ateBXYL4sQ4Zrzzr8RUehkoUP+QDiDRZkKVqgQdM4gHwJpkQ+hl3S0uCiAyu1JnVeGLPQiRRSkosKcpP1MF5yx6fu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSX8GcFQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso2713850a12.3
        for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708418145; x=1709022945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPH324QJzF4D7rLAELdXBne0AUGf13CF2WXP872CM6o=;
        b=CSX8GcFQleqjzpAUWeGwjju6X6Bt9S01aia4vRJRr41wqKgQfmquJUUKUHprXp+n2n
         o3qvrhZksgVeQphXLOnzZ4YTWJG1Fy5bnXGcimbXsMnSRtwogJvpxFAokPwuz7UyBmEC
         JOEf1SnnUSm09fKu9Bb4mzRgnbnZmCZSrmmvZ5+OKQuPOrMn+WOkfq6YirjS326G5tyo
         S2cb+veZg/NiKPIg3dA4NQtU6TXFLXHWFQ49ZxwJwpv0GMqd1DdhkaOmthmIHJ8GtU/7
         VlyXcEX8Ch6lJhwDJZXfMpJSZcko4c2qf4LtvZTdVE5f9qnhbHGpmMvts3Mq1GfUwbXG
         Uoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418145; x=1709022945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPH324QJzF4D7rLAELdXBne0AUGf13CF2WXP872CM6o=;
        b=nOhD16DA3eNrQ3jt63vi2vaFT1dYVMhIgA5otwphQMexarMpFizryJ1v/w7tpqt+1i
         /yA13UaVDUr1xwn8WmwfM51W62h9/IvBkF9tVF4zD1eYM08xxlDo34ETLJndzkEQ3s8X
         1KPejdxxSs1HeW0MEEExPBYvwqbkR8B+32+bnKuZfjTDbp8vGypQZL36jvB7+69M6BAz
         OckLaISBPZxRxhI7kD0axsdL6j88wpgc2fmPEGTYV2BZOo6Dv9TyVuVrPxJim85Kp2lB
         akR/+Cw91XASEST/llrzYWEXbf3qbjz+ak8CoQFG2DrEHo5R6BSHI513E8A6JL7n97V3
         oAJA==
X-Forwarded-Encrypted: i=1; AJvYcCXymb1LHSc0i4QxdZYb3Vsde9iJhEw398CueUsI9rZJlAmHdSMKn0k8PVRi1g/cRnupoXZIeu8yC8XTC9L9aCCwdmyW1PDekaQi
X-Gm-Message-State: AOJu0Yym/M4amQVrv/7G1HL6b5+OVSO0uu7ze+gNHD0PDeM3BF1kXvAd
	6CQsTu+Zh3KUUyEHxB7gfO+ztu3OVba2F0GxAe12aGJwys7/IW/hLmFlAkhtwQ7qPrVz9j6faih
	3dopsXQAHuz8OJylC1lG2RxBI8I4=
X-Google-Smtp-Source: AGHT+IG74wVtiyEuRWteZerL77QYGk7TGhTwEexSbl+02s9hLnJpOmvPp9360xv6i658s599zVkCbtuLBTKhNGHsTQY=
X-Received: by 2002:a05:6a20:c90a:b0:19c:ad6b:e1c2 with SMTP id
 gx10-20020a056a20c90a00b0019cad6be1c2mr15165045pzb.12.1708418144883; Tue, 20
 Feb 2024 00:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
 <AEC70E89-BC6E-429A-B756-385ADC2B3E85@vanille.de> <20240219-contend-catfight-cd49fff06252-mkl@pengutronix.de>
 <8609D943-B86B-4584-88A1-984BD39E25D3@vanille.de> <20240220-cottage-neatly-832a106bc879-mkl@pengutronix.de>
In-Reply-To: <20240220-cottage-neatly-832a106bc879-mkl@pengutronix.de>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Tue, 20 Feb 2024 17:35:32 +0900
Message-ID: <CAMZ6Rq+fE7J=ndRAVRuBvpUNXS-5rDx1r5mZeEPTuKrtbjKYOA@mail.gmail.com>
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue. 20 Feb. 2024 at 17:10, Marc Kleine-Budde <mkl@pengutronix.de> wrote=
:
>
> On 20.02.2024 08:49:26, Dr. Michael 'Mickey' Lauer wrote:
> > Hi Marc,
> >
> > >>
> > >> Sounds pretty cool. Our design is based on an ESP32-S3 though, so I
> > >> have to duplicate that effort. Is there some kind of USB protocol
> > >> definition for what gs-usb expects or do I need to learn that from t=
he
> > >> implementation?
> > >
> > > I've put together a very rough summary of the driver's side of view:
> > >
> > > https://gist.github.com/marckleinebudde/99f72d9db67accf08cc6efa367cfe=
54b
> > >
> > > Feel free to update.
> >
> > Wow, that=E2=80=99s very kind of you!
>
> :)
>
> > Later this year I=E2=80=99ll take this blueprint to implement the neces=
sary
> > changes in our firmware. I=E2=80=99ll enhance / update your summary
> > as I=E2=80=99ll go.
>
> If you discover any odd points or areas for improvement in the USB
> protocol, please let us know.
>
> Currently, TX-complete sends the _entire_ structure back to the host,
> which is quite an overhead, especially for CAN FD frames. We're working
> on a "short-tx-complete" feature.

The es581.4 may be doing what you are looking for:

  - When sending a frame, the driver attaches a 32 bit index:
https://elixir.bootlin.com/linux/v6.7/source/drivers/net/can/usb/etas_es58x=
/es581_4.h#L78
  - When receiving the TX completion message, the device just send
back that index and a timestamp:
https://elixir.bootlin.com/linux/v6.7/source/drivers/net/can/usb/etas_es58x=
/es581_4.h#L97

The device is agnostic of what this index represents. The driver uses
the index from the can_put_echo_skb() / can_get_echo_skb().

(in addition the driver can handle bulk send and receive but that's
another story).


Yours sincerely,
Vincent Mailhol

