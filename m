Return-Path: <linux-can+bounces-1163-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DDF94A55F
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 12:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE831C20434
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1191C823D;
	Wed,  7 Aug 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjDVbRYS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C59190077
	for <linux-can@vger.kernel.org>; Wed,  7 Aug 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026371; cv=none; b=DUmw/bI9n+0Z3xFoRsfslh3uc80iAjyNCD0e939KLmFQZvikhi0EV8ftHTTq5u121h1uWGDTRHuDB6E/dCceMbORbBMK2fqTla3djyZqxiv/wZTGFi4tBdngci3DG+dEjro1E0Xd6OAKn7LomGd73a342bpHq4SZNN+cKR7jFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026371; c=relaxed/simple;
	bh=u0+7atymIQTR5ashQDQvVoEy8dEmkeYdACkNqOsXOsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqvfMpS3lXScP+A7Tk7Dzaf3jN0LeYnLNrIAqCKHCk0B9TnYI3yhJXJtbwj/oVbm6S3MfxuLpWEzUo3+LWSVlSCxQbUIiBVmBFYqzB/CuATSAlkFaappgwpS8hQuTppmulCG3jiFwX6ngiSLh0nGUa0Q8RgN15LSxRjiv8sLY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjDVbRYS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a0b2924e52so948960a12.2
        for <linux-can@vger.kernel.org>; Wed, 07 Aug 2024 03:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723026369; x=1723631169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIET7ARXlNKcifpDPYP0bsdyVmrm9WpO/GMEiAt+m50=;
        b=UjDVbRYSPkj5aDv+VD1v7/uDcdhNPgDRvprL/n8Www22XqI5UKkDM+x7clYz+C9jkm
         0zDcEKTvrsi9qxnf64wQuLgGDJcgq8rfSPreFEAcxRQypCSRragwnYBZnn2pcZO5y65y
         5b1+6bzmWoBHnO22wAO8fLws9oQJassCLib3phx0nJxbH7ktyCe/x/JVMShprrPnXKNY
         /OPly6JwMGBrrT1GMySEI8nxspSXmnEoVkLUtj+FxGf5En+ESp6XIY2CFZW+7CpvKFra
         LR/9cuPGITHVJk2aGOmSznAls4HSKMm4tvgnsn7BVjS6AShII9ofzMKX8J/6LArQfhzi
         e87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723026369; x=1723631169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIET7ARXlNKcifpDPYP0bsdyVmrm9WpO/GMEiAt+m50=;
        b=XskElXjr1rCbqxwBGCa8vr1rxuyhECmUwbcfN8GewjWhT7pkWcnBor7+8666jEfcig
         fRGmhi7ZZ8jZF+25V54Xe3smTU5XRsEHkIRQY0Z8BtrZtl348p2nelst9tBWdXZ38M3k
         cRnQZSmh4zHGvuTdEgoK0+fb0E4zIEjA/qdSpDeR4LPKJPSl1/+mG5Zf78LFf43gPunf
         ZnvvUHi5tWYe3SojgvDljl37gjb6AnjlZFKvtjS/bvpwIS0i5BWjcnAET9pY+kpxgx9I
         o+ovHNzDZm9LlcmrPACgKne3flfyyVy+BQT1BU30kVg5DLj6Vn1IEDTvVV91HnwQVVgE
         m7Sg==
X-Gm-Message-State: AOJu0Yw2XimMpRomjP7xroQ6vDE0FLtbkkO7SEZvJNg3Ki9GN2uJHaJ2
	ludfDEhfYxy1MaNztf09EdnmvbtoMhENCcZikxHMvgy+w124iuor1xtudvKo3uU3+SDcpn69TC9
	o13W5Md5ED5ZEp4LK1vTWj2L4Nlo53lNq02Y=
X-Google-Smtp-Source: AGHT+IFM0SK5wFoTiTMj7dViHqpFzfJqn3BQLl/adaOVW6S3JOpREETfRvo4kx3Y5/+9UlEj4tyzEWJiWwmRSvTyejU=
X-Received: by 2002:a17:90a:a784:b0:2cd:3331:ebc7 with SMTP id
 98e67ed59e1d1-2cff93db999mr16874815a91.2.1723026369242; Wed, 07 Aug 2024
 03:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>
 <CAMZ6RqK00=EKvCR8XBW7Vre5tSxsrD41LuGObV_5e=hYOKdSSA@mail.gmail.com> <8b96193b-082e-4c7f-b8ba-666580aae3e6@st.oth-regensburg.de>
In-Reply-To: <8b96193b-082e-4c7f-b8ba-666580aae3e6@st.oth-regensburg.de>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Wed, 7 Aug 2024 12:25:57 +0200
Message-ID: <CAMZ6RqK1keG5EuFMOnVo5j0zyAWQSYsZhruHBQ_dUZdx5xEw6w@mail.gmail.com>
Subject: Re: [EXT] Re: Introducing new Kernel Module for CAN over IP Networks
To: Matthias Unterrainer <matthias.unterrainer@st.oth-regensburg.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, 
	Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>, 
	"nils.weiss@dissecto.com" <nils.weiss@dissecto.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat. 27 Jul. 2024 at 12:17, Matthias Unterrainer
<matthias.unterrainer@st.oth-regensburg.de> wrote:
> Hi Vincent,
>
> apologies for the late reply.

No problem. I am myself abroad until the end of August. My answers
will also be delayed.

> On 07-07-2024 17:23, Vincent Mailhol wrote:
> > Hi Matthias,
> >
> > On Fri. 5 Jul. 2024 at 02:47, Matthias Unterrainer
> > <matthias.unterrainer@st.oth-regensburg.de> wrote:
> >> Hi Linux-CAN Community,
> >>
> >> my name is Matthias and I recently developed a kernel module during my=
 Bachelor's thesis that allows for transferring CAN frames over IP networks=
, similar to userland tools like socketcand [0] or cannelloni [1].
> >>
> >> I wrote the thesis at dissecto GmbH [2], a german Startup that special=
izes in security diagnostics and analytics for embedded systems, primarily =
within the automotive industry.
> >>
> >> The idea behind the project is that dissecto has developed a hardware =
device that can be connected to a CAN bus and acts as an ethernet gateway t=
o the bus. It is capable of capturing the CAN traffic along with the corres=
ponding timestamps and send this data via UDP or it can receive CAN frames =
via UDP as well and pass them on to the CAN bus.
> >> This allows for remote interaction with a CAN bus, as well as an accur=
ate analyses of CAN traffic, as packets contain precise time stamps.
> >>
> >> An architectural design decision was to develop it as kernel module be=
cause of lower latencies and high throughput.
> >
> > Question: did you consider Packet MMAP?
> >
> >    https://docs.kernel.org/networking/packet_mmap.html
> >
> > Most of the overhead comes from the syscall context switch between the
> > user and kernel land and Packet MMAP is exactly designed to bypass
> > this. Actually, a few months ago, I started to rewrite the can-utils's
> > candump to use Packet MMAP, but I never finished it.
>
> No, at the time I did not consider Packet MMAP. From my understanding
> Packet MMAP is used for userspace applications. But the module has to
> modify the timestamps of the CAN frames as they appear on the interface,
> which, as far as I know, is not possible from userspace.
> Please correct me if I am mistaken, but because of that I do not think
> Packet MMAP or any userspace application for that matter could actually
> be used here.

Can you explain this in more detail? The precise CAN timestamps are
all available from the user land. Some drivers even have the hardware
timestamps as generated by the device. Why do you need to *modify* the
timestamps?

> >> For example, my measurements show that the average time it takes a CAN=
 frame to get processed by the module is just about 1/4 of the time it take=
s applications like socketcand or cannelloni.
> >>
> >> We have published the module on GitHub [3], and would appreciate your =
feedback and thoughts.
> >>
> >> If anyone is interested in this functionality for the same or similar =
use cases, please don't hesitate to contact us.
> >>
> >> Best regards
> >> Matthias Unterrainer

