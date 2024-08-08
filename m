Return-Path: <linux-can+bounces-1181-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C64AE94C319
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 18:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379DD1F220B1
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71D19049A;
	Thu,  8 Aug 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Lip2KV"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779418DF70
	for <linux-can@vger.kernel.org>; Thu,  8 Aug 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135961; cv=none; b=apdKUE8hxQtxU9CNAJUBUc7NWOmV79wvNNMX2m9gMhdEdQ/8EzYDd3d6MPZqRDAEfiHTEEJo4tF/z6807bk+ueBHpXDYhRJqsFQNiHZOBNs8XfWkjbYn3j0miED/SCulhPs7ijFxFl5afqyfSC2E/k2y2w+iF9v5x1XgtNHvpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135961; c=relaxed/simple;
	bh=G90SsTCUWCiHPcGypDFiaRgzp9udvgH+C1s87SgdFO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1EVg+0+nPWCZ5iN4t51ENUDYz/mbfte9l/L8G02VSl3mq27S3CHGBQcvFHi+M/38nqoTaVXX2VPpCrY1mYMMZZlbVa5yEfwAXTOgftIhwPkcujZqb94uzaZzQggv6/pCGrvJKoaEuvPniAMR/FcRLSl0CkJC2lUI6PfF4HDldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9Lip2KV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so401004b3a.0
        for <linux-can@vger.kernel.org>; Thu, 08 Aug 2024 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723135960; x=1723740760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZsr+sRXWfALUIaRxqxVsMACEMmeGqNvXil8Nxs3PP8=;
        b=Z9Lip2KVR9fP1e3kop+HodV5S+c8n3qwi6LQ5/cJ1Uj83qXTQJwzKLDO9+PSfHTT1f
         UBOFf8T7ruGoBnwPtZTMnVkbCYUU987LWhGv/4LDM1+YoWgxzzx88qyfGZRwRaPF7qDW
         x9N+HPahVpFqtloiaStdjoJwSUO3sj6+S6O7lpTDGfvSFTnBV5CrgG7wwmYhVka3vf81
         OIh9i2WnWosiMKEYdbhmMPrnPmL9d8esvx0XjSKW0UwsODSCdzHdxesmIFrFh64E5Tfb
         LysqmVp8b+J2iovviksHOQq0Hc238IepXoAoBaa9HtDf5CUiFFCB6uD/FnWcCE3eYdES
         8cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723135960; x=1723740760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZsr+sRXWfALUIaRxqxVsMACEMmeGqNvXil8Nxs3PP8=;
        b=mdAafoFs4f04/TeLPS7m/cfX2xppuFrNxjsULHRFjj1Y0WR2JLN9ueM2vt/9v39SNb
         CX82KLK75cx0KSvFy95bStKAqBUPQ8YZXWWp5Dncku1lTLs3wUifVhK+tjnZX6qKWS8D
         u9RP97u/JbOLdhyf50HEErwkEU+/Oz7sO+tClK2s0lcFr+aeGbY3jVDm6zZZ/J9WRMXz
         wXxjFARd1EIEypKbyw5B0WG9djEkKn6b7tIqs4ZzHcDyn5l9+KFCr6uQXuscmGw4sU/i
         8d3WzPjFEMqZoSSiAXnwPlo0KtNjnY6aFFqZv8Bhol49RWDGJz2HorkdKCr1pCe/R5fu
         IksQ==
X-Gm-Message-State: AOJu0Yyk5qWYc52AIp0WhnZEKJ1fcGxbJLcxy6IimQTj0Fw1rA6y7shP
	IjpfIedF2xR2tBhmSmIMmF+P7BPBW/mS3i4+jVoB8Tv2sF+q4Nkdl1zRQRgC8SV6c1UfYpWmPI0
	Rux1WivPc1qZv6RtdPzoDM1OIKX9W3EA94/o=
X-Google-Smtp-Source: AGHT+IF/mqeI48domJ8mxmRFnboYWAU7hOOMrrC6P4A8oZiH3oYDNkuGDxKelSnuZFLVOlpx5NE0IXCupQEQ51i/AEY=
X-Received: by 2002:a05:6a20:7f8c:b0:1c6:edfb:431f with SMTP id
 adf61e73a8af0-1c6fcfacf07mr3120475637.44.1723135959457; Thu, 08 Aug 2024
 09:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>
 <CAMZ6RqK00=EKvCR8XBW7Vre5tSxsrD41LuGObV_5e=hYOKdSSA@mail.gmail.com>
 <8b96193b-082e-4c7f-b8ba-666580aae3e6@st.oth-regensburg.de>
 <CAMZ6RqK1keG5EuFMOnVo5j0zyAWQSYsZhruHBQ_dUZdx5xEw6w@mail.gmail.com> <676d5a7a-643d-423d-bada-95f3ec95e4d5@st.oth-regensburg.de>
In-Reply-To: <676d5a7a-643d-423d-bada-95f3ec95e4d5@st.oth-regensburg.de>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Thu, 8 Aug 2024 18:52:26 +0200
Message-ID: <CAMZ6RqJTNQ34ooB_6kqpaNJfe+ZYoerDhJnHPRPzZrL8nbscpQ@mail.gmail.com>
Subject: Re: [EXT] Re: Introducing new Kernel Module for CAN over IP Networks
To: Matthias Unterrainer <matthias.unterrainer@st.oth-regensburg.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, 
	Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>, 
	"nils.weiss@dissecto.com" <nils.weiss@dissecto.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu. 8 Aug. 2024 at 15:18, Matthias Unterrainer
<matthias.unterrainer@st.oth-regensburg.de> wrote:
> On 07-08-2024 12:25, Vincent Mailhol wrote:
> > On Sat. 27 Jul. 2024 at 12:17, Matthias Unterrainer
> > <matthias.unterrainer@st.oth-regensburg.de> wrote:
> >> Hi Vincent,
> >>
> >> apologies for the late reply.
> >
> > No problem. I am myself abroad until the end of August. My answers
> > will also be delayed.
> >
> >> On 07-07-2024 17:23, Vincent Mailhol wrote:
> >>> Hi Matthias,
> >>>
> >>> On Fri. 5 Jul. 2024 at 02:47, Matthias Unterrainer
> >>> <matthias.unterrainer@st.oth-regensburg.de> wrote:
> >>>> Hi Linux-CAN Community,
> >>>>
> >>>> my name is Matthias and I recently developed a kernel module during =
my Bachelor's thesis that allows for transferring CAN frames over IP networ=
ks, similar to userland tools like socketcand [0] or cannelloni [1].
> >>>>
> >>>> I wrote the thesis at dissecto GmbH [2], a german Startup that speci=
alizes in security diagnostics and analytics for embedded systems, primaril=
y within the automotive industry.
> >>>>
> >>>> The idea behind the project is that dissecto has developed a hardwar=
e device that can be connected to a CAN bus and acts as an ethernet gateway=
 to the bus. It is capable of capturing the CAN traffic along with the corr=
esponding timestamps and send this data via UDP or it can receive CAN frame=
s via UDP as well and pass them on to the CAN bus.
> >>>> This allows for remote interaction with a CAN bus, as well as an acc=
urate analyses of CAN traffic, as packets contain precise time stamps.
> >>>>
> >>>> An architectural design decision was to develop it as kernel module =
because of lower latencies and high throughput.
> >>>
> >>> Question: did you consider Packet MMAP?
> >>>
> >>>     https://docs.kernel.org/networking/packet_mmap.html
> >>>
> >>> Most of the overhead comes from the syscall context switch between th=
e
> >>> user and kernel land and Packet MMAP is exactly designed to bypass
> >>> this. Actually, a few months ago, I started to rewrite the can-utils'=
s
> >>> candump to use Packet MMAP, but I never finished it.
> >>
> >> No, at the time I did not consider Packet MMAP. From my understanding
> >> Packet MMAP is used for userspace applications. But the module has to
> >> modify the timestamps of the CAN frames as they appear on the interfac=
e,
> >> which, as far as I know, is not possible from userspace.
> >> Please correct me if I am mistaken, but because of that I do not think
> >> Packet MMAP or any userspace application for that matter could actuall=
y
> >> be used here.
> >
> > Can you explain this in more detail? The precise CAN timestamps are
> > all available from the user land. Some drivers even have the hardware
> > timestamps as generated by the device. Why do you need to *modify* the
> > timestamps?
> >
>
> I have to modify the timestamps, because I want the CAN-frames to have
> the timestamps they had when they originally appeared on the "source"
> device, which is not the same device I am modifying the timestamps on.
>
> An example setup for this would be, that we have two devices and one of
> them, the "source" device, has a CAN-Bus we want to capture the traffic
> from.
> On that device we record the CAN-frames together with their timestamps.
> Then all of this is sent to the second device and recreated there.
> Meaning all the CAN-frames appear with the timestamps from when they
> originally appeared on the "source" device.
>
> I hope this makes it a bit clearer what I am trying to accomplish.

I think I now understand. Overall, what you are building is a CAN
tunnel over UDP. I looked at the other similar tunneling devices, for
example drivers/net/tun.c, but I can not find a precedent of a
tunneling device which would overwrite the timestamp with a remote
value. As far as I can see, the logic is that the timestamp represents
the moment the packet reaches the *device* (or the device driver in
case of software timestamps). The same logic applies to tunnel
devices. Usually, if you want the timestamps from a remote device, you
would capture the traffic (e.g. in a .pcap file) and get all the
timestamps for that.

I am not sure what your ultimate goal is. If you just want to let the
community know about your work, then it is ok as-is. Overall, this is
a nice student project.
If you want your work to be merged upstream, I think the architecture
should be adjusted to come with something more generice: a CAN tunnel
device capable of taking remote timestamps as an input. If such a
remote timestamp is added, maybe a new timestamp type would be needed?
Something like: SOF_TIMESTAMPING_RX_REMOTE or
SOF_TIMESTAMPING_RX_ORIGINE (c.f.
https://www.kernel.org/doc/html/latest/networking/timestamping.html)?
This way the user can choose between the timestamp from the tunnel
device or from the remove device.

But as I said, I could find no precedent even outside of the CAN
subsystem. So expect to see a lot of push back. You will probably have
to convince a lot of people of the need for this "remote timestamp".
If you want to proceed further with this work, I suggest you first ask
the net-dev mailing list opinion on whether such remote timestamping
makes sense to them.

> >>>> For example, my measurements show that the average time it takes a C=
AN frame to get processed by the module is just about 1/4 of the time it ta=
kes applications like socketcand or cannelloni.
> >>>>
> >>>> We have published the module on GitHub [3], and would appreciate you=
r feedback and thoughts.
> >>>>
> >>>> If anyone is interested in this functionality for the same or simila=
r use cases, please don't hesitate to contact us.
> >>>>
> >>>> Best regards
> >>>> Matthias Unterrainer

