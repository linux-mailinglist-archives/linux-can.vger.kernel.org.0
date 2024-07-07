Return-Path: <linux-can+bounces-952-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA83C92989E
	for <lists+linux-can@lfdr.de>; Sun,  7 Jul 2024 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A592811A3
	for <lists+linux-can@lfdr.de>; Sun,  7 Jul 2024 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707FEDC;
	Sun,  7 Jul 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW1mWt0L"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6338396
	for <linux-can@vger.kernel.org>; Sun,  7 Jul 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720365829; cv=none; b=lnSRFYefP5/ggLexgxlHSj/8ClWxjir07BPXBnv8RJxJPgQnHPYTlybG1eObLLwp6J4bNiocMGtvpThIfb3xRUr5Xwi9GPpaC3OPd9kJK/12sphbKvVXaCgxr6i5LcMmCCV9bhAmf9HLrbwrqSQuvSivKV9Z65uzjV+EqYFXqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720365829; c=relaxed/simple;
	bh=sod1PmEBr78qdgqYy727bjZzsJNVYu3lpybp133JCVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsX2hykrSVaQ3uWsiQfPlqcmTCzUrgUH0D/tUcOk8OnQkpYzQaQdPv8vCZ5aOSH9lXPxsV8T2XA+UMCfb/UvlT1TX5eA6EQGhopDKi7xbOxpb2H9a13PLLjhwow1IWziodXD1E/UvufDMdd+6cTy8ylZMOUD+un23ecYor1Zz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW1mWt0L; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eeea388a8eso133464139f.2
        for <linux-can@vger.kernel.org>; Sun, 07 Jul 2024 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720365827; x=1720970627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTa30AA3x+RpVHhmSsQdnbW3eaTkWSjUhnu9lIn9ZKs=;
        b=FW1mWt0LPIhm6fQwvgz4t5BWjFAM657qrExTvbahbZ0Ng6UokCPhkJc3aXRD5CuLab
         ysCs1zxJ+vpx4+kvCNwtGamfXdoGxgaFJjIcIrkNEIkoFEABthXoS4uSYI39c2y2ZspZ
         JMA06qEb8eEjhMSOG4wUiUz1kOkETWX9KBgqBT4+FvpQwnOWfQxesVznYeJevRKiux7M
         qO3SpvROozCdYf3QTV9s/0fAv/P6LGjUgwobsCo/GRi90kWo/VZ5xTL8Ly2/2NTEECHE
         56sR4RaXL0gLTlU5gTVNHM9oWTEZ7agl7BRfY+pUoic+CVuhW8ipdEeMw2iAaEaIRQha
         JUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720365827; x=1720970627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTa30AA3x+RpVHhmSsQdnbW3eaTkWSjUhnu9lIn9ZKs=;
        b=kBXGB+L1B2IPUNJw+q9oigB2fWP3f/lYKYrELcX5uZsjLcUNfPxlpaiWFrN0onBH+d
         uREut7++po8LiT+Aq+t8y1M/YhNPs5uy+O31UHxTbmwj+X5W0Z93f/TwFwu3MRkb/yJf
         w/rrPomlwV7tafgVkroeK+vGNbbKv3Civba4a4mDXyugOqYO3bWHjfGK1EuuZPMYdLXL
         dWXUQuOjtwgfpmmm1k1uV/aKNSfpGpn7eB+D2soUdNLAa3sF1yRBuhSqgQQM+sulgPv0
         SMN3IxL+SPzxNVLXHLwhBW1+SDMkPalO5ry4OismbGiqESUvlDqIFZMXdpWcXb/hqw0X
         Pxtw==
X-Gm-Message-State: AOJu0YzaP9GKA0zCaGwQtK48QaGfMeYCOA9JgWpY5CNLCwMh2XuHvY34
	5Os/JsuGA6TmQmBhit3v+YOs5Bbl6ITspNp8jxldjOner7XPZXsXfi7ZwopAMLLuS4RDm78/SA2
	1sKjgbTYm66EfPy3NGluyBCa1auY=
X-Google-Smtp-Source: AGHT+IFFSj5FbbPvClc4AWEP+otDziKPcv0jl4FCaTs3oNwDvFZ0RZXp8O3JDP78bOGufkTWp4DPJtfFndPwlBAUIsw=
X-Received: by 2002:a5d:8189:0:b0:7f6:1e9c:d6ea with SMTP id
 ca18e2360f4ac-7f66dea98d0mr1067350539f.5.1720365826947; Sun, 07 Jul 2024
 08:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>
In-Reply-To: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Mon, 8 Jul 2024 00:23:35 +0900
Message-ID: <CAMZ6RqK00=EKvCR8XBW7Vre5tSxsrD41LuGObV_5e=hYOKdSSA@mail.gmail.com>
Subject: Re: Introducing new Kernel Module for CAN over IP Networks
To: Matthias Unterrainer <matthias.unterrainer@st.oth-regensburg.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, 
	Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>, 
	"nils.weiss@dissecto.com" <nils.weiss@dissecto.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Fri. 5 Jul. 2024 at 02:47, Matthias Unterrainer
<matthias.unterrainer@st.oth-regensburg.de> wrote:
> Hi Linux-CAN Community,
>
> my name is Matthias and I recently developed a kernel module during my Ba=
chelor's thesis that allows for transferring CAN frames over IP networks, s=
imilar to userland tools like socketcand [0] or cannelloni [1].
>
> I wrote the thesis at dissecto GmbH [2], a german Startup that specialize=
s in security diagnostics and analytics for embedded systems, primarily wit=
hin the automotive industry.
>
> The idea behind the project is that dissecto has developed a hardware dev=
ice that can be connected to a CAN bus and acts as an ethernet gateway to t=
he bus. It is capable of capturing the CAN traffic along with the correspon=
ding timestamps and send this data via UDP or it can receive CAN frames via=
 UDP as well and pass them on to the CAN bus.
> This allows for remote interaction with a CAN bus, as well as an accurate=
 analyses of CAN traffic, as packets contain precise time stamps.
>
> An architectural design decision was to develop it as kernel module becau=
se of lower latencies and high throughput.

Question: did you consider Packet MMAP?

  https://docs.kernel.org/networking/packet_mmap.html

Most of the overhead comes from the syscall context switch between the
user and kernel land and Packet MMAP is exactly designed to bypass
this. Actually, a few months ago, I started to rewrite the can-utils's
candump to use Packet MMAP, but I never finished it.

> For example, my measurements show that the average time it takes a CAN fr=
ame to get processed by the module is just about 1/4 of the time it takes a=
pplications like socketcand or cannelloni.
>
> We have published the module on GitHub [3], and would appreciate your fee=
dback and thoughts.
>
> If anyone is interested in this functionality for the same or similar use=
 cases, please don't hesitate to contact us.
>
> Best regards
> Matthias Unterrainer

I "scrolled" through the code. Here are two quick feedbacks.



In struct can2eth_pkthdr:

> struct can2eth_pkthdr {
>     u32 magic;
>     u32 tv_sec;
>     u32 tv_nsec;
>     u16 seqno;
>     u16 size;
> };

If I understand correctly, these are big endian. In That case, use the
__be16 and __be32 types (c.f.
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/types.h#L=
37).
This will allow use to use sparse to check that all conversion are
done correctly:

  https://www.kernel.org/doc/html/latest/dev-tools/sparse.html

Also, you added the description of each of struct can2eth_pkthdr's
fields in the README.md. It is preferable to put it directly together
with the code, using the kernel-doc style:

  https://docs.kernel.org/doc-guide/kernel-doc.html



In ctem_setup_communications():

> int ctem_setup_communications(struct ctem_comm_handler *handler, int src_=
port,
>                   char **addrs, int num_addrs)
> {
>     struct sockaddr_in *addr;
>     u32 ip;
>     u16 port =3D 0;
>     int ret;
>     int i;
>
>     handler->dest_addrs =3D kmalloc(sizeof(struct sockaddr *), GFP_KERNEL=
);
>     if (!handler->dest_addrs) {
>         pr_err("Could not allocate destination addresses\n");
>         return -ENOMEM;
>     }
>
>     handler->last_seqno =3D 0;
>     handler->num_addrs =3D 0;
>
>     /* parse input ip addresses */
>     if (!num_addrs) {
>         addr =3D kmalloc(sizeof(struct sockaddr_in), GFP_KERNEL);
>         if (!addr) {
>             pr_err("Could not allocate ip addr\n");
>             return -ENOMEM;
>         }

You are doing a memory allocation here...

>         addr->sin_family =3D PF_INET;
>         addr->sin_port =3D htons(port);
>         addr->sin_addr.s_addr =3D INADDR_ANY;
>
>         handler->dest_addrs[0] =3D (struct sockaddr *)addr;
>
>         handler->num_addrs =3D 1;
>     } else {
>         for (i =3D 0; i < num_addrs; i++) {
>             ret =3D parse_ip_port(ip_addrs[i], &ip, &port);
>             if (ret) {
>                 pr_err("Invalid IP/port format: %s\n",
>                        ip_addrs[i]);
>             } else {
>                 pr_debug("Parsed IP: %pI4, Port: %u\n", &ip,
>                      port);
>                 addr =3D kmalloc(sizeof(struct sockaddr_in),
>                            GFP_KERNEL);
>                 if (!addr) {
>                     pr_err("Could not allocate ip addr\n");
>                     return -ENOMEM;
>                 }
>

... and here ...

>                 addr->sin_family =3D PF_INET;
>                 addr->sin_port =3D htons(port);
>                 addr->sin_addr.s_addr =3D ip;
>
>                 handler->dest_addrs[handler->num_addrs] =3D
>                     (struct sockaddr *)addr;
>                 handler->num_addrs++;
>             }
>         }
>     }
>
>     ret =3D ctem_setup_udp(handler, src_port);
>     if (ret)
>         return ret;
>
>     ret =3D msgbuilder_init(handler);
>     if (ret)
>         return ret;

... but here you directly return on those errors without freeing the
previously allocated memory. Is this OK?

Overall, it will probably be simpler to move your

  /* parse input ip addresses */

if/else block in a separate helper function.

>     handler->reception_thread =3D kthread_create(
>         ctem_reception_thread, handler, "ctem_reception_thread");
>     if (IS_ERR(handler->reception_thread)) {
>         pr_err("%s: Error creating reception thread\n", MODULE_NAME);
>         return PTR_ERR(handler->reception_thread);
>     }
>
>     return 0;
> }

> [0] https://github.com/linux-can/socketcand
> [1] https://github.com/mguentner/cannelloni
> [2] https://dissec.to
> [3] https://github.com/dissecto-GmbH/can2eth-kernel-module

Yours sincerely,
Vincent Mailhol

