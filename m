Return-Path: <linux-can+bounces-2727-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5490AA2749A
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 15:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D9E188579B
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50236213E7A;
	Tue,  4 Feb 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJc9J5vX"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35046182B4
	for <linux-can@vger.kernel.org>; Tue,  4 Feb 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680108; cv=none; b=rJ4H0rrQ3TLKpdWU7rDFnMcgGq7tcEr4OjZF29aU1BLbWwWIRvsYj7TpSKIKj4EVJh1mWLAi0ok8q7rEVmZd4cn/9cAaGl83L4oS8hnjWLKytxBK1gyRFSlADcSLFiOnLtmd8wvsojJ5uXpYgVyz6zcFnELWRMTNoBI4k6rHQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680108; c=relaxed/simple;
	bh=ZOltCrwlKRi5Vioy1yls9srdUkkAMZ031oSIm6snxmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BX8x15JxARq2jOEeFDlGwa35iK+tykU3UcRgTr8fBeZEk9iBCBAjVVG6AuwIfHut6WmhQkHuPstD2H+w+Inqq6MaSGdHOq/RLCzj9V3BDX2TUEW7lfl1uh8ayqQsinBznc+o+5p2kbsOVAXCJHwfzLc6flQMtuWWVISRyxd2KWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJc9J5vX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so10158237a12.1
        for <linux-can@vger.kernel.org>; Tue, 04 Feb 2025 06:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738680104; x=1739284904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUTYzoysUHn/B5DnDNoUBQM+pTbRPbNintFI7UBBYFc=;
        b=YJc9J5vXDYaF6WPYLwUrAc53tT1xoI+xdDmgptamJZBOxav4CPi9vXyDwN4mqd+pgF
         vTZu0MEtmH7lYMEwMeSARYnBe6AZZUHg9q65U5ueX8caT3FGmODkS1drjFjFpdUvmqal
         Ee5X0qgoe5wZyltJFtHzS0zBlsjEY2r0RkLUz8Q51X8BP0P6SPciedcaRbQKnWG9jzr+
         Y8N8HyzFWh+VNGTUQKETV7gcSifs0bJ0z197Pio/2ik4uh/93/uE2rnIy9Eyn9QtZ4yy
         XU49e1C7Yp7x31Yzlis651nDLyhdIMiUKxEeA32IVFFIK8uc5Dn9xNfkhQPDswE5AM44
         raMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738680104; x=1739284904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUTYzoysUHn/B5DnDNoUBQM+pTbRPbNintFI7UBBYFc=;
        b=vDCrio+0XZDbGiKTBX1dYmcBE0P/K86yJJ51VJwdd9dY+bWptrCA38WnbGpIUVEOIh
         AxkUxY8ZDw60ylS3AePjakQ+xHHSG6LW+1HNsG3iSNdW7WVe0GqP39i9hGPs2jrBYR+A
         FzMEGxxPWjqB9RkdUthTqwU6m52GbyDcGd67up6gx1ILzukkekW8rZJUeOZtJAd6I90z
         ecxGDdtvMaaivoG1o73ACi+Mr+oYEp7fTPGeofoZoZngmQjBd6vJRHXXvH9J4EvgeCxK
         3v4dUaBYEOP2K2AIukSn3YSuzySzjIjCLrnoG0LBXDtD0U889GPmWCyoMPqz6kawxnmb
         yy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdpiUuCtcFdmWacbGAOmi1ToYCeRo53x0A/S/yRHF4Et3Ki3zp4mVsASzZ4nmJbbEYqYmhr5jtUVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvUBn/afh3Q5KYWDDwPrgYkVMwv7yrPJx/GelvmNaOqePB7mlA
	9PCyJhoAVL0T/fpopYs9YuWdDj+S7Bv0QPp8aHnXEdVGrqbHG0HA7jd33Qzyn7pQ3Kv/RF/Ru1q
	Au5zCDT+eOhv+PlCXR7L7/TZMKjL3nvPzGLuy
X-Gm-Gg: ASbGncupdHpn2yxVEA6vvYMG409hUcgPVnTTRXg+G+bBYvwMtyDw4UwFwcHxvpsWDo7
	JFPGGKkH3cN/31susalMl6BE6bYi6ysS5uqHbeoPFdQRCd72dvXucO5UKVGlTBX6JCMNpOQ==
X-Google-Smtp-Source: AGHT+IFdTSbfOgIGSfbKrBRiCzWFQxamnmRADI3W81hHAqW8HyUgT4lUIjGULwW1dENFd9LKs+JXE8OHQsbb2D/bdTQ=
X-Received: by 2002:a05:6402:5191:b0:5dc:cd96:49fe with SMTP id
 4fb4d7f45d1cf-5dccd964bd2mr2224365a12.21.1738680104302; Tue, 04 Feb 2025
 06:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY8P300MB0421E0013C0EBD2AA46BA709A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
 <b25b21b2-c999-4f21-9ad0-30113b4c655d@wanadoo.fr>
In-Reply-To: <b25b21b2-c999-4f21-9ad0-30113b4c655d@wanadoo.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 15:41:33 +0100
X-Gm-Features: AWEUYZnBlQ_eJ24CjL9TvNq15WN6n1fPhKiehmRNfwdUf7L5SJOMC4s_sJ-MK_M
Message-ID: <CANn89iKVKx8CMz_H65U+HzsY=ef8k=8T6a9dpQ7nHHv0+Cxwfw@mail.gmail.com>
Subject: Re: general protection fault in devlink_info_serial_number_put
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: YAN KANG <kangyan91@outlook.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jakub Kicinski <kuba@kernel.org>, "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:09=E2=80=AFPM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> +To: Jiri Pirko
> +To: Jakub Kicinski
> +CC: David S. Miller
> +CC: Eric Dumazet
> +CC: Paolo Abeni
> +CC: Simon Horman
> +CC: netdev@vger.kernel.org
>
> On 04/02/2025 at 16:44, YAN KANG wrote:
> > Dear developers and maintainers,
> >
> > I found a new kernel  NULL-Pointer-Dereference bug titiled "general pro=
tection fault in devlink_info_serial_number_put" while using modified syzka=
ller fuzzing tool. I Itested it on the latest Linux upstream version (6.13.=
0-rc7)related to ETAS ES58X CAN/USB DRIVER, and it was able to be triggered=
.
> >
> > The bug info is:
> >
> > kernel revision: v6.13-rc7
> > OOPS message: general protection fault in devlink_info_serial_number_pu=
t
> > reproducer:YES
> >
> > After preliminary analysis,  The root casue may be :
> > in the function:  es58x_devlink_info_get drivers/net/can/usb/etas_es58x=
/es58x_devlink.c
> > es58x_dev->udev->serial   =3D=3D NULL ,but no check for it.
> >
> >  devlink_info_serial_number_put(req, es58x_dev->udev->serial) triggers =
NPD .
> >
> > Fix suggestion: Check es58x_dev->udev->serial before deference pointer.
>
> Thanks for the report. I acknowledge the issue: the serial number of a
> USB device may be NULL and I forget to check this condition.
>
> @netdev and devlink maintainers
>
> I can of course fix this locally, but this that this kind of issue looks
> like some nasty pitfall to me. So, I was wondering if it wouldn't be
> safer to add the NULL check in the framework instead of in the device.
> The netlink is not part of the hot path, so a NULL check should not have
> performance impacts.
>
> I am thinking of:
>
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index e015ffbed819..eaee9a1aa91f 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1617,6 +1617,8 @@ static inline int nla_put_sint(struct sk_buff
> *skb, int attrtype, s64 value)
>  static inline int nla_put_string(struct sk_buff *skb, int attrtype,
>                                  const char *str)
>  {
> +       if (!str)
> +               return 0;
>         return nla_put(skb, attrtype, strlen(str) + 1, str);
>  }
>
> Of course, it is also possible to do the check in
> devlink_info_serial_number_put().
>
> What do you think?

Please fix the caller.

nla_put_string() is not supposed to be called with a NULL str.

Next time, we will have someone adding a test about a NULL skb.

Adding such tests could hide real bugs.

Thank you.

