Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74759161E1C
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2020 01:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgBRABp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Feb 2020 19:01:45 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:34741 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgBRABp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Feb 2020 19:01:45 -0500
Received: by mail-qv1-f42.google.com with SMTP id o18so8371449qvf.1
        for <linux-can@vger.kernel.org>; Mon, 17 Feb 2020 16:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nq+1TZ0LMSRI8+UgzPCOaM/EnVKdG3O4GIEDDwRN/fI=;
        b=HhFhNJ90Fx1ZzQPw4AzP1WLiYq/LMHrWsEPDUHrBzds/xi3EWjHyV0WAXmU39nWY+W
         zcbGMzQrMJCjEOmWpV8eS2ZoLIe3eZDyb6nI0qJqVPpUYnwcAz1vF7mNOSmgwx9laCXc
         0X2T60GucWaEVBn1yMHFBZZmOZ9GznnB4s0Xf8FNX5MGbYJUYfXC3YEbpONXNv2t5sQT
         jRVEr4nsCJcmZzBfE3WaDF4J1LwoPeUQNpM+e8L+ysnIlTmJtnJVmUu2BmFzSpkbtive
         HxDoQicWK0dZwt9tUvgiQ4ypHVaw4p79IqHrH5DTywdXvwThzpH3Uv4LXO2kmss1TI5P
         6uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nq+1TZ0LMSRI8+UgzPCOaM/EnVKdG3O4GIEDDwRN/fI=;
        b=NxozPeXsJxXbLzK1xp9whDyk6axNa+N9n0rQxhH4vapkEz+WEVQbZTn2Tumvp5T3yb
         1SoVyS403+0X/Gjf3n8H+OMpt07plJKwBTiMVkKDwRS5AETxKdK4gXgvUCBsPLiRlL0l
         iSzUL0+RJMeEB/MFwDv1X/cTc0NsUmmkwHGbfuBdHG4kwNwovWdIxPYUBuk2sGvRIv9D
         3fG3j0sGiRvC0vwkqx5v7n+CDUsjXJRiDrAm4WqB1p5OzBEdLVhWGHFMVbFWvilvdJ3q
         NrzMqbVkfM7lluH3qU+W5wQ6Plz2EGo3XM2mnacuYPuG92/lWhhYHK29ITr8j6RHGbaK
         JbFQ==
X-Gm-Message-State: APjAAAU+b/iWEU2hXEdxHvhiSXX0lzxu4QlAktyxx2ooOzcaw7PGKFqJ
        sdnwVZsSZTeyyHAPvMSEzqtN8Rl+xJI=
X-Google-Smtp-Source: APXvYqzK3ey9W/yv6Topb/vaart+sed2ez2GvyukGhUI+ZDFXxf2+08vq8hoZhZmiWooXtGFEZI7kQ==
X-Received: by 2002:a05:6214:524:: with SMTP id x4mr14872120qvw.4.1581984104404;
        Mon, 17 Feb 2020 16:01:44 -0800 (PST)
Received: from ?IPv6:2601:18c:600:dc42:50c1:d3ea:3e78:114? ([2601:18c:600:dc42:50c1:d3ea:3e78:114])
        by smtp.gmail.com with ESMTPSA id w9sm1071591qka.71.2020.02.17.16.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 16:01:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: canfd through slcan via SocketCAN
From:   Chris Morgan <chmorgan@gmail.com>
In-Reply-To: <ca7db9dc-991e-e2f7-a3a7-dc13a0880581@hartkopp.net>
Date:   Mon, 17 Feb 2020 19:01:42 -0500
Cc:     linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <81FEDC66-54A7-4B53-911E-80122446A453@gmail.com>
References: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
 <ca7db9dc-991e-e2f7-a3a7-dc13a0880581@hartkopp.net>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

HI Oliver.

> On Feb 17, 2020, at 3:16 PM, Oliver Hartkopp <socketcan@hartkopp.net> =
wrote:
>=20
> Hi Chris,
>=20
> On 16/02/2020 14.43, Chris Morgan wrote:
>=20
>> I=E2=80=99m looking at options to add canfd support to embedded =
processors via serial using slcan. I=E2=80=99d like the devices to be =
available via socketcan. Looking at the slcan driver it looks like the =
MTU is something around 30 bytes and there isn=E2=80=99t any mention of =
canfd in the driver or in the userspace utilities. Am I missing =
something with this support? If slcan doesn=E2=80=99t support canfd yet =
is anyone working to add any?
>=20
> The slcan driver implements the SLCAN aka Lawicel protocol, originally =
provided by http://www.can232.com/
>=20
> See documentation at:
> http://www.can232.com/docs/can232_v3.pdf
>=20

This is super helpful, thanks for the pointer there. I didn=E2=80=99t =
realize so many letters were already in use but it looks like there are =
some openings in the protocol.


> Other low cost serial CAN adapters adopted this simple protocol, see =
this overview:
>=20
> https://github.com/linux-can/can-misc/blob/master/docs/SLCAN-API.pdf
>=20
> By today there is no CAN FD capable CAN interface using the SLCAN =
protocol on the market!!
>=20
> You would need to set a second bitrate (data bitrate) and you would =
need a separated data frame identifier for CAN FD frames.
>=20
> Today:
>=20
> t/T -> Classic CAN data frame
> r/R -> Classic CAN rtr frame (not in CAN FD)
>=20
> According to the above documents we would been able to use:
>=20
> d/D -> CAN FD data frame (with BRS/ESI flags!)
> k/K -> set FD data bitrates (analogue to s/S)
>=20
> The biggest problem with defining these values/characters and adding =
them to the slcan driver in the Linux kernel, is that WE DO NOT KNOW =
whether future serial CAN FD interfaces will follow our suggestion.
>=20
> Usually you have a hardware providing an API/protocol and THEN the =
driver developers write the driver - and not the other way around ;-)
>=20

Heh. I can appreciate that.

I=E2=80=99m working with a MT7688 platform that only supports half =
duplex spi and looking for a low cost canfd solution for that platform. =
I=E2=80=99m not sure exactly if that prevents me from using an existing =
MCP251x driver or not but I=E2=80=99ve heard this is the case. There is =
also a software spi driver, spi-gpio-custom in openwrt that is an =
option.

The idea with slcan would be to use a SAM21 microcontroller with dual =
canfd controllers to provide canfd functionality, implementing the slcan =
client in the SAM21 firmware.

I=E2=80=99m still not sure what the best approach might be. I am =
hesitating to use a usb based adapter but that=E2=80=99s another option =
as well.

Thoughts?

Regards,
Chris



