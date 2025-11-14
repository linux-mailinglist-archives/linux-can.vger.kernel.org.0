Return-Path: <linux-can+bounces-5401-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901F7C5DEA1
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 16:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABCF426383
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5CD32E681;
	Fri, 14 Nov 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ZwowTvsH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E0932E141
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133434; cv=none; b=IzrK6dsQqMNGpnevT4VZak4oLH6kbGyrHCswE6WUQFwmrVh2bhGzPHr5kjJgzJMo+WjhifSeJoEfvwL0EuD+1lL0zxNCueAl7ohTAyTUOMLa5GySMrlLstnLiA7din25J8uR/nIGTMNZb3hey4zT7eFF4h7CqL6bfaGu54Ov5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133434; c=relaxed/simple;
	bh=wJPFLst4ZrtWgRpIw/mdvQKCmvtK9tTnHfK/Te0ijA0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=W10C5fZV6RkjbVXiPJliwMEzDRrzjjw7TVHRt0zlrxmBiHwSilTMXGcoCd5CvaVWzgH2Toju8DectVsYDpS1NSzC53e47JiipTQFlGZSLheDacT64aDa8utrIZWzxdHWyqdfhRrwbz+bsWUZJ0sQG8uvwNWxsrVMhdAUj9/XAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ZwowTvsH; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7B8DEDF85D6
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 16:17:07 +0100 (CET)
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 9923719F733;
	Fri, 14 Nov 2025 16:17:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1763133420;
	bh=wJPFLst4ZrtWgRpIw/mdvQKCmvtK9tTnHfK/Te0ijA0=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=ZwowTvsHjBh4gzuMaEreFj0BRHkW84yzz8QTSWC8UCFJJ2m/ytk/ZGrvoScHjt3gi
	 NowhNkgapgrXEKFLLP3jn8ecV2exAH7T2r2k9nl6xjUTql8g0zGRvRYexQFCYcYHSY
	 FHk4y/OVn34bkdgDh6w7Pl699u5DUl9FfU4nCj21r4l16UmpICk1/RKNR0eXkelYMG
	 3W2ewilgK9OLkeS7Tt1Zh31pcugU6fwxUSy98OSybJuoyA0FlOh6Mmg+ggemilYtjR
	 sXsPlaP6Fj5AcGalSVvCmRjAVVm9fwG0zHO/74CSrthDCTslpQHXnzURZQM4P3XqTk
	 JzG0uXVlHDLgA==
Date: Fri, 14 Nov 2025 16:17:00 +0100 (CET)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
	=?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@hms-networks.com>
Message-ID: <1567529787.640577701.1763133420441.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <13906d6a-34be-47ff-bedf-c25a2d755aba@hartkopp.net>
Subject: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC142 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hi,

If I may say so:

>> Why isn't=20
>>=20
>> 4. Providing only CC/XL bitrates =3D> ES on, TMS off=20
>>=20
>> a valid option?=20

It works... But when only CANXL controllers (all configured in this way) ar=
e stuck to the wire! They communicate in a kind of CANFD++ protocol that al=
lows the same (high) data rates but with 2KB frames.

When such 2KB CANXL frames are written to the bus, any CAN 2.0 controller w=
ill indicate frame errors, whereas a controller configured for CANFD will n=
ot be affected (no error or frames raised)

On the other hand, writing CANFD frames *without* BRS but DLC>8 is OK (the =
CANXL node reads them as CAN_CC frames of course) while writing CANFD frame=
s with BRS obviously turns to error on the bus. CAN 2.0 node turns into err=
or in every case.

Finally, writing CAN 2.0 frames is ok for everyone in that configuration.

I've tried to summarize all of this in the following tables:

CC/XL bitrates + ES=3Don TMS=3Doff
                  =20
CANXL1             CANXL2            CANFD1             CANFD2             =
CANCC
writes 2KB frames  reads 2KB frames  no error/no frame  no error/no frame  =
frm errors
reads DLC>8        reads DLC>8       writes DLC>8       reads DLC>8        =
not connected
frm errors         frm errors        writes DLC>8       frm errors         =
frm errors
reads frames       reads frames      reads frames       reads frames       =
writes frames

Once ES is turned off, then you obviously enters a new protocol, so communi=
cation is less mixed:

CC/XL bitrates + ES=3Doff TMS=3Doff

CANXL1             CANXL2            CANFD1             CANFD2             =
CANCC
writes 2KB frames  reads 2KB frames  no error/no frame  no error/no frame  =
not connected
stuff error        stuff error       writes DLC>8       reads DLC>8        =
not connected
stuff error        stuff error       reads frames       reads frames       =
writes frames

CC/XL bitrates + ES=3Doff TMS=3Don (aka pure CANXL)

CANXL1             CANXL2            CANFD1             CANFD2             =
CANCC
writes 2KB frames  reads 2KB frames  no error/no frame  no error/no frame  =
not connected
stuff error        stuff error       writes DLC>8       reads DLC>8        =
not connected
stuff error        stuff error       reads frames       reads frames       =
writes frames

Hope this helps,

-- St=C3=A9phane


----- Mail original -----=20

De: "Oliver Hartkopp" <socketcan@hartkopp.net>=20
=C3=80: "Vincent Mailhol" <mailhol@kernel.org>, "St=C3=A9phane Grosjean" <s=
tephane.grosjean@hms-networks.com>=20
Cc: linux-can@vger.kernel.org=20
Envoy=C3=A9: Mardi 11 Novembre 2025 15:12:56=20
Objet: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL=20

Hi Vincent,=20

On 10.11.25 22:22, Vincent Mailhol wrote:=20
> On 09/11/2025 at 22:07, Oliver Hartkopp wrote:=20
>> I've been playing with the PEAK CAN XL bitrate tool again and it gave me=
 a new=20
>> idea:=20
>>=20
>> There were settings for different bitrates and the belonging/resulting f=
lags for=20
>> TMS and ES (error-signalling).=20
>>=20
>> Staring at the options we have only three options for the CAN XL support=
 aka "xl=20
>> on":=20
>>=20
>> 1. Providing CC/FD/XL bitrates =3D> ES on, TMS off (mixed-mode)=20
>>=20
>> 2. Providing only CC/XL bitrates =3D> ES off, TMS off (CANXL-only)=20
>>=20
>> 3. Providing only CC/XL bitrates =3D> ES off, TMS on (CANXL-only)=20
>=20
> Why isn't=20
>=20
> 4. Providing only CC/XL bitrates =3D> ES on, TMS off=20
>=20
> a valid option?=20

I had an off-list discussion with St=C3=A9phane and other PEAK System exper=
ts=20
in June and the outcome was that CC/XL bitrates with ES on and TMS off=20
is possible (only with the PEAK CAN XL IP core!) but will result in a=20
nightmare for support teams.=20

The CAN bus will crash if it receives a CAN FD frame.=20

This is basically the same with the Bosch X_CAN IP core where you need=20
to enable CAN FD for performing the mixed-mode. What would you set as a=20
FD bitrate there? There is no "nothing" to be set into the registers.=20
You might set 2MBit/s as default but that might crash either when it=20
doesn't fit.=20

Looking back in our older discussions with St=C3=A9phane I found this:=20

https://lore.kernel.org/linux-can/DBAPR10MB41879125DC7369359E4AB256D467A@DB=
APR10MB4187.EURPRD10.PROD.OUTLOOK.COM/#t=20

St=C3=A9phane wrote:=20

---=20

According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL=20
flags are not mutually exclusive, so why introduce=20
CAN_CTRLMODE_XL_ERR_SIGNAL [2] when the combinations of CAN_CTRLMODE_FD=20
and CAN_CTRLMODE_XL would allow us to deduce this?=20

Indeed:=20

can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) =3D=3D=20

CAN_CTRLMODE_FD CANFD mode (n/a)=20
CAN_CTRLMODE_XL|CAN_CTRLMODE_FD mixed-CANXL =3D> error_signaling=3DON=20
CAN_CTRLMODE_XL pure-CANXL =3D> error_signaling=3DOFF=20

---=20

With the CAN_CTRLMODE_XL (pure-CANXL) the ES is always off and the TMS=20
becomes an option to be switched on (default off).=20

And the more I think about it, the more I would like to go for this=20
solution.=20

This setup covers all Bosch use-case slides and Bosch CAN XL IP core=20
documentations (e.g. with the 1.5.5.3 Operating Mode table).=20

And we can omit the introduction of the CAN_CTRLMODE_XL_ERR_SIGNAL flag=20
as this can be retrieved internally from CTRLMODE_XL and CAN_CTRLMODE_FD=20
to be set into the controller registers.=20

Not defining the FD bitrate in the mixed-mode causes more harm (to the=20
system and the CAN bus itself) than urging the user to define it. Even=20
if he doesn't use CAN FD frames.=20

In the (really unlikely) case that someone shows up with a valid=20
use-case (like len8_dlc) and separately wants to fiddle with the ES=20
flags, we might introduce such a flag later. But I bet this will not happen=
.=20

>> Therefore we only need "tms" as an additional option when xl is on.=20
>>=20
>> The error signalling "on" automatically results from the availability of=
 "fd on"=20
>> and the FD bitrate.=20
>>=20
>> Examples:=20
>>=20
>> 1. Providing CC/FD/XL bitrates =3D> ES on, TMS off=20
>>=20
>> ip link set can0 type can bitrate 500000 fd on dbitrate 2000000 xl on xb=
itrate=20
>> 4000000=20
>>=20
>> 2. Providing only CC/XL bitrates =3D> ES off, TMS off=20
>>=20
>> ip link set can0 type can bitrate 500000 xl on xbitrate 4000000=20
>>=20
>> 3. Providing only CC/XL bitrates =3D> ES off, TMS on=20
>>=20
>> ip link set can0 type can bitrate 500000 xl on xbitrate 10000000 tms on=
=20
>>=20
>> That's simple and provides only the needed switches, which makes=20
>> CAN_CTRLMODE_XL_ERR_SIGNAL obsolete in the netlink API.=20
>>=20
>> What do you think about this approach?=20
>=20
> What really bothers me here is that the ISO standard explicitly state tha=
t error=20
> signaling is a configurable option. Making this an implicit option would =
result=20
> in a somehow non-compliant implementation.=20

Yes. According to all the Bosch slides ES=3Don results in mixed-mode and=20
ES=3Doff results in CANXL-only. You need this bit to distinguish these two=
=20
operation modes when using CAN XL (mixed or pure).=20

The fact that we need an arbitration bitrate for the CANXL-only modes=20
does not imply we can send or receive CC frames (with ES off).=20

> I appreciate that for most of the use cases the error signaling can be in=
ferred=20
> from the other values, and this is what I tried to implement (c.f. the ta=
ble of=20
> default values which I put in my patch).=20
>=20
> But I want to leave room so that people who wants to push the standard to=
 its=20
> limits can.=20

Either CAN CC or CAN FD with ES=3Doff are marked as an "invalid=20
configuration" in the 1.5.5.3 Operating Mode table. And I'm pretty sure=20
the CAN XL inventor's implementation of the CAN XL IP core is compliant=20
with the standard here. Maybe the standard is unclear in this topic or=20
left some details.=20

What is your interpretation of the standard here?=20
What do you think has to be supported beyond the features that St=C3=A9phan=
e=20
and I suggest?=20

> I see this a bit like the can_frame->len8_dlc thing. Should you use DLCs =
greater=20
> than 8 in production code? Hell no! But I still want the implementation t=
o give=20
> me this option so that I can do my weird tests.=20

Ack. But so far I do not see such weird options. And introducing code=20
into the kernel there is no user for and that's potentially only adding=20
complexity in the API that might lead to misconfiguration is not=20
well-received.=20

Best regards,=20
Oliver

